#include "lex.cpp"
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

   // std::string path =  "/home/lrd/Documents/compiler/flex_lexi_analyser_part/t_input.txt";
     char path[] =  "/home/lrd/Documents/compiler/flex_lexi_analyser_part/t_input.txt";
/*
        YY_BUFFER_STATE newBuffer = yy_create_buffer(myfile, YY_BUF_SIZE);
        yy_switch_to_buffer(newBuffer);
        yylex( );
        yy_delete_buffer(newBuffer);
        myfile.close();
*/
    const char* filename = path ;
    FILE* inputfile = std::fopen(filename,"r");
    if(inputfile ==nullptr)
        std::cerr << "\nerror when opening file."<<std::endl;
    //yy_scan_file(inputfile);
    yyin = inputfile;
    yylex();
    std::fclose(inputfile);


        return 32;
    }

