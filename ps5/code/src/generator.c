#include "generator.h"
#include "optimizer.h"
extern int outputStage; // This variable is located in vslc.c
static char* currentClass = NULL;
int peephole = 1;

/* Registers */
// stackpointer = r13 = sp, framepointer = r11 / r7 = fp, linkregister (return address) = r14 = lr
static char
*lr = "lr", *r0 = "r0", *r1 = "r1", *r2 = "r2", *r3 = "r3", *r4 = "r4",
    *fp = "fp", *sp = "sp", *r5 = "r5", *r6 = "r6",
    *d0 = "d0", *d1="d1", *s0 = "s0", *s1 = "s1", *pc = "pc";


/* Start and last element for emitting/appending instructions */
static instruction_t *start = NULL, *last = NULL;


/* Support variables for nested while, for, if and continue.*/
node_t *continue_target;
char *continue_target_label;
int continue_target_depth;
static int while_count = 0;
static int for_count = 0;
static int if_count = 0;


// Helper for concatenating strings
char* concat(char* s1, char* s2) {
    size_t len1 = strlen(s1);
    size_t len2 = strlen(s2);
    char* result = malloc(sizeof(char)*(len1 + len2 + 1));
    memcpy(result, s1, len1);
    memcpy(result+len1, s2, len2+1);
    return result;
}

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


static void instruction_add ( opcode_t op, char *arg1, char *arg2, int off1, int off2 )
{
    instruction_t *i = (instruction_t *) malloc ( sizeof(instruction_t) );
    i->opcode = op;
    i->offsets[0] = off1; i->offsets[1] = off2;
    i->operands[0] = arg1; i->operands[1] = arg2;
    i->next = NULL;
    instruction_append ( i );
}

static void instruction_add3 ( opcode_t op, char* arg1, char* arg2, char* arg3)
{
    instruction_t *i = (instruction_t *) malloc ( sizeof(instruction_t) );
    i->opcode = op;
    i->offsets[0] = 0; i->offsets[1] = 0;
    i->operands[0] = arg1; i->operands[1] = arg2; i->operands[2] = arg3;
    i->next = NULL;
    instruction_append ( i );
}


static void instructions_finalize ( void ) {};


/*
 * Smart wrapper for "printf". 
 * Makes a comment in the assembly to guide.
 * Also prints a copy to the debug stream if needed.
 */
static void tracePrint( const char * string, ... )
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


    node_t* first_function = root->children[0]->children[0];
    if (first_function != NULL) {
        instruction_add(BL, concat("_", first_function->label), NULL, 0, 0);
    }

    tracePrint("End PROGRAM\n");

    print_end();

    if( outputStage == 12 )
        instructions_print ( stdout );
    instructions_finalize ();
}



void gen_FUNCTION ( node_t *root, int scopedepth )
{
    scopedepth++;
    tracePrint ( "Starting FUNCTION (%s) with depth %d\n", root->label, scopedepth);

    instruction_add(LABEL, STRDUP(root->label), NULL, 0, 0);
    instruction_add(PUSH, lr, NULL, 0, 0);
    instruction_add(PUSH, fp, NULL, 0, 0);
    instruction_add(MOV, fp, sp, 0, 0);

    gen_default(root, scopedepth); // Generate code for all statements in function

    instruction_add(MOV, sp, fp, 0, 0);
    instruction_add(POP, fp, NULL, 0, 0);
    instruction_add(POP, pc, NULL, 0, 0);

    tracePrint ("Leaving FUNCTION (%s) with depth %d\n", root->label, scopedepth);
    scopedepth--;
}


void gen_ARRAY(int nDimensions, int* dimensions) {
    if (nDimensions == 1) {
        // Base case, we allocate space for *dimension entries and put the addres on top of the stack
        int n_bytes = *dimensions * 4; // 4 bytes per array entry
        char str[15];
        sprintf(str, "%d", n_bytes);
        instruction_add(MOVE32, r1, STRDUP(str), 0, 0);
        instruction_add(PUSH, r1, NULL, 0, 0);
        instruction_add(BL, "_malloc", NULL, 0, 0);
        instruction_add(MOV, r1, "#4", 0, 0);
        instruction_add3(ADD, sp, sp, r1); // remove parameter pushed on stack
        instruction_add(PUSH, r0, NULL, 0, 0);
    } else {
        int n_bytes = *dimensions * 4;
        char str[15];
        sprintf(str, "%d", n_bytes);
        instruction_add(MOVE32, r1, STRDUP(str), 0, 0);
        instruction_add(PUSH, r1, NULL, 0, 0);
        instruction_add(BL, "_malloc", NULL, 0, 0);
        instruction_add(MOV, r1, "#4", 0, 0);
        instruction_add3(ADD, sp, sp, r1); // remove parameter pushed on stack
        instruction_add(PUSH, r0, NULL, 0, 0);
        int* new_dimensions = dimensions + 1; // ? not pretty
        for (int i = 0; i < *dimensions; i++) {
            gen_ARRAY(nDimensions-1, new_dimensions);
            // The recursive call will have pushed the address we want onto the stack
            instruction_add(POP, r2, NULL, 0 , 0);
            // Pop the base address for this array
            instruction_add(POP, r1, NULL, 0, 0);
            // Store the returned address of the subarray in the correct position
            char str2[15];
            sprintf(str2, "#%d", i);
            instruction_add(MOV, r4, STRDUP(str2), 0, 0);
            instruction_add(MOV, r5, STRDUP("#4"), 0, 0);
            instruction_add3(MUL, r3, r4, r5);
            instruction_add3(ADD, r3, r1, r3);
            instruction_add(STR, r2, r3, 0, 0);
            instruction_add(PUSH, r1, NULL, 0, 0);
        }
    }
}


