#include "generator.h"
#include "optimizer.h"
extern int outputStage; // This variable is located in vslc.c

int peephole = 1;

static uint32_t if_labels = 0; // increment after use
static uint32_t while_labels = 0; // increment after use
static uint32_t for_labels = 0;

static char
*lr = "lr", *r0 = "r0", *r1 = "r1", *r2 = "r2", *r3 = "r3",
    *fp = "fp", *sp = "sp", *r5 = "r5", *r6 = "r6",
    *d0 = "d0", *d1="d1", *s0 = "s0", *s1 = "s1", *pc = "pc";

static char* currentClass = NULL;


// Helper for concatenating strings
char* concat(char* s1, char* s2) {
    size_t len1 = strlen(s1);
    size_t len2 = strlen(s2);
    char* result = malloc(sizeof(char)*(len1 + len2 + 1));
    memcpy(result, s1, len1);
    memcpy(result+len1, s2, len2+1);
    return result;
}


/* Start and last element for emitting/appending instructions */
static instruction_t *start = NULL, *last = NULL;



// The counter used for the debug printing.
static int nodeCounter = 0;

/* Provided auxiliaries... */

static void instruction_append ( instruction_t *next )
{
    if ( start != NULL )
    {
        last->next = next;
        last = next;
    }
    else
        start = last = next;
}


void instruction_add ( opcode_t op, char *arg1, char *arg2, int off1, int off2 )
{
    instruction_t *i = (instruction_t *) malloc ( sizeof(instruction_t) );
    i->opcode = op;
    i->offsets[0] = off1; i->offsets[1] = off2;
    i->operands[0] = arg1; i->operands[1] = arg2;
    i->next = NULL;
    instruction_append ( i );
}

void instruction_add3 ( opcode_t op, char* arg1, char* arg2, char* arg3)
{
    instruction_t *i = (instruction_t *) malloc ( sizeof(instruction_t) );
    i->opcode = op;
    i->offsets[0] = 0; i->offsets[1] = 0;
    i->operands[0] = arg1; i->operands[1] = arg2; i->operands[2] = arg3;
    i->next = NULL;
    instruction_append ( i );
}





/*
 * Smart wrapper for "printf". 
 * Makes a comment in the assembly to guide.
 * Also prints a copy to the debug stream if needed.
 */
void tracePrint( const char * string, ... )
{
    va_list args;
    char buff[1000];
    char buff2[1000];
    // 
    va_start (args, string);
    vsprintf(buff, string, args);
    va_end (args);

    sprintf(buff2, "%d %s", nodeCounter++, buff);

    if( outputStage == 10 )
        fprintf(stderr, "%s", buff2);

    instruction_add ( COMMMENT, STRDUP( buff2 ), NULL, 0, 0 );
}


void gen_default ( node_t *root, int scopedepth)
{
    /* Everything else can just continue through the tree */
    if(root == NULL){
        return;
    }

    for ( int i=0; i<root->n_children; i++ )
        if( root->children[i] != NULL )
            root->children[i]->generate ( root->children[i], scopedepth );
}


void gen_PROGRAM ( node_t *root, int scopedepth)
{
    /* Output the data segment */
    if( outputStage == 12 )
        strings_output ( stdout );
    instruction_add ( STRING, STRDUP( ".text" ), NULL, 0, 0 );

    tracePrint("Starting PROGRAM\n");

    gen_default(root, scopedepth);//RECUR();

    print_start();


    /* TODO: Insert a call to the first defined function here */
    node_t *func_list = root->children[root->n_children -1];
    node_t *first_func = func_list->children[0];
    function_symbol_t *entry = first_func->function_entry;
    char buffer[100];
    sprintf(buffer, "_%s", entry->label);
    instruction_add ( BL, STRDUP(buffer), NULL, 0, 0 );

    tracePrint("End PROGRAM\n");

    print_end();


    if( outputStage == 12 )
        instructions_print ( stdout );
}



void gen_FUNCTION ( node_t *root, int scopedepth )
{
    gf(root, scopedepth);

}






void gen_DECLARATION_STATEMENT (node_t *root, int scopedepth)
{
    gd(root, scopedepth);
}


