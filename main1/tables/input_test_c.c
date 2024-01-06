#include <stdio.h>

int main() {
    char name[50]; // Assuming a name will not exceed 49 characters

    printf("Enter your name: ");
    scanf("%49s", name);

    printf("Hello, %s!\n", name);

    return 0;
}
