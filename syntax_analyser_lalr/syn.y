%{
#include <iostream>
#include "symb_char_table.h"
#include <vector>

// Define YYSTYPE to store additional information for each token
#define YYSTYPE TokenInfo

// Declare the lexer function and variables
extern int yylex();
extern int yyleng;
extern std::sym_table token_table;

// Function to get the next token from the token table
int getToken() {
    static size_t index = 0;
    if (index < token_table.size()) {
        yyleng = token_table[index].token.length();
        yylval = token_table[index];
        return token_table[index++].type;
    }
    return 0;  // Return 0 to indicate end of input
}

void yyerror(const char* s);

%}

%token NUMBER
%token PLUS
%token MINUS
%token MULTIPLY
%token DIVIDE
%token LPAREN
%token RPAREN
%token EOL

%left PLUS MINUS
%left MULTIPLY DIVIDE
%left UMINUS

%type <TokenInfo> expr

%%

statements:
    | statements statement EOL { std::cout << "Result: " << $2.token << std::endl; }
    | /* empty */
    ;

statement:
    expr                        { $$ = $1; }
    ;

expr:
    NUMBER                      { $$ = $1; }
    | expr PLUS expr             { $$ = $1; }
    | expr MINUS expr            { $$ = $1; }
    | expr MULTIPLY expr         { $$ = $1; }
    | expr DIVIDE expr           { $$ = $1; }
    | MINUS expr %prec UMINUS    { $$ = $1; }
    | LPAREN expr RPAREN         { $$ = $2; }
    ;

%%

void yyerror(const char* s) {
    std::cerr << "Error: " << s << " at line " << token_table.back().line << std::endl;
}

int main() {
    while (getToken()) {
        yyparse();  // Start the parsing process
    }
    return 0;
}
