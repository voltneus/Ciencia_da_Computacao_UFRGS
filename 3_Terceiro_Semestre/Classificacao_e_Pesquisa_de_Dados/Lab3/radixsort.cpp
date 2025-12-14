#include <iostream>
#include <fstream>
#include <vector>
#include <string>

#define CHAR_SIZE 256

using namespace std;

struct word_count {
    string word;
    int count;
} typedef word_count_t;

int leitura_do_arquivo(vector<string>& words, string word){
    ifstream infile("entradas/domcasmurro.txt");  // Abre o arquivo de entrada
    if (!infile) {
        cerr << "Erro: não conseguiu abrir o arquivo!" << endl;
        return 1;
    }  

    // Ler palavra por palavra
    while (infile >> word) {
        words.push_back(word);
    }

    infile.close();

    /*
    // Imprimir as 20 primeiras palavras (opcional, para teste)
    cout << "Palavras lidas do arquivo:\n";
    for (size_t i = 0; i < 20; ++i) {
        cout << i << ": " << words[i] << endl;
    }
    */


    /*

    // Imprimir todas palavras (opcional, para teste)
    cout << "Words read from file:\n";
    for (size_t i = 0; i < words.size(); ++i) {
        cout << i << ": " << words[i] << endl;
    }
    */

    /*
    // Exampl0: acessar uma letra específica
    if (!words.empty() && words[0].size() >= 2) {
        //char ch = words[0][1];  // segunda letra da primeira palavra
        cout << "\nA segunda letra da primeira palavra " << words[0] << " eh: " << words[0][1] << endl;
        cout << "\nA primeira letra da décima segunda palavra " << words[11] << " eh: " << words[1][0] << endl;
    }

    // Print number of words
    cout << "\nNúmero total de palavras armazenadas: " << words.size() << endl;

    */

    return 0;

}

void parcial_countingsort(vector<string>& words, int high, int low, int digit, int frequencies[], int frequencies_copy[]){


    vector<string> aux(high - low + 1);

    int index_frequencies = 0;

    //1: count frequencies in a char

    //sbe sbd sac sab

    //vai de 0 até 3
    for (int i = low; i < high; i++) {
        if (digit < (words[i].length())) {
            index_frequencies = words[i][digit];
        } else {
            index_frequencies = 0;
        }
        frequencies[index_frequencies]++;
    }


    //1.5: put it in the copy vector

    for (int i = 0; i < CHAR_SIZE; i++) {
        frequencies_copy[i] = frequencies[i];
    }





    //2: transform frequencies into an accumulated sum

    int sum = 0;

    for (int i = 0; i < CHAR_SIZE; i++) {
        sum += frequencies[i];
        frequencies[i] = sum;
    }

    int index_word = 0;
    int index_char = 0;






    //3: distribute to the new auxiliar vector
    for (int i = high - 1 ; i >= low; i--) {

        if (digit < words[i].length()) {
            index_char = words[i][digit];
        } else {
            index_char = 0;
        }

        frequencies[index_char]--;
        index_word = frequencies[index_char];

        aux[index_word] = words[i];

    }




    //4: return the result to the original vector

    for (int i = 0; i < (high - low); i++) {
        words[low + i] = aux[i];
    }




    return;
}


void radixsort(vector<string>& words, int high, int low, int digit, int recursions){ //input, start , end, digit

    int frequencies[CHAR_SIZE] = {0};
    int frequencies_copy[CHAR_SIZE] = {0};

    //it's recursive so first is the base case

    if(high <= low + 1 || recursions > 20){
        return;
    }


    //FIRST STEP:fully iterate cycle of the parcial counting sort with the vector

    parcial_countingsort(words, high, low, digit, frequencies, frequencies_copy);

    //SECOND STEP: recursively reiterate radix sort again with each different index

    /*

    cout << "Words read from file after " << recursions << "recursions :\n";
    for (size_t i = 0; i < words.size(); ++i) {
        cout << i << ": " << words[i] << endl;
    }

    */



    int current_low = low;
    for (int i = 0; i < CHAR_SIZE; i++) {
        int size = frequencies_copy[i];

        // Só precisamos reordenar grupos com mais de 1 palavra
        if (size > 1) {
            // A chamada recursiva opera no sub-grupo e para o PRÓXIMO dígito
            radixsort(words, current_low + size, current_low, digit + 1, recursions + 1);
        }

        // Move o ponteiro de início para o próximo grupo
        current_low += size;
    }

    /*
    */


}

void word_counting(vector<string>& words, vector<word_count_t>& words_counted) {
    int current_appearences = 1;
    string current_word = words[0];


    for (int i = 1 ; i < words.size(); i++) {
        if (words[i] == current_word) {
            current_appearences++;
        } else {
            //cout << current_word << " " << current_appearences << endl;

            words_counted.push_back({words[i-1], current_appearences});

            current_word = words[i];
            current_appearences = 1;
        }

    }

    //cout << current_word << " " << current_appearences << endl;
    words_counted.push_back({current_word, current_appearences});

    return;
}

void insertion_sort_for_lists(vector<word_count_t>& arr) {
    int n = arr.size();
    for (int i = 1; i < n; i++) {
        word_count_t key = arr[i];
        int j = i - 1;

        // Compares and puts in a decreasing order
        while (j >= 0 &&
              (arr[j].count < key.count ||
              (arr[j].count == key.count && arr[j].word > key.word))) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }

        // Insetion of the element in the correct order
        arr[j + 1] = key;
    }


    for (int i = 0; i < 100; i++) {
        cout << arr[i].word  << " " << arr[i].count << endl;
    }

}







int main() {

    vector<string> words;   // Vetor dinâmico de strings
    string word;

    leitura_do_arquivo(words, word);

    int first_high = words.size();
    int first_low = 0;
    int first_digit = 0;
    int recursions = 0;

    radixsort(words, first_high, first_low, first_digit, recursions);

    /*

    // Imprimir todas palavras (opcional, para teste)
    cout << "Words read from file after radixsort:\n";
    for (size_t i = 0; i < words.size(); ++i) {
        cout  << words[i] << endl;
    }

    */

    vector<word_count_t> words_counted;

    word_counting(words, words_counted);

    insertion_sort_for_lists(words_counted);






    return 0;    
}