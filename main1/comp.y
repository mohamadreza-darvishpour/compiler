%{
#include <stdio.h>
#include <stdlib.h>
#include "comp.tab.h"
extern int yylex(); // Declare yylex
extern YYSTYPE yylval;
int id_num ; 
 
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
%token DEFINE INPUT
%type <IDENTIFIER> var_define


%{
void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}
%}



%%

program: /* empty */
       | program statement SEMICOLON
       ;

statement: exp           { printf("%d\n", $1); }
         | input         { }
         | output exp    { printf("%d\n", $2); }
         | func_decl     { }
         | func_call     { }
         |var_define    {}
         |var_read       {}
         ;
var_define: IDENTIFIER  EQ  INTEGER SEMICOLON {id_num = $3;}
var_read:   OUTPUT '(' IDENTIFIER  ')' SEMICOLON {printf("***22**%d\n", id_num);}

func_decl: DEFINE IDENTIFIER '(' ')' '{' program '}'
            |DEFINE IDENTIFIER '(' ')' '{' EOL program '}'

func_call: IDENTIFIER '(' ')' EOL
         ;

input: INPUT IDENTIFIER { }
      ;

output: OUTPUT { }
       ;

exp: INTEGER          { $$ = $1; }
   | exp PLUS exp      { $$ = $1 + $3; }
   | exp MINUS exp      { $$ = $1 - $3; }
   | exp TIMES exp      { $$ = $1 * $3; }
   | exp DIVIDE exp      { $$ = $1 / $3; }
   | '(' exp ')'      { $$ = $2; }
   | MINUS exp %prec UMINUS { $$ = -$2; }
   ;

%%



int main() {
    yyparse();
    return 0;
}
