%{
#include "calc.tab.h"
%}

%%
"if"    { return IF; }
"else"  { return ELSE; }
"while" { return WHILE; }
"return" { return RETURN; }

bool 
break
case 
char 
const 
continue 
default 
double
else



"=="    { return EQ; }
"!="    { return NEQ; }
"<"     { return LT; }
">"     { return GT; }
"<="    { return LTE; }
">="    { return GTE; }
"+"     { return PLUS; }
"-"     { return MINUS; }
"*"     { return TIMES; }
"/"     { return DIVIDE; }
"="     { return ASSIGN; }
"("     { return LPAREN; }
")"     { return RPAREN; }
";"     { return SEMICOLON; }

[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return IDENTIFIER; }

[0-9]+  { yylval.num = atoi(yytext); return     INTEGER; }

[ \t\n]  { /* ignore whitespace and newline */ }

.       { /* catch-all for unrecognized characters */ }

%%

int yywrap(){
    return 0;
}