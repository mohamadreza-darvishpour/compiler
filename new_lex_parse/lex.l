%{
#include <iostream>
#include <string>
#include "parser.tab.h"  

#include "parser.tab.h"

struct TokenInfo {
    std::string lexeme;
    int line;
};

%}


%option noyywrap



DIGIT       [0-9]
LETTER      [a-zA-Z]
FLOAT       {DIGIT}+(\.{DIGIT}+)?([eE][-+]?{DIGIT}+)?
STRING      \"([^\\\n]|(\\.))*?\"
TAB         \t
SPACE       [ \f\r\v]+
NEWLINE     \n
KEYWORD    "if"|"else"|"print"|"cout"|"show"|"def"


%%
{FLOAT}     {}
{STRING}    {} 
{TAB}       {}
{SPACE}     {}
{NEWLINE}   {}
{KEYWORD}   {}


"+"                         { return PLUS; }
"-"                         { return MINUS; }
"*"                         { return MULTIPLY; }
"/"                         { return DIVIDE; }
"="                         { return EQUAL; }
"("                         { return LPAREN; }
")"                         { return RPAREN; }
";"                         { return SEMICOLON; }


"<"         {}
">"         {}
"=="        {}
.           {}

%%
int yywrap(){
    return 1;
}
