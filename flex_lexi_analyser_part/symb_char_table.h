#ifndef SYNB_CHAR_TABLE_H
#define SYNB_CHAR_TABLE_H
#include <iostream>
#include <vector>
#endif  //SYMB_CHAR_TABLE_H

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
        character   get_index(int ind){
            temp_struct = char_struct.at(ind);
            return temp_struct;
        }

};



