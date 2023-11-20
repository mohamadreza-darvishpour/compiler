#include "../symb_char_table.h"


int main(){

    sym_table table ;
    table.add(1,1,"if","if");
    table.add(2,1,"if2","if");
    table.add(3,1,"if3","if");
    table.add(4,1,"if4","if");
    table.pop();
    table.show_table();


    return 382;
}