void gen_PRINT_STATEMENT(node_t* root, int scopedepth)
{
    tracePrint("Starting PRINT_STATEMENT\n");

    instruction_add(PUSH, r6, NULL, 0,0);
    instruction_add(POP, r6, NULL, 0,0);

    for(int i = 0; i < root->children[0]->n_children; i++){

        root->children[0]->children[i]->generate(root->children[0]->children[i], scopedepth);

        //Pushing the .INTEGER constant, which will be the second argument to printf,
        //and cause the first argument, which is the result of the expression, and is
        //allready on the stack to be printed as an integer
        base_data_type_t t = root->children[0]->children[i]->data_type.base_type;
        switch(t)
        {
            case INT_TYPE:
                instruction_add(STRING, STRDUP("\tmovw	r0, #:lower16:.INTEGER"), NULL, 0,0);
                instruction_add(STRING, STRDUP("\tmovt	r0, #:upper16:.INTEGER"), NULL, 0,0);
                instruction_add(POP, r1, NULL, 0,0);
                break;

            case FLOAT_TYPE:
                instruction_add(LOADS, sp, s0, 0,0);
                instruction_add(CVTSD, s0, d0, 0,0);
                instruction_add(STRING, STRDUP("\tfmrrd	r2, r3, d0"), NULL, 0,0);
                instruction_add(STRING, STRDUP("\tmovw	r0, #:lower16:.FLOAT"), NULL, 0,0);
                instruction_add(STRING, STRDUP("\tmovt	r0, #:upper16:.FLOAT"), NULL, 0,0);

                // And now the tricky part... 8-byte stack alignment :(
                // We have at least 4-byte alignment always.
                // Check if its only 4-byte aligned right now by anding that bit in the stack-pointer.
                // Store the answer in r5, and set the zero flag.
                instruction_add(STRING, STRDUP("\tandS	r5, sp, #4"), NULL, 0,0);
                // Now use the zero flag as a condition to optionally change the stack-pointer
                instruction_add(STRING, STRDUP("\tpushNE	{r5}"), NULL, 0,0);
                break;

            case BOOL_TYPE:
                instruction_add(POP, r1, NULL, 0,0);
                instruction_add(MOV, r0, "#0", 0,0);
                instruction_add(CMP, r0, r1, 0,0);
                instruction_add(MOV, r1, "#0", 0,0);
                instruction_add(MOVNE, r1, "#1", 0,0);

                instruction_add(STRING, STRDUP("\tmovw	r0, #:lower16:.INTEGER"), NULL, 0,0);
                instruction_add(STRING, STRDUP("\tmovt	r0, #:upper16:.INTEGER"), NULL, 0,0);

                break;

            case STRING_TYPE:
                instruction_add(POP, r0, NULL, 0,0);
                break;

            default:
                instruction_add(PUSH, STRDUP("$.INTEGER"), NULL, 0,0);
                fprintf(stderr, "WARNING: attempting to print something not int, float or bool\n");
                break;
        }

        instruction_add(BL, STRDUP("printf"), NULL,0,0);

        // Undo stack alignment.
        if(t == FLOAT_TYPE) {
            // Redo the zero flag test on r5, as it will give the same answer as the first test on sp.
            instruction_add(STRING, STRDUP("\tandS	r5, #4"), NULL, 0,0);
            // Conditionally remove the alignment. 
            instruction_add(STRING, STRDUP("\tpopNE	{r5}"), NULL, 0,0);
        }
    }

    instruction_add(MOVE32, r0, STRDUP("0x0A"), 0,0);
    instruction_add(BL, STRDUP("putchar"), NULL, 0,0);

    tracePrint("Ending PRINT_STATEMENT\n");
}


void gen_EXPRESSION ( node_t *root, int scopedepth )
{
    /*
     * Expressions:
     * Handle any nested expressions first, then deal with the
     * top of the stack according to the kind of expression
     * (single variables/integers handled in separate switch/cases)
     */
    tracePrint ( "Starting EXPRESSION of type %s\n", (char*) root->expression_type.text);

    switch(root->expression_type.index){

        case ARRAY_INDEX_E:
            ge(root, scopedepth);
            break;

        case NEW_E:
            ge(root, scopedepth);
            break;

        case FUNC_CALL_E:
            ge(root, scopedepth);
            break;



        default:
            switch(root->data_type.base_type){


                case FLOAT_TYPE:
                    gen_float_expression(root, scopedepth);
                    break;
                case INT_TYPE:
                    gen_int_expression(root, scopedepth);
                    break;
                case BOOL_TYPE:
                    {
                        switch(root->children[0]->data_type.base_type){

                            case FLOAT_TYPE:
                                gen_float_expression(root, scopedepth);
                                break;
                            case INT_TYPE:
                                gen_int_expression(root, scopedepth);
                                break;
                            case BOOL_TYPE:
                                gen_bool_expression(root, scopedepth);
                                break;
                            default:
                                fprintf(stderr, "This should never happen\n");
                                exit(-1);
                        }
                        break;
                    }
                default:
                    fprintf(stderr, "This should never happen\n");
                    exit(-1);

            }
            break;
    }

    tracePrint ( "Ending EXPRESSION of type %s\n", (char*) root->expression_type.text);
}

