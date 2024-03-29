#include "vslc.h"

static char *outfile = NULL;
int outputStage = -1;

static void
options ( int argc, char **argv )
{
    int opt = 0;
    while ( opt != -1 )
    {
        opt = getopt ( argc, argv, "f:o:s:p" );
        switch ( opt )
        {
            case -1:    /* No more options */
                break;

            case 'p':
                peephole = 1;
                break;
                
            case 's': /* Select what to print */
                outputStage = (int) strtol( optarg, NULL, 0);
                break;

            case 'f':   /* Redirect input stream from file */{
                if ( freopen ( optarg, "r", stdin ) == NULL )
                {
                    fprintf (
                        stderr, "Could not open input file '%s'\n", optarg
                    );
                    exit ( EXIT_FAILURE );
                }
                                                             }
                break;

            case 'o':   /* Save filename, redirect stdout when src is ok */{
                outfile = ( STRDUP ( optarg ));
                if ( outfile != NULL )
                    {
                        if ( freopen ( outfile, "w", stdout ) == NULL )
                        {
                            fprintf ( stderr, "Could not open output file '%s'\n", outfile );
                            exit ( EXIT_FAILURE );
                        }
                        free ( outfile );
                    }
                }
                break;

            default:    /* Got some option we don't recognize */
                fprintf ( stderr,
                    "Usage: %s [-p] [-v #] [-f infile] [-o] outfile [-t num]\n", argv[0]
                );
                exit ( EXIT_FAILURE );
        }

    }
}


int
main ( int argc, char **argv )
{
    outputStage = 12;

    options ( argc, argv );

    symtab_init ();
    
    /* In order to only scan the tokens we call yylex() directly */
    if ( outputStage == 1 ) {
    	do { } while ( yylex() );
        exit(0);
    }
    
    /* The parser calls yylex(), match the rules and builds the abstract syntax tree */
    yyparse();
    if ( outputStage == 2 ) { 
        exit(0);
    }
    
    /* Print the abstract syntax tree */
    if ( outputStage == 3 ) {
        node_print ( stdout, root, 0 );
        exit(0);
    }


    /* Assign nodes functions according to their type */
    assignFunctionsToNodes( root );


    /* Simplify the abstract syntax tree */
    root->simplify( root, 0 );
    if ( outputStage == 4 ) { 
        exit(0);
    }

    /* Print the abstract syntax tree after simplification */
    if ( outputStage == 5 ) {
        node_print ( stdout, root, 0 );
        exit(0);
    }

    /* Print nodes encountered during bind names traversal, and interaction with symbol tables */
    root->bind_names( root, 0);
    if ( outputStage == 6 || outputStage == 7) {
        exit(0);
    }
    
    /* Print the .data (strings) segment of the assembly file */
    if ( outputStage == 8) {
        strings_output(stdout);
        exit(0);
    }
    
    /* Print the entries and string indexes in the node tree */
    if ( outputStage == 9) {
        node_print_entries ( stdout, root, 0 );
        exit(0);
    }
    
    /* Type checking */
    root->typecheck(root);
    //int type_errors = has_type_errors();
    //if(type_errors > 0){
    //	fprintf(stderr, "Found %d type errors, exiting\n", type_errors);
    //	exit(-1);
    //}
    if (outputStage == 10) {
    	exit(0);
    }

    
    symtab_finalize();
    yylex_destroy(); // Free internal data structures of the scanner.

    exit ( EXIT_SUCCESS );
}
