%option noyywrap

%%
[\n]   { printf("Line: %s\n", yytext); }
[\t]   { printf("Line: %s\n", yytext); }
[ ]   { printf("Line: %s\n", yytext); }

%%

int main() {
    yylex();
    return 0;
}