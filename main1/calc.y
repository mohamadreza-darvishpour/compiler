%{
#include <stdio.h>
#include "calc.tab.h"
extern int yylex(); // Declare yylex
%}

%union {
    int ival;
}

%token <ival> INTEGER
%left '+' '-'
%left '*' '/'

%type <ival> exp

%{
void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}
%}



%%

calc: exp '\n'        { printf("Result: %d\n", $1); }
    | calc exp '\n' { printf("Result: %d\n", $2); }    
    | '\n'   {printf("nothing\n");}
    ;

exp : INTEGER        { $$ = $1; }

    | exp '+' exp    { $$ = $1 + $3; }
    | exp '-' exp    { $$ = $1 - $3; }
    | exp '*' exp    { $$ = $1 * $3; }
    | exp '/' exp    { 
                        if ($3 != 0) {
                            $$ = $1 / $3;
                        } else {
                            printf("Error: Division by zero\n");
                            yyerror("Error: Division by zero");
                        }
                    }
    | '(' exp ')'     { $$ = $2; }
    ;

%%



int main() {
    yyparse();
    return 0;
}
