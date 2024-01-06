#include <stdio.h>
#include <stdlib.h>

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
    table->headers[1] = "change";
    table->headers[2] = "change_amount";
    table->headers[3] = "nothing";

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





int main() {
    // Create a table with 3 rows and 4 columns
    struct DataTable* myTable = createTable(10, 4);

    // Add data to the table
    myTable->data[0][0] = "John";
    myTable->data[0][1] = "25";
    myTable->data[0][2] = "50000";
    myTable->data[0][3] = "101";
 

    // Display the table
    displayTable(myTable);

    // Free memory
    freeTable(myTable);

    return 0;
}
