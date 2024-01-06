%{
#include <stdio.h>
#include <stdlib.h>
#include "calc.tab.h"
extern int yylex(); // Declare yylex
%}

%union {
    int ival;
    char* str;
    int num;
}
%token <str> str 
%token <ival> num 
%token <ival> NUMBER
%token <ival> INTEGER

%left '+' '-'
%left '*' '/'
%left PLUS MINUS
%right TIMES DIVIDE 

%token IDENTIFIER
%token  EQ NEQ LT GT LTE GTE PLUS MINUS TIMES DIVIDE ASSIGN LPAREN RPAREN SEMICOLON
%type <ival> exp
%nonassoc UMINUS 
%token BOOL BREAK CASE CHAR CONST CONTINUE DEFAULT DOUBLE ELSE FALSE FUNCTION FLOAT FOR IF  INT LONG OUTPUT RETURN SIZEOF STRING SWITCH TRUE
%token EOL


%{
void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}
%}



%%

calc: exp   EOL          { printf("Result0: %d\n", $1); }
    |calc exp EOL        {printf("Result6: %d\n", $2);}
    ;

exp : INTEGER        { $$ = $1; printf("Result1: %d\n", $1);}
    | exp PLUS exp    { $$ = $1 + $3; printf("Result2: %d\n",  $$); }
    | exp MINUS exp { $$ = $1 - $3; printf("Result3: %d\n",  $$);}
    | exp TIMES exp { $$ = $1 * $3; printf("Result4: %d\n",  $$);}
    | exp DIVIDE exp { 
        if ($3 == 0) {
            fprintf(stderr, "Error: Division by zero\n");
            exit(EXIT_FAILURE);
        }
        $$ = $1 / $3;printf("Result5: %d\n", $$);
    }
    | LPAREN exp RPAREN { $$ = $2; }
    ;


%%



int main() {
    yyparse();
    return 0;
}
