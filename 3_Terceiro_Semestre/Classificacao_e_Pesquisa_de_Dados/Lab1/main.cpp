// InsertionSort exemplo em C++
#include <iostream>
#include <chrono>

using namespace std;
using namespace std::chrono;

#define SMALL 10
#define LARGE 1000000
int arr_small[SMALL];
int arr_large[LARGE];
int shellsort_array[LARGE];


void insertion_sort(int arr[], int n) {
    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j = i - 1;
        // Move elements of arr[0..i-1], that are greater than key,
        // to one position ahead of their current position
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        arr[j + 1] = key;
    }
}



// Function to print an array
void print_array(int arr[], int n) {
    for (int i = 0; i < n; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

void generate_random_array(int arr[], int n) {
    for (int i=0; i<n; i++) arr[i] = rand() % n+1;
}


/*

void shellsort(int array[], int n, int vector_h[]){
    // For each iteration of the shellsort a different insetion_sort will be used

    //to choose which w to use we have to test it
    //this will test which w under n is the biggest
    int j = 0;
    while(vector_h[j] < n){
        j++;
    }
    j--;

    //we will use this algorithm as many times as the h vector allows
    for(;j >= 0; j--){

        int h = vector_h[j];


        //printf("h = %d\n", h);
        
        //printf("i = %d\n", n/h);

        int i = n / h;

        //forming the shellsort_array
        for(int c = 0; c <= i; c++){
           shellsort_array[c] = array[c*h];
        }

        //printf("shellsort_array: ");
        //print_array(shellsort_array, (n / h) + 5);

        //with it formed lets insetion_sort it
        insertion_sort(shellsort_array, n / h);

        

        //with it sorted let's regroup them
        for(int c = 0; c <= i; c++){
            array[c*h] = shellsort_array[c] ;
        }

        //printf("array: ");
        //print_array(array, SMALL);

    }

}

*/

int shellsort(int arr[], int n, int vector_h[]) {

    //exchange counter
    int exchanges = 0;

    //to choose which w to use we have to test it
    //this will test which w under n is the biggest
    int h_index = 0;
    while(vector_h[h_index] < n){
        h_index++;
    }
    h_index--;

    //i have to make an insertion sort j times
    for(;h_index >= 0; h_index--){

        int h = vector_h[h_index];

        for (int i = h; i < n; i++) {
            int key = arr[i];
            int j;
            // Move elements of arr[0..i-1], that are greater than key,
            // to one position ahead of their current position
            for (j = i; j >= h && arr[j - h] > key; j -= h) {
                arr[j] = arr[j - h];
                exchanges++;
            }

        arr[j] = key;
    }

   return exchanges;
}


}

void shellsort_execution_analisis( char name[], int tamanho_vetor, int vector_h[]) {

    int exchanges = 0;

    generate_random_array(arr_large, tamanho_vetor);
    auto start = high_resolution_clock::now(); // Start time
    //insertion_sort(arr_large, LARGE);
    exchanges = shellsort(arr_large, tamanho_vetor, vector_h);
    auto end = high_resolution_clock::now(); // End time

    duration<double> elapsed = end - start; // Compute duration

    cout << name << "," << tamanho_vetor << "," << exchanges << "," << elapsed.count() * 1000 << endl;
}




// Main function to test the insertion sort
int main() {

    int vector_h_potencias[21] = {1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072,262144,524288,1048576};
    int vector_h_3n[14] = {1,4,13,40,121,364,1093,3280,9841,29524,88573,265720,797161,2391484};
    int vector_h_ciura[17] = {1,4,10,23,57,132,301,701,1577,3548,7983,17961,40412,90927,204585,460316,1035711};

    generate_random_array(arr_small, SMALL);
    printf("Original array: ");
    print_array(arr_small, SMALL);


    //insertion_sort(arr_small, SMALL);

    shellsort(arr_small, SMALL, vector_h_potencias);

    printf("Sorted array: ");
    print_array(arr_small, SMALL);


    /*

    generate_random_array(arr_large, LARGE);
    auto start = high_resolution_clock::now(); // Start time
    //insertion_sort(arr_large, LARGE);
    shellsort(arr_large, LARGE, vector_h_potencias);
    auto end = high_resolution_clock::now(); // End time

    duration<double> elapsed = end - start; // Compute duration 

    cout << "Execution time in C++ for array with " << LARGE << " elements: " << elapsed.count() * 1000 << " miliseconds" << endl;

    */

    //computing the time of each shellsort executions with different parameters

    cout << "algoritmo,tamanho,trocas,tempo" << endl;

    char name_shell[] = "shell";
    char name_3N[] = "3N+1";
    char name_ciura[] = "ciura";

    shellsort_execution_analisis(name_shell, 100, vector_h_potencias);
    shellsort_execution_analisis(name_3N, 100, vector_h_3n);
    shellsort_execution_analisis(name_ciura, 100, vector_h_ciura);

    shellsort_execution_analisis(name_shell, 1000, vector_h_potencias);
    shellsort_execution_analisis(name_3N, 1000, vector_h_3n);
    shellsort_execution_analisis(name_ciura, 1000, vector_h_ciura);

    shellsort_execution_analisis(name_shell, 10000, vector_h_potencias);
    shellsort_execution_analisis(name_3N, 10000, vector_h_3n);
    shellsort_execution_analisis(name_ciura, 10000, vector_h_ciura);

    shellsort_execution_analisis(name_shell, 100000, vector_h_potencias);
    shellsort_execution_analisis(name_3N, 100000, vector_h_3n);
    shellsort_execution_analisis(name_ciura, 100000, vector_h_ciura);

    shellsort_execution_analisis(name_shell, 1000000, vector_h_potencias);
    shellsort_execution_analisis(name_3N, 1000000, vector_h_3n);
    shellsort_execution_analisis(name_ciura, 1000000, vector_h_ciura);

    return 0;
}
