// parser.y

%{
#include <iostream>
#include <cstdlib>
%}

%token NUMBER    // Token for numbers
%token ADD SUB    // Tokens for addition and subtraction
%token MUL DIV    // Tokens for multiplication and division
%token LPAREN RPAREN    // Tokens for parentheses
%token EOL    // Token for end-of-line

%left ADD SUB    // Define operator precedence for addition and subtraction
%left MUL DIV    // Define operator precedence for multiplication and division

%%

%start statements
;
statements:
    statements statement EOL    // Allow multiple statements separated by end-of-line
    | /* empty */
    ;

statement:
    expression { std::cout << "Result: " << $1 << std::endl; }    // Print the result of the expression
    ;

expression:
    NUMBER    // Base case: expression is a single number
    | expression ADD expression { $$ = $1 + $3; }    // Addition operation
    | expression SUB expression { $$ = $1 - $3; }    // Subtraction operation
    | expression MUL expression { $$ = $1 * $3; }    // Multiplication operation
    | expression DIV expression { $$ = $1 / $3; }    // Division operation
    | LPAREN expression RPAREN { $$ = $2; }    // Handle parentheses
    ;

%%

int main() {
    yyparse();    // Start the parsing process
    return 0;
}

int yyerror(const char* message) {
    std::cerr << "Error: " << message << std::endl;    // Print error messages
    exit(1);
}
