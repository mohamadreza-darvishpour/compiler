#include <iostream>
#include <fstream>
/*
int main(int argc , char* argv[]){
    if(argc<2){
        std::cout<<"no input data."<<std::endl;
        return 1;}
    std:: string inputdata = argv[1];
    std::cout<<"inputted data = "<<inputdata <<std::endl;
    return 0;
}
*/

/*
int main(){
    std::string inp_data;
    std::getline(std::cin,inp_data);
    std::cout<< "input:  "<<inp_data <<std::endl;
    return 832847;
}
*/
int main(){
    std::ifstream my_file("/home/lrd/Documents/compiler/flex_lexi_analyser_part/newtest.txt"
     , std::ios::in | std::ios::binary);
    //my_file.imbue(std::locale(std::locale(),new std::codecvt_utf*<char>));
    if(my_file.is_open()){
        std::string line;
        while(std::getline(my_file,line)){
            std::cout << line << std::endl;
        }
    my_file.close();
    }
    else{
        std::cout << "can't open file.";
    }
    return 17673;
}



