void gen_DECLARATION_STATEMENT (node_t *root, int scopedepth)
{
    tracePrint("Starting DECLARATION: adding space on stack\n");

    // Push a 32-bit value onto the stack
    instruction_add(PUSH, r1, NULL, 0, 0);

    tracePrint("Ending DECLARATION\n");
}


void gen_EXPRESSION ( node_t *root, int scopedepth )
{
    tracePrint ( "Starting EXPRESSION of type %s\n", (char*) root->expression_type.text);

    et_number expr_type = root->expression_type.index;
    if (expr_type == FUNC_CALL_E) {
        int n_param = 0;
        if (root->children[1] != NULL) {
            node_t* expr_list = root->children[1];
            n_param = expr_list->n_children;
            // There is an expression list, generate code for each of the expressions
            // Since all arguments to a function will be expr-like, they will take care of putting values on the stack themselves
            for (int i = 0; i < expr_list->n_children; i++) {
                node_t* expr = expr_list->children[i];
                expr->generate(expr, scopedepth);
            }
            
        }
        // Jump to label
        instruction_add(BL, concat("_", root->children[0]->label), NULL, 0, 0);
        // Remove parameters from stack if there are any
        if (n_param != 0) {
            char str[15];
            sprintf(str, "#%d", 4*n_param);
            instruction_add(MOV, r1, STRDUP(str), 0, 0);
            instruction_add3(ADD, sp, sp, r1);
        }
        // Push return value onto stack
        instruction_add(PUSH, r0, NULL, 0, 0);
    } else if (expr_type == ARRAY_INDEX_E) {
        // Get base address from left child, offset from right
        node_t* left = root->children[0];
        node_t* right = root->children[1];
        left->generate(left, scopedepth);
        right->generate(right, scopedepth);
        instruction_add(POP, r2, NULL, 0, 0); // Pop offset into r2
        instruction_add(POP, r1, NULL, 0, 0); // Pop base into r1
        instruction_add(MOV, r3, "#4", 0, 0);
        instruction_add3(MUL, r2, r2, r3); // r2 = offset * 4
        instruction_add3(ADD, r1, r1, r2); // r1 = base + r2
        instruction_add(LDR, r1, r1, 0, 0); // Read from address
        instruction_add(PUSH, r1, NULL, 0, 0);
    } else if (expr_type == NEW_E) {
        gen_ARRAY(root->data_type.n_dimensions, root->data_type.dimensions);
    }
    tracePrint ( "Ending EXPRESSION of type %s\n", (char*) root->expression_type.text);
}


void gen_VARIABLE ( node_t *root, int scopedepth )
{
    tracePrint ( "Starting VARIABLE\n");

    // Get value of variable from stack entry, put on top of stack
    int offset = root->entry->stack_offset;
    instruction_add(LDR, r1, fp, 0, offset);
    instruction_add(PUSH, r1, NULL, 0, 0);

    tracePrint ( "End VARIABLE %s, depth difference: %d, stack offset: %d\n", root->label, 0, root->entry->stack_offset);
}


void gen_CONSTANT (node_t * root, int scopedepth)
{
    tracePrint("Starting CONSTANT\n");

    base_data_type_t const_type = root->data_type.base_type;
    switch (const_type) {
        case STRING_TYPE:
            {
                char str[15];
                sprintf(str, ".STRING%d", root->string_index);
                instruction_add(MOVE32, r1, STRDUP(str), 0, 0);
                break;
            }
        case INT_TYPE:
            {
                char str[15];
                sprintf(str, "%d", root->int_const);
                instruction_add(MOVE32, r1, STRDUP(str), 0, 0);
                break;
            }
        case BOOL_TYPE:
            {
                if (root->bool_const) {
                    instruction_add(MOV, r1, STRDUP("#1"), 0, 0);
                } else {
                    instruction_add(MOV, r1, STRDUP("#0"), 0, 0);
                }
                break;
            }
        case FLOAT_TYPE:
            {
                char str[30];
                sprintf(str, "0x%x", *(unsigned int*)&root->float_const); // Sourced from http://stackoverflow.com/questions/2941095/convert-ieee-754-float-to-hex-with-c-printf , not pretty but it works reasonably well
                instruction_add(MOVE32, r1, STRDUP(str), 0, 0);
            }
    }
    instruction_add(PUSH, r1, NULL, 0, 0);

    tracePrint("End CONSTANT\n");
}


