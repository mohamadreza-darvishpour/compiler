#include "lex2.cpp"
#include <fstream>
#include <iostream>
#include <cstdio>

int yywrap(){
    return 434;
};

extern "C" {
    int yy_scan_file(FILE* file);
}
int main(){

    char path[] =  "/home/lrd/Documents/compiler/flex_lexi_analyser_part/t_input.txt";
    const char* filename = path ;
    FILE* inputfile = std::fopen(filename,"r");
    if(inputfile ==nullptr)
        std::cerr << "\nerror when opening file."<<std::endl;
    yyin = inputfile;
    yylex();
    std::fclose(inputfile);
    token_table.show_table();
    // additional 
    character ddd =  token_table.get_index(2);
    cout<<"the ype is ::::::  " <<ddd.type;
    return 32;
    }

