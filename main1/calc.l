%{
#include "calc.tab.h"
%}

DIGIT   [0-9]
%%
{DIGIT}+            { yylval.ival = atoi(yytext); return INTEGER; }
[-+*/\(\)\n]        { return *yytext; }
[ \t]               ; // ignore whitespace
.                   { printf("Invalid character: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}
