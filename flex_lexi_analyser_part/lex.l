%{
#include <iostream>
%}

%%
[ \t\n]+    { /* Skip whitespace */ }
.           { std::cout << "TOKEN: " << yytext << std::endl; }
%%

