//#include "symb_char_table.h"
#include <iostream>
#include <vector>
// #ifndef SYNB_CHAR_TABLE_H
using namespace std;
struct character{
    int word_number;
    int line_number;
    std:: string char_string;
    std:: string type;
};
class sym_table{
public:
    std:: vector<character> char_struct ;
    character temp_struct ;

    int is_empty(){
        //0=True , 1=False
        if(char_struct.size()==0)
            return 0;
        else
            return 1;
    }
    int table_size(){
        return char_struct.size();
    }
    void show_table(){
        int len = char_struct.size();
        cout<<"\t\t\tthe table\n" ;
        for (int f = 0 ; f<len ; f++)
        {
            cout<< "\tword: "<<char_struct.at(f).word_number << "\tline: "<< char_struct.at(f).line_number ;
            cout<< "\ttoken: " <<char_struct.at(f).char_string << "\ttype: " <<char_struct.at(f).type <<endl;
        }
        cout<<endl;
    };
    void add(int word_num,int line_num , std::string char_string , std:: string char_type)
    {
        temp_struct.char_string = char_string;
        temp_struct.line_number   = line_num ;
        temp_struct.word_number  = word_num  ;
        temp_struct.type  = char_type ;
        char_struct.push_back(temp_struct);
    };
    character pop(){
        if (char_struct.size()==0)
            throw "table is empty.";
        int len = char_struct.size() ;
        temp_struct = char_struct.at(len-1);
        char_struct.pop_back();
        return temp_struct;
    }

};









//#endif  SYMB_CHAR_TABLE_H
int main(){
    std::vector<character> two;
    std::vector<character> four;
    // character one ;
    // one.word_number =2 ;
    // one.line_number =3;
    // one.char_string  = "the str";
    // one.type = "strings";

    // two.push_back(one);
    // two.push_back(one);
    //_______________
    sym_table table ;
    table.add(1,1,"if","if");
    table.add(2,1,"if2","if");
    table.add(3,1,"if3","if");
    table.add(4,1,"if4","if");
    table.pop();
    table.show_table();
    character popped  = table.pop();
    cout<<"\n ,lakdsfjlsdakfj::::::"<<popped.word_number;
    return 834;
}


