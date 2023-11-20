%{
#include <stdio.h>

extern FILE* yyin; // Declare yyin as an external variable
int yylex(); // Declare yylex function
int yywrap(); // Declare yywrap function
%}

%option  c++


%%
.|\n   { printf("Token: %s\n", yytext); }
%%

int yywrap() {
    return 1; // Indicate the end of input
}

int main() {
    char file_path[] = "input.txt"; // Specify the file path here

    yyin = fopen(file_path, "r");
    if (yyin == NULL) {
        printf("Error opening file: %s\n", file_path);
        return 1;
    }

    yylex();

    fclose(yyin);
    return 0;
}