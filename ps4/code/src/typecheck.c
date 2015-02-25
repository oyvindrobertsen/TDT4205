#include "typecheck.h"
extern int outputStage;

static int type_errors = 0;

int has_type_errors(){
    return type_errors;
}

void type_error(node_t* root){
    fprintf(stdout, "Type error at:\n");
    if(root != NULL){
        fprintf(stdout,"%s", root->nodetype.text);
        if(root->nodetype.index == EXPRESSION){
            fprintf(stdout," (%s)", root->expression_type.text);
        }
        fprintf(stdout,"\n");
    }
    type_errors++;
}

int equal_types(data_type_t a, data_type_t b){

    if(a.base_type == INT_TYPE || a.base_type == FLOAT_TYPE || a.base_type == BOOL_TYPE || a.base_type == STRING_TYPE){
        return a.base_type == b.base_type;
    }
    else if(a.base_type == ARRAY_TYPE){
        int equals = b.base_type == ARRAY_TYPE;
        equals = equals && (a.array_type == b.array_type);
        equals = equals && (a.n_dimensions == b.n_dimensions);
        if(!equals){
            return equals;
        }
        for(int i = 0; i < a.n_dimensions; i++){
            equals = equals && (a.dimensions[i] == b.dimensions[i]);
        }

        return equals;
    }
    else{
        return 0;
    }
}

data_type_t typecheck_default(node_t* root)
{
    for (int i = 0; i < root->n_children; i++) {
        node_t* child = root->children[i];
        if (child != NULL) {
            child->typecheck(child);
        }
    }
    return root->data_type;

}

