%{
#include <stdio.h>
//#include "lex.yy.h"

extern FILE* yyin; // Declare yyin as an external variable

/*below line added to recognize error.*/

#include <iostream>
#include <fstream>
//include symbol staructure that made.
#include "symb_char_table.h"
using namespace std;
//add "\* *\" to rules.
sym_table token_table;
int line_no = 0;
int token_no = 0;

%}

%option  c++

string  \"[^\n"]+\"
tab    [\t]
ws  [ ]+
alpha  [A-Za-z]
dig  [0-9]
name  ({alpha}|{dig}|\$)({alpha}|{dig}|[_.\-/$])*
num1  [-+]?{dig}+\.?([eE][-+]?{dig}+)?
num2  [-+]?{dig}*\.{dig}+([eE][-+]?{dig}+)?
number  {num1}|{num2}

/*above line added to recognize error.*/




%%




{ws}    {}

{tab}    {
            token_table.add(++token_no,line_no,YYText() , "tab");
}



{number}    {
             token_table.add(++token_no,line_no,YYText() , "number");
            }

[\n]           {line_no++;}

{name}          {
                 token_table.add(++token_no,line_no,YYText() , "name");

                }

{string}        {
                token_table.add(++token_no,line_no,YYText() , "string");

                }


<<EOF>>    {
                return 0;
            }


%%

int yywrap(){
return 82323;
}
int main() {
    cout<<"\n line "<< 1 << "\n";
    char file_path[] = "input.txt"; // Specify the file path here
    cout<<"\n line "<< 2<< "\n";

    yyin = fopen(file_path, "r");
    cout<<"\n line "<< 3 << "\n";

    if (yyin == NULL) {
        cout<<"\n line "<< 4 << "\n";
        printf("Error opening file: %s\n", file_path);
        return 1;
    }
    cout<<"\n line "<< 5 << "\n";

    yylex();
    cout<<"\n line "<< 6 << "\n";

    fclose(yyin);
    return 0;
}