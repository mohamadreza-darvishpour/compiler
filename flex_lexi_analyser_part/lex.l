%{
#include <iostream>
#include "symb_char_table.h"

sym_table token_table;
int line_no =0 , token_no = 0 ;


%}


DIGIT       [0-9]
LETTER      [a-zA-Z]
FLOAT       {DIGIT}+(\.{DIGIT}+)?([eE][-+]?{DIGIT}+)?
STRING      \"([^\\\n]|(\\.))*?\"
TAB         \t
SPACE       [ \f\r\v]+
NEWLINE     \n

KEYWORD    "if"|"else"|"print"|"cout"|"show"|"def"


%%
{FLOAT}     {token_table.add(token_no++,line_no , yytext ,"float");}
{STRING}    {token_table.add(token_no++,line_no , yytext ,"string");}
{TAB}       {token_table.add(token_no++,line_no , yytext ,"tab");}
{SPACE}     {token_table.add(token_no++,line_no , yytext ,"space");}
{NEWLINE}   {token_table.add(token_no++,line_no , yytext ,"newline");}
{KEYWORD}   {token_table.add(token_no++,line_no , yytext ,"keyword");}
"="         {token_table.add(token_no++,line_no , yytext ,"equel");}
"<"         {token_table.add(token_no++,line_no , yytext ,"bigger");}
">"         {token_table.add(token_no++,line_no , yytext ,"smaller");}
"=="        {token_table.add(token_no++,line_no , yytext ,"compare");}
.           {}
%%