data_type_t typecheck_expression(node_t* root)
{

    //You may need to add code at various places to complete this function

    if(outputStage == 10)
        printf( "Type checking expression %s\n", root->expression_type.text);

    if(root->n_children == 1){
        data_type_t child_type = root->children[0]->typecheck(root->children[0]);
        switch(root->expression_type.index){
            case UMINUS_E:
                if (!(child_type.base_type == INT_TYPE || child_type.base_type == FLOAT_TYPE)) {
                    type_error(root);
                }
                break;
            case NOT_E:
                if (child_type.base_type != BOOL_TYPE) {
                    type_error(root);
                }
                break;
            default:
                break;
        }
        return child_type;
    }
    else if(root->n_children > 1){
        data_type_t* return_bool = (data_type_t*)malloc(sizeof(data_type_t));
        return_bool->base_type = BOOL_TYPE;
        switch(root->expression_type.index)
        {
            case ADD_E: case SUB_E: case DIV_E: case MUL_E:
                {
                    data_type_t expr1_type = root->children[0]->typecheck(root->children[0]);
                    data_type_t expr2_type = root->children[1]->typecheck(root->children[1]);
                    if (!(equal_types(expr1_type, expr2_type) && 
                                (expr1_type.base_type == INT_TYPE || expr1_type.base_type == FLOAT_TYPE))) {
                        type_error(root);
                    }
                    return expr1_type;
                }
            case  LEQUAL_E: case GEQUAL_E: case GREATER_E: case LESS_E:
                {
                    data_type_t expr1_type = root->children[0]->typecheck(root->children[0]);
                    data_type_t expr2_type = root->children[1]->typecheck(root->children[1]);
                    if (!(equal_types(expr1_type, expr2_type) && 
                                (expr1_type.base_type == INT_TYPE || expr1_type.base_type == FLOAT_TYPE))) {
                        type_error(root);
                    }
                    return *(return_bool);
                }
            case AND_E: case OR_E:
                {
                    data_type_t expr1_type = root->children[0]->typecheck(root->children[0]);
                    data_type_t expr2_type = root->children[1]->typecheck(root->children[1]);
                    if (!(expr1_type.base_type == BOOL_TYPE && expr2_type.base_type == BOOL_TYPE)) {
                        type_error(root);
                    }
                    return expr1_type;
                }
            case EQUAL_E: case NEQUAL_E:
                {
                    data_type_t expr1_type = root->children[0]->typecheck(root->children[0]);
                    data_type_t expr2_type = root->children[1]->typecheck(root->children[1]);
                    if (!(equal_types(expr1_type, expr2_type) &&
                                (expr1_type.base_type == INT_TYPE 
                                 || expr1_type.base_type == FLOAT_TYPE 
                                 || expr1_type.base_type == BOOL_TYPE))) {
                        type_error(root);
                    }
                    return *(return_bool);
                }
            case FUNC_CALL_E: 
                {
                    function_symbol_t* func_sym = root->function_entry;
                    node_t* arg_list = root->children[1];
                    if (arg_list != NULL) {
                        if (arg_list->n_children == func_sym->nArguments) {
                            // Make sure argument types match parameter types
                            for (int i = 0; i < arg_list->n_children; i++) {
                                node_t* arg = arg_list->children[i];
                                data_type_t arg_type = arg->typecheck(arg);
                                data_type_t param_type = func_sym->argument_types[i];
                                if (!(equal_types(arg_type, param_type))) {
                                    type_error(root);
                                }
                            }
                        } else {
                            type_error(root);
                        }
                    } else if (func_sym->nArguments != 0) {
                        type_error(root);
                    }
                    return func_sym->return_type;
                }
            case ARRAY_INDEX_E:
                {
                    node_t* left_node = root->children[0];
                    if (left_node->nodetype.index == VARIABLE) {
                        if (left_node->entry->type.n_dimensions == 1) {
                            data_type_t* root_type = (data_type_t*)malloc(sizeof(data_type_t));
                            root_type->base_type = left_node->entry->type.array_type;
                            return *root_type;
                        } else {
                            // We don't want to modify the actual entry.
                            data_type_t* type_copy = (data_type_t*)malloc(sizeof(data_type_t));
                            memcpy(type_copy, &(left_node->entry->type), sizeof(data_type_t));
                            type_copy->n_dimensions -= 1;
                            type_copy->dimensions = (int*)malloc(sizeof(int)*type_copy->n_dimensions);
                            memcpy(
                                    type_copy->dimensions,
                                    &(left_node->entry->type.dimensions[1]), 
                                    sizeof(int) * type_copy->n_dimensions
                                  );
                            return *type_copy;
                        }
                    } else {
                        data_type_t left_type = left_node->typecheck(left_node);
                        if (left_type.base_type != ARRAY_TYPE) {
                            type_error(root);
                        } else {
                            if (left_type.n_dimensions == 1) {
                                data_type_t* root_type = (data_type_t*)malloc(sizeof(data_type_t));
                                root_type->base_type = left_type.array_type;
                                return *root_type;
                            } else {
                                left_type.n_dimensions -= 1;
                                int* dimensions_left_popped = (int*)malloc(sizeof(int)*left_type.n_dimensions);
                                for (int i = 1; i < left_type.n_dimensions + 1; i++) {
                                    dimensions_left_popped[i-1] = left_type.dimensions[i];
                                }
                                free(left_type.dimensions);
                                left_type.dimensions = dimensions_left_popped;
                                return left_type;
                            }
                        }
                    }
                }
                break;
            default:
                fprintf(stdout, "Undefined case.\n");
                break;
        }
    }
}

data_type_t typecheck_variable(node_t* root){
    return root->entry->type;
}

data_type_t typecheck_assignment(node_t* root)
{
    if(outputStage == 10){
        printf( "Type checking assignment\n");
    }

    data_type_t lhs_type = root->children[0]->typecheck(root->children[0]);
    data_type_t rhs_type = root->children[1]->typecheck(root->children[1]);
    if (!(equal_types(lhs_type, rhs_type))) { 
        type_error(root);
        return root->data_type;
    }
    return root->data_type;
}