void gen_int_expression(node_t* root, int scopedepth)
{
    switch(root->expression_type.index){
        case UMINUS_E:
            {
                // Generate code for only child
                node_t* child = root->children[0];
                child->generate(child, scopedepth);
                // Pop result off of stack, negate it and place result on stack
                instruction_add(POP, r1, NULL, 0, 0);
                instruction_add(NEG, r1, r1, 0, 0);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }
        case ADD_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, perform addition, put result on stack
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(POP, r1, NULL, 0, 0);
                instruction_add3(ADD, r1, r1, r2);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }
        case SUB_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, perform addition, put result on stack
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(POP, r1, NULL, 0, 0);
                instruction_add3(SUB, r1, r1, r2);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }
        case MUL_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, perform addition, put result on stack
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(POP, r1, NULL, 0, 0);
                instruction_add3(MUL, r1, r1, r2);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }
        case DIV_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, perform addition, put result on stack
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(POP, r1, NULL, 0, 0);
                instruction_add3(DIV, r1, r1, r2);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }

        case LESS_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, compare, put 0 or 1 on stack correspondingly
                instruction_add(POP, r3, NULL, 0, 0);
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(MOV, r1, "#0", 0, 0);
                instruction_add(CMP, r2, r3, 0, 0);
                instruction_add(MOVLT, r1, "#1", 0, 0);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }

        case GREATER_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, compare, put 0 or 1 on stack correspondingly
                instruction_add(POP, r3, NULL, 0, 0);
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(MOV, r1, "#0", 0, 0);
                instruction_add(CMP, r2, r3, 0, 0);
                instruction_add(MOVGT, r1, "#1", 0, 0);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }

        case GEQUAL_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, compare, put 0 or 1 on stack correspondingly
                instruction_add(POP, r3, NULL, 0, 0);
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(MOV, r1, "#0", 0, 0);
                instruction_add(CMP, r2, r3, 0, 0);
                instruction_add(MOVGE, r1, "#1", 0, 0);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }

        case LEQUAL_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, compare, put 0 or 1 on stack correspondingly
                instruction_add(POP, r3, NULL, 0, 0);
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(MOV, r1, "#0", 0, 0);
                instruction_add(CMP, r2, r3, 0, 0);
                instruction_add(MOVLE, r1, "#1", 0, 0);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }

        case EQUAL_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, compare, put 0 or 1 on stack correspondingly
                instruction_add(POP, r3, NULL, 0, 0);
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(MOV, r1, "#0", 0, 0);
                instruction_add(CMP, r2, r3, 0, 0);
                instruction_add(MOVEQ, r1, "#1", 0, 0);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }

        case NEQUAL_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, compare, put 0 or 1 on stack correspondingly
                instruction_add(POP, r3, NULL, 0, 0);
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(MOV, r1, "#0", 0, 0);
                instruction_add(CMP, r2, r3, 0, 0);
                instruction_add(MOVNE, r1, "#1", 0, 0);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }
    }
}

//You are not required to implement this function/floating point functionality
void gen_float_expression(node_t* root, int scopedepth)
{
}


