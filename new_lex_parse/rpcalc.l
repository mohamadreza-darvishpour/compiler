%{
#include "parser.tab.hpp" // Include the Bison-generated header file
%}

DIGIT   [0-9]

%%
{DIGIT}+     { yylval.fval = atof(yytext); return NUM; }

[ \t\n]                        ; // Ignore whitespace
.                              { return *yytext; }
%%

int yywrap() {
    return 0;
}
