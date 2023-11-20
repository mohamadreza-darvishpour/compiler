%{
#include <iostream>
#include "symb_char_table.h"

sym_table token_table;
int line_no =0 , token_no = 0 ;


%}

alpha  [A-Za-z]


%%

alpha       {token_table.add(token_no++,line_no , yytext ,"alphabet");}
[ \t\n]+    { /* Skip whitespace */ }
%%

