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


/*
int main(){
    std::string file_content;
    std::ofstream my_file("/home/lrd/Documents/compiler/flex_lexi_analyser_part/newtest.txt"
     , std::ios::in | std::ios::binary);
    //my_file.imbue(std::locale(std::locale(),new std::codecvt_utf*<char>));

    if(my_file.is_open()){
        std::string line;
        while(std::getline(my_file,line)){
            std::cout << line << std::endl;
            file_content += line +"\n";
        }
        yy_scan_string(file_content.c_str());
        yylex();
        my_file.close();
    }else{
        std::cout << "can't open file.";
    }
    token_table.show_table();
    return 17673;
}
*/





