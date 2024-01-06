%{
#include "calc.tab.h"
%}

%%


"bool"     { return BOOL; }
"break"     { return BREAK; }
"case"     { return CASE; }
"char"     { return CHAR; }
"const"     { return CONST; }
"continue"     { return CONTINUE; }
"default"     { return DEFAULT; }
"double"     { return DOUBLE; }
"else"     { return ELSE; }
"false"     { return FALSE; }
"function"     { return FUNCTION; }
"float"     { return FLOAT; }
"for"     { return FOR; }
"if"     { return IF; }
"input"     { return OUTPUT; }
"int"     { return INT; }
"long"     { return LONG; }
"output"     { return OUTPUT; }
"return"     { return RETURN ; }
"sizeof"     { return SIZEOF; }
"string"     { return STRING; }
"switch"     { return SWITCH; }
"true"     { return TRUE; }


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