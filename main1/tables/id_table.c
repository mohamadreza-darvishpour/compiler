#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Define the struct for the table
struct DataTable {
    int row;        // Number of rows
    int col;        // Number of columns
    char*** data;   // Pointer to a 2D array of pointers (array of strings)
    char** headers;  // Array to store column headers
};

// Function to create a table with specified dimensions
struct DataTable* createTable(int rows, int cols) {
    struct DataTable* table = malloc(sizeof(struct DataTable));

    table->row = rows;
    table->col = cols;

    // Allocate memory for column headers
    table->headers = malloc(cols * sizeof(char*));

    // Initialize column headers
    table->headers[0] = "id";
    table->headers[1] = "type";
    table->headers[2] = "has_val";
    table->headers[3] = "value";

    // Allocate memory for the data array (2D array of strings)
    table->data = malloc(rows * sizeof(char**));
    for (int i = 0; i < rows; i++) {
        table->data[i] = malloc(cols * sizeof(char*));
    }

    return table;
}

// Function to display the table
void displayTable(struct DataTable* table) {
    // Display headers
    printf("   ");
    for (int i = 0; i < table->col; i++) {
        printf("%10s", table->headers[i]);
    }
    printf("\n");

    // Display data
    for (int i = 0; i < table->row; i++) {
        printf("%2d ", i + 1);
        for (int j = 0; j < table->col; j++) {
            printf("%10s", table->data[i][j]);
        }
        printf("\n");
    }
}

// Function to free memory allocated for the table
void freeTable(struct DataTable* table) {
    // Free memory for column headers
    free(table->headers);

    // Free memory for the data array (2D array of strings)
    for (int i = 0; i < table->row; i++) {
        free(table->data[i]);
    }
    free(table->data);

    // Free memory for the DataTable struct
    free(table);
}

//return existance of ID . 0=True    1=False 
int has_id(struct DataTable* table , const char id_str[]){
    for (int i = 0; i < table->row; i++ ) {
        printf("fir=  %s\n",table->data[i][0]);
        printf("sec=  %s\n",id_str);
        //printf("res=  %d\n",strcmp(table->data[i][0], id_str));
        

        if (table->data[i][0]!=NULL){
         if(  strcmp( table->data[i][0], id_str)==0  ){
            return 0;
        }
        }
    }
    return 1 ;
}

//return consistance of ID . 0=True    1=False 
int is_const_id(struct DataTable* table , const char id_str[]){
    
    int index = find_id_index(table, id_str);
            //check if id is equal to any const. 
        if(  strcmp( table->data[index][1], "const_char")==0  ){
            return 0;
        }
        if(  strcmp( table->data[index][1], "const_int")==0  ){
            return 0;
        }
    return 1 ;
}


//get last empty id index. full = -2001
int last_empty_id_index(struct DataTable* table ){
    for (int i = 0; i < table->row; i++ ) {
        if (table->data[i][0]==NULL){
            return i ;
        }
        
    }
    return -2001 ;
    

}

//add new id   True = 0   False = 1 
int add_empty_id(struct DataTable* table ,const char id[],const char id_type[]){
    int last_empty = last_empty_id_index(table);
    if(last_empty==-2001){
        return 1;
    }
    table->data[last_empty][0] = id  ;
    table->data[last_empty][1] =  id_type   ;
    table->data[last_empty][2] = "False"  ;
    table->data[last_empty][3] =  NULL   ;
    return 0;
}





//find index of id if exists. 
int find_id_index(struct DataTable* table , const char id_str[]){
    for (int i = 0; i < table->row; i++ ) {
        if (table->data[i][0]!=NULL){
         if(  strcmp( table->data[i][0], id_str)==0  ){
            return i;
        }
        }
    }
    return -1402 ;
    

}


int main() {
    // Create a table with 3 rows and 4 columns
    struct DataTable* myTable = createTable(15, 4);

    // Add data to the table
    myTable->data[0][0] = "189423";
    myTable->data[0][1] = "type";
    myTable->data[0][2] = "has_val";
    myTable->data[0][3] = "value";

    myTable->data[1][0] = "t1";
    myTable->data[1][1] = "t2";
    myTable->data[1][2] = "t3";
    myTable->data[1][3] = "t4";    

    myTable->data[2][1] = "t5";
    myTable->data[2][2] = "t6";
    myTable->data[2][3] = "t7";    
    myTable->data[2][0] = "t8";

    myTable->data[3][0] = "t9";
    myTable->data[3][1] = "t12";
    myTable->data[3][2] = "t10";
    myTable->data[3][3] = "t11";

    myTable->data[4][0] = "t13";
    myTable->data[4][1] = "const_char";
    myTable->data[4][2] = "t15";
    myTable->data[4][3] = "t16";
 
    int dd = is_const_id(myTable,"t13");
    printf("\nlast*****\n%d\n******\n",dd);

    // Free memory
    freeTable(myTable);

    return 0;
}