void gen_bool_expression(node_t* root, int scopedepth)
{
    switch(root->expression_type.index){
        case OR_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Compare each side with 0
                instruction_add(MOV, r1, "#0", 0, 0);
                instruction_add(POP, r3, NULL, 0, 0);
                instruction_add(POP, r2, NULL, 0, 0);
                // rhs
                instruction_add(CMP, r1, r3, 0, 0);
                instruction_add(MOVNE, r3, "#1", 0, 0);
                // lhs
                instruction_add(CMP, r1, r2, 0, 0);
                instruction_add(MOVNE, r2, "#1", 0, 0);

                // Add lhs and rhs thruthiness and cmp result
                instruction_add3(ADD, r2, r2, r3);
                instruction_add(PUSH, r2, NULL, 0 , 0);
                break;
            }

        case AND_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Compare each side with 0
                instruction_add(MOV, r1, "#0", 0, 0);
                instruction_add(POP, r3, NULL, 0, 0);
                instruction_add(POP, r2, NULL, 0, 0);
                // rhs
                instruction_add(CMP, r1, r3, 0, 0);
                instruction_add(MOVNE, r3, "#1", 0, 0);
                // lhs
                instruction_add(CMP, r1, r2, 0, 0);
                instruction_add(MOVNE, r2, "#1", 0, 0);

                // Add lhs and rhs thruthiness and cmp result
                instruction_add3(MUL, r2, r2, r3);
                instruction_add(PUSH, r2, NULL, 0 , 0);
                break;
            }

        case EQUAL_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, compare, put 0 or 1 on stack correspondingly
                instruction_add(POP, r3, NULL, 0, 0);
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(MOV, r1, "#0", 0, 0);
                instruction_add(CMP, r2, r3, 0, 0);
                instruction_add(MOVEQ, r1, "#1", 0, 0);
                instruction_add(PUSH, r1, NULL, 0, 0);
                
                break;
            }
        case NEQUAL_E:
            {
                node_t* lhs = root->children[0];
                node_t* rhs = root->children[1];
                // Generate code for rhs and lhs
                lhs->generate(lhs, scopedepth);
                rhs->generate(rhs, scopedepth);
                // Pop results off of stack, compare, put 0 or 1 on stack correspondingly
                instruction_add(POP, r3, NULL, 0, 0);
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(MOV, r1, "#0", 0, 0);
                instruction_add(CMP, r2, r3, 0, 0);
                instruction_add(MOVNE, r1, "#1", 0, 0);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }
        case NOT_E:
            {
                // Generate code for only child
                node_t* child = root->children[0];
                child->generate(child, scopedepth);
                // Truthy? If yes, put 0 on stack, else 1
                instruction_add(MOV, r1, "#0", 0, 0);
                instruction_add(POP, r2, NULL, 0, 0);
                instruction_add(CMP, r1, r2, 0, 0);
                instruction_add(MOVEQ, r1, "#1", 0, 0);
                instruction_add(PUSH, r1, NULL, 0, 0);
                break;
            }

    }
}


void gen_VARIABLE ( node_t *root, int scopedepth )
{
    gv(root, scopedepth);

}

void gen_CONSTANT (node_t * root, int scopedepth)
{
    gc(root, scopedepth);
}

void gen_ASSIGNMENT_STATEMENT ( node_t *root, int scopedepth )
{
    ga(root, scopedepth);
}

void gen_RETURN_STATEMENT ( node_t *root, int scopedepth )
{
    gr(root, scopedepth);
}


void gen_WHILE_STATEMENT ( node_t *root, int scopedepth )
{
    tracePrint ( "Starting WHILE_STATEMENT\n");

    char start_label[15];
    sprintf(start_label, "while_%d", while_labels++);
    instruction_add(LABEL, STRDUP(start_label), NULL, 0, 0);
    
    // Generate code for expression
    node_t* exp = root->children[0];
    exp->generate(exp, scopedepth);

    // Compare expression result with zero
    instruction_add(MOV, r1, "#0", 0, 0);
    instruction_add(POP, r2, NULL, 0, 0);
    instruction_add(CMP, r1, r2, 0, 0);
    
    char end_label[15];
    sprintf(end_label, "while_%d", while_labels++);
    instruction_add(BEQ, concat("_", end_label), NULL, 0, 0);

    // Generate loop body
    node_t* body = root->children[1];
    body->generate(body, scopedepth);

    instruction_add(B, concat("_", start_label), NULL, 0, 0);

    instruction_add(LABEL, STRDUP(end_label), NULL, 0, 0);


    tracePrint ( "End WHILE_STATEMENT\n");
}

