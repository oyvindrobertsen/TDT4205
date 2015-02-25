#include "bindnames.h"
extern int outputStage; // This variable is located in vslc.c
char* thisClass;

//Solutions to last assignment, precompiled in bindsol.o
int bc(node_t* root, int stackOffset);
int bd(node_t* root, int stackOffset);

int bind_default ( node_t *root, int stackOffset)
{
    return bd(root, stackOffset);
}

int bind_function ( node_t *root, int stackOffset)
{
    if(outputStage == 6)
        printf( "FUNCTION: Start: %s\n", root->label);

    if (root->children[0] != NULL) {
        node_t* param_list = root->children[0];
        int param_count = param_list->n_children;
        int param_offset = 8 + (param_count * 4);
        param_list->bind_names(param_list, param_offset);
    }

    if (root->children[1] != NULL) { // Unlikely, but better safe than segfault
        node_t* statement_list = root->children[1];
        statement_list->bind_names(statement_list, stackOffset);
    }

    if(outputStage == 6)
        printf( "FUNCTION: End\n");

    return stackOffset;
}

function_symbol_t* create_function_symbol(node_t* function_node)
{
    function_symbol_t* func_sym = (function_symbol_t*)malloc(sizeof(function_symbol_t));
    func_sym->label = function_node->label;
    func_sym->return_type = function_node->data_type;
    if (function_node->children[0] != NULL) {
        func_sym->nArguments = function_node->children[0]->n_children;
        func_sym->argument_types = (data_type_t*)malloc(sizeof(data_type_t) * func_sym->nArguments);
        for (int i = 0; i < func_sym->nArguments; i++) {
            func_sym->argument_types[i] = function_node->children[0]->children[i]->data_type;
        }
    } else {
        func_sym->nArguments = 0;
    }
    return func_sym;
}

int bind_function_list ( node_t *root, int stackOffset)
{
    if(outputStage == 6)
        printf( "FUNCTION_LIST: Start\n");

    scope_add();

    for (int i = 0; i < root->n_children; i++) {
        node_t* child = root->children[i];
        // Let us not make any rash assumptions
        if (child != NULL && child->nodetype.index == FUNCTION) {
            function_symbol_t* func_sym = create_function_symbol(child);
            function_add(child->label, func_sym);
        }
    }

    for (int i = 0; i < root->n_children; i++) {
        node_t* child = root->children[i];
        if (child != NULL) {
            scope_add();
            child->bind_names(child, stackOffset);
            scope_remove();
        }
    }

    scope_remove();


    if(outputStage == 6)
        printf( "FUNCTION_LIST: End\n");

    return 0;
}

int bind_constant ( node_t *root, int stackOffset)
{
    return bc(root, stackOffset);
}


symbol_t* create_symbol(node_t* declaration_node, int stackOffset)
{
    symbol_t* symbol = (symbol_t*)malloc(sizeof(symbol_t));
    symbol->stack_offset = stackOffset;
    symbol->label = declaration_node->label;
    symbol->type = declaration_node->data_type;
    return symbol;
}

int bind_declaration ( node_t *root, int stackOffset)
{
    stackOffset = stackOffset - 4;
    if(outputStage == 6)
        printf( "DECLARATION: parameter/variable : '%s', offset: %d\n", root->label, stackOffset);
    symbol_t* symbol = create_symbol(root, stackOffset);
    symbol_insert(root->label, symbol);
    return stackOffset;
}

int bind_variable ( node_t *root, int stackOffset)
{
    if(outputStage == 6)
        printf( "VARIABLE: access: %s\n", root->label);

    root->entry = symbol_get(root->label);

    return stackOffset;

}

int bind_expression( node_t* root, int stackOffset)
{
    if(outputStage == 6)
        printf( "EXPRESSION: Start: %s\n", root->expression_type.text);

    if (root->expression_type.index == FUNC_CALL_E) {
        root->function_entry = function_get(root->children[0]->label);
        if (root->children[1] != NULL) {
            root->children[1]->bind_names(root->children[1], stackOffset);
        } 
    } else {
        for (int i = 0; i < root->n_children; i++) {
            node_t* child = root->children[i];
            if (child != NULL) {
                child->bind_names(child, stackOffset);
            }
        }
    }

    if(outputStage == 6)
        printf( "EXPRESSION: End\n");

    return stackOffset;
}


