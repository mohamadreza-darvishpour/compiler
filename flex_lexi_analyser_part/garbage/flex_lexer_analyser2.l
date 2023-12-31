%{
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

%option noyywrap c++

string  \"[^\n"]+\"
tab    [\t]
ws  [ ]+
alpha  [A-Za-z]
dig  [0-9]
name  ({alpha}|{dig}|\$)({alpha}|{dig}|[_.\-/$])*
num1  [-+]?{dig}+\.?([eE][-+]?{dig}+)?
num2  [-+]?{dig}*\.{dig}+([eE][-+]?{dig}+)?
number  {num1}|{num2}



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



int main(int argc, char* argv[]) {
    if(argc != 2) {
        cout << "Please provide input file name and try again\n";
        return 0;
    }

    FILE* fin = fopen(argv[1], "r");

    if(fin == NULL) {
        printf("Cannot open input file\n");
        return 0;
    }

    //logFile.open("1805087_log.txt");
	//tokenFile.open("1805087_token.txt");

    yyin = fin;
    yylex();
    fclose(fin);

    return 0;
}






