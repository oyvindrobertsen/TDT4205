%{
/* This %{ ... %} section is code that is glued into the generated scanner. */
#include "parser.h"

extern int outputStage; // This variable is located in vslc.c
    #define RETURN_TOKEN(t) do {                                       \
        if ( outputStage == 1 )                                        \
            printf( "TOKEN ( %d,\t'%s' )\n", t, yytext );              \
        return t;                                                      \
    } while ( 0 )
    
%}

%option array
%option noyywrap
%option yylineno

DIGIT       [0-9]
ID          [a-zA-Z][a-zA-Z0-9_]*


%%
    /* Rules as per the vsl_spec.pdf. */

    /* We ignore whitespace. */
[ \t\n]+

    /* We do not generate tokens for comments. */ 
\/\/[^\n]+

    /* Keywords. */
FUNC                    { RETURN_TOKEN(FUNC); }
PRINT                   { RETURN_TOKEN(PRINT); }
RETURN                  { RETURN_TOKEN(RETURN); }
NEW                     { RETURN_TOKEN(NEW); }
IF                      { RETURN_TOKEN(IF); }
THEN                    { RETURN_TOKEN(THEN); }
ELSE                    { RETURN_TOKEN(ELSE); }
END                     { RETURN_TOKEN(END); }
WHILE                   { RETURN_TOKEN(WHILE); }
DO                      { RETURN_TOKEN(DO); }
FOR                     { RETURN_TOKEN(FOR); }
TO                      { RETURN_TOKEN(TO); }
INT                     { RETURN_TOKEN(INT); }
BOOL                    { RETURN_TOKEN(BOOL); }
FLOAT                   { RETURN_TOKEN(FLOAT); }
START                   { RETURN_TOKEN(START); }
VOID                    { RETURN_TOKEN(VOID); }
ARRAY                   { RETURN_TOKEN(ARRAY); }

    /* Operators */
":="                    { RETURN_TOKEN(ASSIGN); }
"+"                     { RETURN_TOKEN('+'); }
"-"                     { RETURN_TOKEN('-'); }
"*"                     { RETURN_TOKEN('*'); }
"/"                     { RETURN_TOKEN('/'); }
">"                     { RETURN_TOKEN('>'); }
"<"                     { RETURN_TOKEN('<'); }
"<="                    { RETURN_TOKEN(LEQUAL); }
">="                    { RETURN_TOKEN(GEQUAL); }
"=="                    { RETURN_TOKEN(EQUAL); }
"!="                    { RETURN_TOKEN(NEQUAL); }
"&&"                    { RETURN_TOKEN(AND); }
"||"                    { RETURN_TOKEN(OR); }
"!"                     { RETURN_TOKEN('!'); }

    /* Integers */
{DIGIT}+                { RETURN_TOKEN(INT_CONST); }

    /* Floats */
{DIGIT}+\.{DIGIT}+      { RETURN_TOKEN(FLOAT_CONST); }

    /* Boolean constants */
TRUE                    { RETURN_TOKEN(TRUE_CONST); }
FALSE                   { RETURN_TOKEN(FALSE_CONST); }

    /* Strings */
\"(\\.|[^\\"^\n])*\"    { RETURN_TOKEN(STRING_CONST); } /* Stolen shamelessly from ANSI C, disallow \n */

    /* Identifiers */
{ID}                    { RETURN_TOKEN(IDENTIFIER); }

    /* Punctuation */
"("                     { RETURN_TOKEN('('); }
")"                     { RETURN_TOKEN(')'); }
"["                     { RETURN_TOKEN('['); }
"]"                     { RETURN_TOKEN(']'); }
","                     { RETURN_TOKEN(','); }
";"                     { RETURN_TOKEN(';'); }

%%