void gen_ASSIGNMENT_STATEMENT ( node_t *root, int scopedepth )
{
    tracePrint ( "Starting ASSIGNMENT_STATEMENT\n");

    // Generate code for righ hand side
    node_t* rhs = root->children[1];
    rhs->generate(rhs, scopedepth);

    // Put value in temp register
    instruction_add(POP, r4, NULL, 0, 0);
    // Calculate address to store rhs in from lhs
    if (root->children[0]->expression_type.index == ARRAY_INDEX_E) {
        node_t* array_node = root->children[0];
        node_t* left = array_node->children[0];
        node_t* right = array_node->children[1];
        left->generate(left, scopedepth);
        right->generate(right, scopedepth);
        instruction_add(POP, r2, NULL, 0, 0); // Pop offset into r2
        instruction_add(POP, r1, NULL, 0, 0); // Pop base into r1
        instruction_add(MOV, r3, "#4", 0, 0);
        instruction_add3(MUL, r2, r2, r3); // r2 = offset * 4
        instruction_add3(ADD, r1, r1, r2); // r1 = base + r2
        instruction_add(STR, r4, r1, 0, 0); // Store rhs in address now present in r1
    } else {
        int offset = root->children[0]->entry->stack_offset;
        instruction_add(STR, r4, fp, 0, offset);
    }
    // Store rhs value in stack entry corresponding to lhs variable

    tracePrint ( "End ASSIGNMENT_STATEMENT\n");
}


void gen_RETURN_STATEMENT ( node_t *root, int scopedepth )
{
    tracePrint ( "Starting RETURN_STATEMENT\n");

    // Generate code what is to be returned
    node_t* rhs = root->children[0];
    rhs->generate(rhs, scopedepth);

    // Put resulting value in r0
    instruction_add(POP, r0, NULL, 0, 0);

    tracePrint ( "End RETURN_STATEMENT\n");
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
                instruction_add(STRING, STRDUP("\tmovw  r0, #:lower16:.INTEGER"), NULL, 0,0);
                instruction_add(STRING, STRDUP("\tmovt  r0, #:upper16:.INTEGER"), NULL, 0,0);
                instruction_add(POP, r1, NULL, 0,0);
                break;

            case FLOAT_TYPE:
                instruction_add(LOADS, sp, s0, 0,0);
                instruction_add(CVTSD, s0, d0, 0,0);
                instruction_add(STRING, STRDUP("\tfmrrd r2, r3, d0"), NULL, 0,0);
                instruction_add(STRING, STRDUP("\tmovw  r0, #:lower16:.FLOAT"), NULL, 0,0);
                instruction_add(STRING, STRDUP("\tmovt  r0, #:upper16:.FLOAT"), NULL, 0,0);

                // And now the tricky part... 8-byte stack alignment :(
                // We have at least 4-byte alignment always.
                // Check if its only 4-byte aligned right now by anding that bit in the stack-pointer.
                // Store the answer in r5, and set the zero flag.
                instruction_add(STRING, STRDUP("\tandS  r5, sp, #4"), NULL, 0,0);
                // Now use the zero flag as a condition to optionally change the stack-pointer
                instruction_add(STRING, STRDUP("\tpushNE        {r5}"), NULL, 0,0);
                break;

            case BOOL_TYPE:
                instruction_add(POP, r1, NULL, 0,0);
                instruction_add(MOV, r0, "#0", 0,0);
                instruction_add(CMP, r0, r1, 0,0);
                instruction_add(MOV, r1, "#0", 0,0);
                instruction_add(MOVNE, r1, "#1", 0,0);

                instruction_add(STRING, STRDUP("\tmovw  r0, #:lower16:.INTEGER"), NULL, 0,0);
                instruction_add(STRING, STRDUP("\tmovt  r0, #:upper16:.INTEGER"), NULL, 0,0);

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
            instruction_add(STRING, STRDUP("\tandS  r5, #4"), NULL, 0,0);
            // Conditionally remove the alignment. 
            instruction_add(STRING, STRDUP("\tpopNE {r5}"), NULL, 0,0);
        }
    }

    instruction_add(MOVE32, r0, STRDUP("0x0A"), 0,0);
    instruction_add(BL, STRDUP("putchar"), NULL, 0,0);

    tracePrint("Ending PRINT_STATEMENT\n");
}






static void instructions_print ( FILE *stream ) {
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