void gen_FOR_STATEMENT ( node_t *root, int scopedepth )
{
    tracePrint ( "Starting FOR_STATEMENT\n");

    // Generate code for initial assignment statement
    node_t* assignment = root->children[0];
    assignment->generate(assignment, scopedepth);

    char start_label[15];
    sprintf(start_label, "start_for_%d", for_labels);
    char end_label[15];
    sprintf(end_label, "end_for_%d", for_labels++);

    // for-loop start label
    instruction_add(LABEL, STRDUP(start_label), NULL, 0, 0);
    
    // compare with terminal condition
    node_t* exp = root->children[1];
    exp->generate(exp, scopedepth);
    int offset = assignment->children[0]->entry->stack_offset;
    instruction_add(LDR, r2, fp, 0, offset);
    instruction_add(POP, r3, NULL, 0, 0);
    instruction_add(CMP, r2, r3, 0, 0);

    // branch to end label if iteration variable is greater than the result of the expression
    instruction_add(STRING, concat("    bge _", end_label), NULL, 0, 0);

    // loop body
    node_t* body = root->children[2];
    body->generate(body, scopedepth);

    // increment iteration variable
    offset = assignment->children[0]->entry->stack_offset;
    instruction_add(LDR, r2, fp, 0, offset); // r2 = assignment variable
    instruction_add(MOV, r3, "#1", 0, 0);
    instruction_add3(ADD, r2, r2, r3);
    instruction_add(STR, r2, fp, 0, offset);


    // branch to start label
    instruction_add(B, concat("_", start_label), NULL, 0, 0);

    // end label
    instruction_add(LABEL, STRDUP(end_label), NULL, 0, 0);

    tracePrint ( "End FOR_STATEMENT\n");
}


void gen_IF_STATEMENT ( node_t *root, int scopedepth )
{
    tracePrint ( "Starting IF_STATEMENT'\n");

    if (root->n_children == 2) {
        // Simple case of if-then-end
        // Generate code for expression
        node_t* exp = root->children[0];
        exp->generate(exp, scopedepth);
        // Compare result of expression to 0
        instruction_add(MOV, r1, "#0", 0, 0);
        instruction_add(POP, r2, NULL, 0, 0);
        instruction_add(CMP, r1, r2, 0, 0);
        char lbl[15];
        sprintf(lbl, "if_%d", if_labels++);
        instruction_add(BEQ, concat("_", lbl), NULL, 0, 0);
        // generate code for body
        node_t* stmt_list = root->children[1];
        stmt_list->generate(stmt_list, scopedepth);
        // add end label
        instruction_add(LABEL, STRDUP(lbl), NULL, 0, 0);
    } else {
        // if-then-else-end case
        // Generate code for expression
        node_t* exp = root->children[0];
        exp->generate(exp, scopedepth);
        // Compare result of expression to 0
        instruction_add(MOV, r1, "#0", 0, 0);
        instruction_add(POP, r2, NULL, 0, 0);
        instruction_add(CMP, r1, r2, 0, 0);

        char else_label[15];
        sprintf(else_label, "if_%d", if_labels++);
        char end_label[15];
        sprintf(end_label, "if_%d", if_labels++);


        instruction_add(BEQ, concat("_", else_label), NULL, 0, 0);

        // generate code for if-part
        node_t* stmt_list_if = root->children[1];
        stmt_list_if->generate(stmt_list_if, scopedepth);

        instruction_add(B, concat("_", end_label), NULL, 0, 0);
        
        instruction_add(LABEL, STRDUP(else_label), NULL, 0, 0);

        // generate code for else-part
        node_t* stmt_list_else = root->children[2];
        stmt_list_else->generate(stmt_list_else, scopedepth);

        instruction_add(LABEL, STRDUP(end_label), NULL, 0, 0);
    }

    tracePrint ( "End IF_STATEMENT\n");
}


