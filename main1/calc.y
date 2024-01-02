%{
#include <stdio.h>
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
%token IF ELSE WHILE RETURN 
%left '+' '-'
%left '*' '/'
%left PLUS MINUS 
%left  TIMES DIVIDE

%token IDENTIFIER
%token  EQ NEQ LT GT LTE GTE PLUS MINUS TIMES DIVIDE ASSIGN LPAREN RPAREN SEMICOLON
%type <ival> exp
%nonassoc UMINUS 
%token 
%token BOOL BREAK CASE CHAR CONST CONTINUE DEFAULT DOUBLE ELSE FALSE FUNCTION FLOAT FOR IF OUTPUT INT LONG OUTPUT RETURN SIZEOF STRING SWITCH TRUE

%{
void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}
%}



%%
calc: exp '\n'        { printf("Result1: %d\n", $1); }
    |calc exp '\n'       { printf("Result5: %d\n", $2); }
    |calc '\n'       { printf("Result6:**continue** \n"); }
    
    ;

exp : INTEGER        { $$ = $1;printf("Result3: %d\n", $$);}

    | exp PLUS exp     { $$ = $1 + $3; printf("Result4: %d\n", $$);}
    ;


%%



int main() {
    yyparse();
    return 0;
}
