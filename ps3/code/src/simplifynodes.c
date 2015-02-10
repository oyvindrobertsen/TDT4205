#include "simplifynodes.h"

extern int outputStage; // This variable is located in vslc.c

Node_t* simplify_default ( Node_t *root, int depth )
{
    for (int i = 0; i < root->n_children; i++) {
        Node_t* child = root->children[i];
        if (child != NULL) {
            root->children[i] = child->simplify(child, depth+1);
        }
    }
    return root;
}


Node_t *simplify_types ( Node_t *root, int depth )
{
    if(outputStage == 4)
        printf( "%*cSimplify %s \n", depth, ' ', root->nodetype.text );
    for (int i = 0; i < root->n_children; i++) {
        Node_t* child = root->children[i];
        if (child != NULL) {
            root->children[i] = child->simplify(child, depth+1);
        }
    }
    if (root->data_type.base_type == ARRAY_TYPE) {
        root->data_type.array_type = root->children[0]->data_type.base_type;
        Node_t* index_list = root->children[1];
        int* dimensions = malloc(sizeof(int)*index_list->n_children);
        for (int i = 0; i < index_list->n_children; i++) {
            dimensions[i] = root->children[1]->children[i]->int_const;
        }
        root->data_type.dimensions = dimensions;
        root->data_type.n_dimensions = index_list->n_children;
        free(root->children);
        root->n_children = 0;
    }
    return root;
}


Node_t *simplify_function ( Node_t *root, int depth )
{
    if(outputStage == 4)
        printf( "%*cSimplify %s \n", depth, ' ', root->nodetype.text );
    Node_t** new_children = malloc(sizeof(node_t)*2);
    int new_n_children = 0;
    for (int i = 0; i < root->n_children; i++) {
        Node_t* child = root->children[i];
        if (child != NULL) {
            child = child->simplify(child, depth+1);
            if (child->nodetype.index == VARIABLE) {
                root->label = STRDUP(child->label);
                free(child);
            } else if (child->nodetype.index == TYPE) {
                root->data_type = child->data_type;
                free(child);
            } else {
                new_children[new_n_children++] = child;
            }
        } else {
            new_children[new_n_children++] = child;
        }
    }
    free(root->children);
    root->children = new_children;
    root->n_children = new_n_children;
    return root;
}




Node_t *simplify_declaration_statement ( Node_t *root, int depth )
{
    if(outputStage == 4)
        printf( "%*cSimplify %s \n", depth, ' ', root->nodetype.text );
    // Simplify type
    Node_t* type_node = root->children[0];
    type_node = type_node->simplify(type_node, depth+1);
    root->data_type = type_node->data_type;
    // Hoist label
    root->label = root->children[1]->label;
    // Cleanup
    free(root->children);
    root->n_children = 0;
    return root;
}


Node_t *simplify_single_child ( Node_t *root, int depth )
{
    if(outputStage == 4)
        printf( "%*cSimplify %s \n", depth, ' ', root->nodetype.text );
    if (root->n_children == 1) {
        Node_t* node = root->children[0];
        node = node->simplify(node, depth+1);
        free(root->children);
        free(root);
        return node;
    } else {
        return root;
    }
}

Node_t *simplify_list_with_null ( Node_t *root, int depth )
{
    if(outputStage == 4)
        printf( "%*cSimplify %s \n", depth, ' ', root->nodetype.text );
    for (int i = 0; i < root->n_children; i++) {
        Node_t* child = root->children[i];
        if (child == NULL) {
            continue;
        }
        root->children[i] = child->simplify(child, depth+1);
    }
    if (root->children[0] == NULL) {
        Node_t** new_children = malloc(sizeof(Node_t*));
        new_children[0] = root->children[1];
        free(root->children);
        root->children = new_children;
        root->n_children = 1;
        return root;
    }
    int new_n_children = root->children[0]->n_children + 1;
    Node_t** new_children = malloc(sizeof(Node_t*)*new_n_children);
    for (int i = 0; i < root->children[0]->n_children; i++) {
        new_children[i] = root->children[0]->children[i];
    }
    new_children[new_n_children-1] = root->children[1];
    free(root->children);
    root->children = new_children;
    root->n_children = new_n_children;
    return root;
}


Node_t *simplify_list ( Node_t *root, int depth )
{
    if(outputStage == 4)
        printf( "%*cSimplify %s \n", depth, ' ', root->nodetype.text );
    for (int i = 0; i < root->n_children; i++) {
        Node_t* child = root->children[i];
        if (child == NULL) {
            continue;
        }
        root->children[i] = child->simplify(child, depth+1);
    }
    if (root->n_children == 1) {
        return root;
    }
    Node_t* func_list_node = root->children[0];
    int new_n_children = func_list_node->n_children + 1;
    Node_t** new_children = malloc(sizeof(Node_t*)*new_n_children);
    for (int i = 0; i < func_list_node->n_children; i++) {
        new_children[i] = func_list_node->children[i];
    }
    new_children[new_n_children-1] = root->children[1];
    free(root->children);
    root->children = new_children;
    root->n_children = new_n_children;
    return root;
}


Node_t *simplify_expression ( Node_t *root, int depth )
{
    if(outputStage == 4)
        printf( "%*cSimplify %s (%s) \n", depth, ' ', root->nodetype.text, root->expression_type.text );
    for (int i = 0; i < root->n_children; i++) {
        Node_t* child = root->children[i];
        if (child != NULL) {
            root->children[i] = child->simplify(child, depth+1);
        }
    }
    if (root->n_children == 1) {
        if (root->expression_type.index == NEW_E
                || root->expression_type.index == UMINUS_E
                || root->expression_type.index == NOT_E)
        {
            return root;
        } else {
            Node_t* single_child = root->children[0];
            free(root->children);
            free(root);
            return single_child;
        }
    }
    return root;
}