static void
instructions_print ( FILE *stream )
{
    instruction_t *this = start;

    while ( this != NULL )
    {
        switch ( this->opcode ) // ARM
        {
            case PUSH:
                fprintf ( stream, "\tpush\t{%s}\n", this->operands[0] );
                break;

            case POP:
                fprintf ( stream, "\tpop\t{%s}\n", this->operands[0] );
                break;

            case MOVE32:
                fprintf ( stream, "\tmovw\t%s, #:lower16:%s\n",
                        this->operands[0], this->operands[1]
                        );
                fprintf ( stream, "\tmovt\t%s, #:upper16:%s\n",
                        this->operands[0], this->operands[1]
                        );
                break;

            case MOV:
                fprintf ( stream, "\tmov\t%s, %s\n", this->operands[0], this->operands[1] );
                break;


            case LDR:
                if ( this->offsets[0] == 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tldr\t%s, [%s]\n",
                            this->operands[0], this->operands[1]
                            );
                else if ( this->offsets[0] == 0 && this->offsets[1] != 0 )
                    fprintf ( stream, "\tldr\t%s, [%s, #%d]\n", 
                            this->operands[0], this->operands[1], this->offsets[1]
                            );
                else if ( this->offsets[0] != 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "ERROR, LOAD format not correct\n");
                break;

            case LOADS:
                if ( this->offsets[0] == 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tflds\t%s, [%s]\n",
                            this->operands[1], this->operands[0]
                            );
                else if ( this->offsets[0] != 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tflds\t%s, [%s, #%d]\n", 
                            this->operands[1], this->operands[0], this->offsets[0]
                            );
                else if ( this->offsets[0] == 0 && this->offsets[1] != 0 )
                    fprintf ( stream, "ERROR, LOAD format not correct\n");
                break;


            case STR:
                if ( this->offsets[0] == 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tstr\t%s, [%s]\n",
                            this->operands[0], this->operands[1]
                            );
                else if ( this->offsets[1] != 0 && this->offsets[0] == 0 )
                    fprintf ( stream, "\tstr\t%s, [%s, #%d]\n", 
                            this->operands[0], this->operands[1], this->offsets[1]
                            );
                else if ( this->offsets[0] == 0 && this->offsets[1] != 0 )
                    fprintf ( stream, "ERROR, STORE format not correct\n");
                break;

            case STORES:
                if ( this->offsets[0] == 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tfsts\t%s, [%s]\n",
                            this->operands[0], this->operands[1]
                            );
                else if ( this->offsets[0] != 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tfsts\t%s, [%s, #%d]\n", 
                            this->operands[0], this->operands[1], this->offsets[0]
                            );
                else if ( this->offsets[0] == 0 && this->offsets[1] != 0 )
                    fprintf ( stream, "ERROR, STORE format not correct\n");
                break;


            case MOVES:
                if ( this->offsets[0] == 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tmfcpys\t%s, %s\n",
                            this->operands[1], this->operands[0]
                            );
                else if ( this->offsets[0] != 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tError: NOT possible for ARM, use load/store\t%d(%s),%s\n",
                            this->offsets[0], this->operands[0], this->operands[1]
                            );
                else if ( this->offsets[0] == 0 && this->offsets[1] != 0 )
                    fprintf ( stream, "\tError: NOT possible for ARM, use load/store\t%s,%d(%s)\n",
                            this->operands[0], this->offsets[1], this->operands[1]
                            );
                break;

            case MOVED:
                if ( this->offsets[0] == 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tmfcpyd TODO\t%s,%s\n",
                            this->operands[1], this->operands[0]
                            );
                else if ( this->offsets[0] != 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tError: NOT possible for ARM, use load/store\t%s, [%s,#%d]\n",  
                            //this->offsets[0], this->operands[0], this->operands[1]   "\ldr\t%d(%s),%s\n",
                            this->operands[1], this->operands[0], this->offsets[0]
                            );
                else if ( this->offsets[0] == 0 && this->offsets[1] != 0 )
                    fprintf ( stream, "\tError: NOT possible for ARM, use load/store\t%s,%d(%s)\n",
                            this->operands[0], this->offsets[1], this->operands[1]
                            );
                break;

            case CVTSD:
                if ( this->offsets[0] == 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tfcvtds\t%s,%s\n",
                            this->operands[1], this->operands[0]
                            );
                else if ( this->offsets[0] != 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tfcvtds TODO\t%d(%s),%s\n",
                            this->offsets[0], this->operands[0], this->operands[1]
                            );
                else if ( this->offsets[0] == 0 && this->offsets[1] != 0 )
                    fprintf ( stream, "\tfcvtds TODO\t%s,%d(%s)\n",
                            this->operands[0], this->offsets[1], this->operands[1]
                            );
                break;



            case ADD:
                if ( this->operands[2] == NULL){
                    //Legacy support
                    fprintf ( stream, "\tadd\t%s, %s\n",
                            this->operands[1], this->operands[0]
                            );
                }
                else{
                    fprintf ( stream, "\tadd\t%s, %s, %s\n",
                            this->operands[0], this->operands[1], this->operands[2]
                            );
                }
                break;

            case FADD:
                if ( this->offsets[0] == 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tfadds\t%s, %s, %s\n",
                            this->operands[1], this->operands[1], this->operands[0]
                            );
                break;

            case SUB:
                if ( this->operands[2] == NULL )
                    fprintf ( stream, "\tsub\t%s, %s\n",
                            this->operands[1], this->operands[0]
                            );
                else{
                    fprintf ( stream, "\tsub\t%s, %s, %s\n",
                            this->operands[0], this->operands[1], this->operands[2]
                            );
                }
                break;

            case FSUB:
                if ( this->offsets[0] == 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tfsubs\t%s, %s, %s\n",
                            this->operands[1], this->operands[1], this->operands[0]
                            );
                else
                    fprintf ( stream, "Not supported...\tfsub\t%s, %s\n",
                            this->operands[1], this->operands[0]
                            );
                break;

            case MUL:
                fprintf(stream, "\tmul\t%s,%s,%s\n",
                        this->operands[0], this->operands[1], this->operands[2]);

                break;
            case FMUL:
                if ( this->offsets[0] == 0 )
                    fprintf ( stream, "\tfmuls\t %s, %s, %s\n", this->operands[1], this->operands[1], this->operands[0] ); 
                else
                    fprintf ( stream, "Not supported...\tfmul\t%d(%s)\n",
                            this->offsets[0], this->operands[0]
                            );
                break;
            case DIV:

                fprintf ( stream, "\tsdiv\t%s, %s, %s\n",
                        this->operands[0], this->operands[1], this->operands[2] );

                break;
            case FDIV:
                if ( this->offsets[0] == 0 &&  this->operands[1] == NULL)
                    fprintf ( stream, "\tfdivs\ts0, s0, %s\n", this->operands[0] );
                else  if ( this->offsets[0] == 0)
                    fprintf ( stream, "\tfdivs\t%s, %s, %s\n", this->operands[1], this->operands[1], this->operands[0] );
                else
                    fprintf ( stream, "\tidivl TODO\t%d(%s)\n",
                            this->offsets[0], this->operands[0]
                            );
                break;
            case NEG:
                fprintf ( stream, "\tneg\t%s, %s\n",
                        this->operands[0], this->operands[1] );
                break;
            case FNEG:
                fprintf ( stream, "\tfnegs\t%s, %s\n",
                        this->operands[0], this->operands[1] );
                break;
            case CMP:
                if ( this->offsets[0] == 0 && this->offsets[1] == 0 )
                    fprintf ( stream, "\tcmp\t%s,%s\n",
                            this->operands[0], this->operands[1]
                            );
                break;
            case FCMP:
                fprintf( stream, "\tfcmps\t%s,%s\n", this->operands[0], this->operands[1]);
                fprintf( stream, "\tvmrs APSR_nzcv, FPSCR\n");
                break;

            case MOVGT:
                fprintf(stream, "\tmovgt\t %s, %s\n", this->operands[0], this->operands[1]);
                break;
            case MOVGE:
                fprintf(stream, "\tmovge\t %s, %s\n", this->operands[0], this->operands[1]);
                break;
            case MOVLT:
                fprintf(stream, "\tmovlt\t %s, %s\n", this->operands[0], this->operands[1]);
                break;
            case MOVLE:
                fprintf(stream, "\tmovle\t %s, %s\n", this->operands[0], this->operands[1]);
                break;
            case MOVEQ:
                fprintf(stream, "\tmoveq\t %s, %s\n", this->operands[0], this->operands[1]);
                break;
            case MOVNE:
                fprintf(stream, "\tmovne\t %s, %s\n", this->operands[0], this->operands[1]);
                break;

            case BL:
                fprintf ( stream, "\tbl\t" );
                fprintf ( stream, "%s\n", this->operands[0] );
                break;
            case LABEL: 
                fprintf ( stream, "_%s:\n", this->operands[0] );
                break;

            case B:
                fprintf ( stream, "\tb\t%s\n", this->operands[0] );
                break;

            case BEQ:
                fprintf ( stream, "\tbeq\t%s\n", this->operands[0] );
                break;
            case BNE:
                fprintf ( stream, "\tbne\t%s\n", this->operands[0] );
                break;

            case STRING:
                fprintf ( stream, "%s\n", this->operands[0] );
                break;

            case COMMMENT:
                fprintf ( stream, "#%s", this->operands[0] );
                break;

            case NIL:
                break;

            default:
                fprintf ( stderr, "Error in instruction stream\n" );
                break;
        }
        this = this->next;
    }
}

void print_start(){
    // Start of assemlby program
    // Debug functions and system call wrappers
    instruction_add ( STRING,       STRDUP("debugprint:"), NULL, 0, 0 );
    instruction_add ( STRING,       STRDUP("\tpush {r0-r11, lr}"), NULL, 0, 0 );
    instruction_add ( STRING,       STRDUP("\tmovw	r0, #:lower16:.DEBUG"), NULL, 0, 0 );
    instruction_add ( STRING,       STRDUP("\tmovt	r0, #:upper16:.DEBUG"), NULL, 0, 0 );
    instruction_add ( BL, STRDUP("printf"), NULL, 0, 0 );
    instruction_add ( STRING,       STRDUP("\tpop {r0-r11, pc}"), NULL, 0, 0 );
    instruction_add ( STRING,       STRDUP("debugprint_r0:"), NULL, 0, 0 );
    instruction_add ( STRING,       STRDUP("\tpush {r0-r11, lr}"), NULL, 0, 0 );
    instruction_add ( MOV,         r1, r0, 0, 0 );
    instruction_add ( STRING,       STRDUP("\tmovw	r0, #:lower16:.DEBUGINT"), NULL, 0, 0 );
    instruction_add ( STRING,       STRDUP("\tmovt	r0, #:upper16:.DEBUGINT"), NULL, 0, 0 );
    instruction_add ( BL, STRDUP("printf"), NULL, 0, 0 );
    instruction_add ( STRING,       STRDUP("\tpop {r0-r11, pc}"), NULL, 0, 0 );
    instruction_add ( STRING,       STRDUP("_malloc:"), NULL, 0, 0 );
    instruction_add ( PUSH,			lr, NULL, 0,0);
    instruction_add ( PUSH,			fp, NULL, 0,0);
    instruction_add ( LDR,          r0, sp, 0, 8 );
    instruction_add ( BL, STRDUP("malloc"), NULL, 0, 0 );
    instruction_add ( POP, fp, NULL, 0,0);
    instruction_add ( STRING,       STRDUP("\tpop {pc}"), NULL, 0, 0 );

    // Setting up command line arguments
    instruction_add ( STRING,       STRDUP("main:"), NULL, 0, 0 );
    instruction_add ( PUSH,         lr, NULL, 0, 0 );
    instruction_add ( PUSH,         fp, NULL, 0, 0 );
    instruction_add ( MOV,         fp, sp, 0, 0 );
    instruction_add ( MOV,         r5, r0, 0, 0 );
    instruction_add3 ( SUB,         r5,r5, "#1" );
    instruction_add ( CMP, r5, "#0", 0,0);
    instruction_add ( BEQ,     STRDUP("noargs"), NULL, 0, 0 );
    instruction_add ( MOV,         r6, r1, 0, 0 );
    instruction_add ( STRING,       STRDUP("pusharg:"), NULL, 0, 0 );
    instruction_add( LDR, r0, r6, 0, 4);
    instruction_add3 ( ADD,          r6,r6,STRDUP("#4"));
    instruction_add ( MOV,         r1, STRDUP("#0"), 0, 0 );
    instruction_add ( MOV,         r2, STRDUP("#10"), 0, 0 );
    instruction_add ( BL,      STRDUP("strtol"), NULL, 0, 0 );
    instruction_add ( PUSH,         r0, NULL, 0, 0 );
    instruction_add3 ( SUB,         r5,r5, "#1" );
    instruction_add ( CMP, r5, "#0", 0,0);
    instruction_add ( BNE,     STRDUP("pusharg"), NULL, 0, 0 );
    instruction_add ( STRING,       STRDUP("noargs:"), NULL, 0, 0 );
}

void print_end(){
    instruction_add ( MOV,         sp, fp, 0, 0 );
    instruction_add ( POP,          fp, NULL, 0, 0 );
    instruction_add ( BL, STRDUP("exit"), NULL, 0, 0 );
    instruction_add ( STRING,  STRDUP(".end"), NULL, 0, 0 );
}

