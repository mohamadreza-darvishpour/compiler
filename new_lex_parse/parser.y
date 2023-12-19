/* calculator.y */
%{
#include <iostream>
using namespace std;

int yylex();  // Forward declaration, since we're not using a separate lexer
void yyerror(const char* s);
%}

%token NUM
%left '+' '-'
%left '*' '/'

%%

calc:   /* empty */
      | calc expr '\n'     { cout << "Result: " << $2 << endl; }
      ;

expr:   NUM                { $$ = $1; }
      | expr '+' expr     { $$ = $1 + $3; }
      | expr '-' expr     { $$ = $1 - $3; }
      | expr '*' expr     { $$ = $1 * $3; }
      | expr '/' expr     { $$ = $1 / $3; }
      | '(' expr ')'      { $$ = $2; }
      ;

%%

void yyerror(const char* s) {
    cerr << "Error: " << s << endl;
}

int main() {
    yyparse();  // Call the Bison-generated parser
    return 0;
}
