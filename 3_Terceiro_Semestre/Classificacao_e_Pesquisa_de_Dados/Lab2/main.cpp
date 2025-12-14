// InsertionSort exemplo em C++
#include <iostream>
#include <utility>
#include <chrono>

using namespace std;
using namespace std::chrono;




int partition_lomuto(int C[], int left, int right, int& swaps) {
  int chave = C[left];
  int storeindex = left + 1;  // Index of smaller element

  for (int i = left+1; i <= right; i++)
  {
    // If current element is smaller than or
    // equal to pivot
    if (C[i] < chave)
    {
      swaps++;
      std::swap(C[i], C[storeindex]);
      storeindex++;    // increment index of smaller element
    }
  }
  swaps++;
  std::swap(C[left], C[storeindex-1]);

  return (storeindex-1);
}


int partition_hoare(int C[], int left, int right, int& swaps) {
  // O pivô é escolhido como o primeiro elemento.
  int pivot = C[left];

  // Ponteiro 'i' começa antes do início da partição.
  // Ponteiro 'j' começa depois do fim da partição.
  int i = left - 1;
  int j = right + 1;

  // Loop infinito que só será interrompido quando os ponteiros se cruzarem.
  for (;;) {

    // Move o ponteiro 'i' para a direita até encontrar um elemento
    // que seja maior ou igual ao pivô.
    do {
      i++;
    } while (C[i] < pivot);

    // Move o ponteiro 'j' para a esquerda até encontrar um elemento
    // que seja menor ou igual ao pivô.
    do {
      j--;
    } while (C[j] > pivot);

    // Se os ponteiros 'i' e 'j' se cruzaram, a partição está completa.
    // O ponto de divisão é retornado.
    if (i >= j) {
      return j;
    }

    // Se os ponteiros não se cruzaram, significa que C[i] está no lado
    // errado (direito) e C[j] está no lado errado (esquerdo). Troca-os.
    std::swap(C[i], C[j]);
    swaps++; // Incrementa o contador de trocas.
  }
}


void median(int vector[], int start_vector, int end_vector, int& swaps) {

  if (end_vector - start_vector < 2) {
    return;
  }

  int mid_vector = start_vector + 1;
  int end_idx = start_vector + 2;


  if (vector[start_vector] > vector[mid_vector]) {
    std::swap(vector[start_vector], vector[mid_vector]);
    swaps++;
  }
  if (vector[mid_vector] > vector[end_idx]) {
    std::swap(vector[mid_vector], vector[end_idx]);
    swaps++;
  }
  if (vector[start_vector] > vector[mid_vector]) {
    std::swap(vector[start_vector], vector[mid_vector]);
    swaps++;
  }


  std::swap(vector[start_vector], vector[mid_vector]);
  swaps++;
}



void aleatory(int vector[], int start_vector, int end_vector, int& swaps) {

  int rand_index = start_vector + (rand() % (end_vector - start_vector + 1));

  swap(vector[start_vector], vector[rand_index]);
  swaps++;

}



void quicksort(int vector[], int start_vector, int end_vector, int pivot_method, int partition_method, int& recursions, int& swaps) {

  if (start_vector >= end_vector) {
    return;
  }

  //selecting the pivot(first number on the list)
  if (pivot_method == 1) {
    //median of 3
    median(vector, start_vector, end_vector, swaps);

  }
  else if (pivot_method == 2) {
    //aleatory
    aleatory(vector, start_vector, end_vector, swaps);
  }

  //partitioning the vector
  int pivot = 0;

  if (partition_method == 1) {
    pivot = partition_lomuto(vector, start_vector, end_vector, swaps);
    recursions++;
    quicksort(vector, start_vector, pivot - 1, pivot_method, partition_method, recursions, swaps);
    quicksort(vector, pivot + 1, end_vector, pivot_method, partition_method, recursions, swaps);
  }
  else if (partition_method == 2) {
    pivot = partition_hoare(vector, start_vector, end_vector, swaps);
    recursions++;
    quicksort(vector, start_vector, pivot, pivot_method, partition_method, recursions, swaps);
    quicksort(vector, pivot + 1, end_vector, pivot_method, partition_method, recursions, swaps);
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

#define SMALL 10
#define LARGE 10000
int arr_small[SMALL];
int arr_large[LARGE];

int arr_100[100];
int arr_1000[1000];
int arr_10000[10000];
int arr_100000[100000];
int arr_1000000[1000000];


void performance_analisis(int vector[], int size, int pivot_method, int partition_method) {

  int recursions = 0;
  int swaps = 0;

  generate_random_array(vector, size);
  auto start = high_resolution_clock::now(); // Start time
  quicksort(vector, 0, size-1, pivot_method, partition_method, recursions, swaps);
  auto end = high_resolution_clock::now(); // End time

  duration<double> elapsed = end - start; // Compute duration


  if (pivot_method == 1 && partition_method == 1){
    cout << "MEDIANA3-LOMUTO," << size << "," << recursions << "," << swaps << "," << elapsed.count() * 1000  << endl;
  }
  else if (pivot_method == 2 && partition_method == 1){
    cout << "ALEATORIO-LOMUTO," << size << "," << recursions << "," << swaps << "," << elapsed.count() * 1000  << endl;
  }
  else if (pivot_method == 1 && partition_method == 2){
    cout << "MEDIANA3-HOARE," << size << "," << recursions << "," << swaps << "," << elapsed.count() * 1000  << endl;
  }
  else if (pivot_method == 2 && partition_method == 2){
    cout << "ALEATORIO-HOARE," << size << "," << recursions << "," << swaps << "," << elapsed.count() * 1000  << endl;
  }


}




// Main function to test the insertion sort
int main() {

  int recursions = 0;
  int swaps = 0;

  cout << "particionamento,tamanho,recursoes,trocas,tempo" <<  endl;

  performance_analisis(arr_100, 100, 2, 1);
  performance_analisis(arr_1000, 1000, 2, 1);
  performance_analisis(arr_10000, 10000, 2, 1);
  performance_analisis(arr_100000, 100000, 2, 1);
  performance_analisis(arr_1000000, 1000000, 2, 1);

  performance_analisis(arr_100, 100, 2, 2);
  performance_analisis(arr_1000, 1000, 2, 2);
  performance_analisis(arr_10000, 10000, 2, 2);
  performance_analisis(arr_100000, 100000, 2, 2);
  performance_analisis(arr_1000000, 1000000, 2, 2);


  performance_analisis(arr_100, 100, 1, 1);
  performance_analisis(arr_1000, 1000, 1, 1);
  performance_analisis(arr_10000, 10000, 1, 1);
  performance_analisis(arr_100000, 100000, 1, 1);
  performance_analisis(arr_1000000, 1000000, 1, 1);

  performance_analisis(arr_100, 100, 1, 2);
  performance_analisis(arr_1000, 1000, 1, 2);
  performance_analisis(arr_10000, 10000, 1, 2);
  performance_analisis(arr_100000, 100000, 1, 2);
  performance_analisis(arr_1000000, 1000000, 1, 2);


  return 0;
}
