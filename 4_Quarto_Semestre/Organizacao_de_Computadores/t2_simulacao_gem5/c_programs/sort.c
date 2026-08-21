#include <stdio.h>
#include <stdlib.h>

#define ARRAY_SIZE 20000 

void merge(int arr[], int temp[], int left, int mid, int right) {
    int i = left, j = mid + 1, k = left;
    
    // Core branching logic
    while (i <= mid && j <= right) {
        if (arr[i] <= arr[j]) {
            temp[k++] = arr[i++];
        } else {
            temp[k++] = arr[j++];
        }
    }
    
    while (i <= mid) temp[k++] = arr[i++];
    while (j <= right) temp[k++] = arr[j++];
    
    for (i = left; i <= right; i++) {
        arr[i] = temp[i];
    }
}

void mergeSort(int arr[], int temp[], int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        mergeSort(arr, temp, left, mid);
        mergeSort(arr, temp, mid + 1, right);
        merge(arr, temp, left, mid, right);
    }
}

int main() {
    printf("Starting Merge Sort...\n");
    
    // Allocate arrays on the heap to avoid stack overflow in gem5
    int *arr = (int*)malloc(ARRAY_SIZE * sizeof(int));
    int *temp = (int*)malloc(ARRAY_SIZE * sizeof(int));
    
    // Initialize array with pseudo-random unsorted data
    for(int i = 0; i < ARRAY_SIZE; i++) {
        arr[i] = (ARRAY_SIZE - i) ^ 0x5555; 
    }

    mergeSort(arr, temp, 0, ARRAY_SIZE - 1);

    printf("Sort complete. Verification value arr[0] = %d\n", arr[0]);
    
    free(arr); 
    free(temp);
    return 0;
}