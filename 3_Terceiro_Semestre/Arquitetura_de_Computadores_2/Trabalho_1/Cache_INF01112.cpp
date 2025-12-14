#include <iostream>
#include <list>
#include <random>
#include <sstream>
#include <vector>
#include <cstdlib>
#include <ctime>

using namespace std;

constexpr int CACHE_SIZE = 10;
constexpr int MAX_VALUE = 100;
constexpr int MIN_VALUE = 0;

struct CacheAddress {
    int  data = 0;
    bool valid = false;
};

class CacheMemory {
public:
    int hits = 0;
    int misses = 0;
    CacheAddress cache[CACHE_SIZE];

    void get_info() const {
        cout << "Hits: " << hits << "\tMisses: " << misses << "\n\n";
    }
    void print_cache(){
        cout << "Cache display:\n";
        for (int i = 0; i<CACHE_SIZE; i++){
            cout <<"["<< i << "]: ";
            if (!cache[i].valid)
                cout << "X";
            else
                cout << cache[i].data;
            cout << "\n";
        }
    }
    int search_value(int value){
        for (int i = 0; i<CACHE_SIZE; i++){
            if(cache[i].valid == true && cache[i].data == value)
                return i;
        }
        return -1;
    }
    void reset_cache()  {
        for(int i=0;i<CACHE_SIZE;i++)   {
            cache[i].data = 0;
            cache[i].valid = false;
            hits = 0;
            misses = 0;
        }
    }
};

class Fifo : public CacheMemory {
public:
    int pointer = 0;

    Fifo() = default;

    void add_value(int value){
        if(search_value(value) < 0){ //search returns -1 if it doesn't find
            cache[pointer].data = value;
            cache[pointer].valid = true;
            pointer += 1;
            if(pointer==CACHE_SIZE){
                pointer = 0;
            }
            misses += 1;
        }else{
            hits +=1;
        }
    }
};

class Lru : public CacheMemory {
public:
    list<int> access_history; //stores the addresses modified in order (front == most recent)
    Lru() = default;

    void add_value(int value){
        int search_result = search_value(value);
        if(search_result < 0){ //search returns -1 on miss
            misses += 1;
            //first tries to allocate in an empty address
            for(int i=0; i< CACHE_SIZE; i++){
                if (cache[i].valid == false){
                    cache[i].valid = true;
                    cache[i].data = value;
                    access_history.push_front(i);
                    return;
                }
            }
            // if all addresses are occupied, puts in the last address (older) from the double ended list
            int address = access_history.back();
            cache[address].data = value;
            access_history.remove(address); // updates history
            access_history.push_front(address);
        }else{
            access_history.remove(search_result); // updates history
            access_history.push_front(search_result);
            hits +=1;
        }
    }
};

class Lfu : public CacheMemory {
public:

	int freq[MAX_VALUE - MIN_VALUE + 1] = {}; //Auxiliary array; the frequency of "value" is incremented in freq["value"].

	Lfu() = default;

	void add_value(int value)   {
	    freq[value - MIN_VALUE]++; //Frequency counter is always incremented upon accessing "value." Offset by -MIN_VALUE to start at freq[0].
		int val_index = search_value(value);
		if(val_index < 0)   { //Returns -1 on miss. Must evict a variable or fill empty slot.
            misses++;
			int lowest_freq_val = cache[0].data; //Initialize variable to search for lowest frequency in cache.
			int eviction_index = 0;
			int i = -1;
			do  {   //Search for lowest frequency or empty address. Eviction sub-policy: variable in the earliest address is evicted.
                i++;
                if (freq[lowest_freq_val] > freq[cache[i].data] || !cache[i].valid) {
					eviction_index = i;
                    lowest_freq_val = cache[i].data; // Senseless if the address is empty, but inconsequential.
				}
			} while(cache[i].valid && i < CACHE_SIZE - 1);
			cache[eviction_index].data = value;
            cache[eviction_index].valid = true;
		} else
			hits++;
    }
};

int main() {

    Lru cache_lru;
    Lfu cache_lfu;
    vector<int> entries;

    srand(time(NULL));

    int menu_in = 0;
    int num_in = 0;
    bool menu_in_valid = false;
    bool vec_in_valid = false;
    string str_in;
    //Menu {
    cout << "This program compares the performance of the cache eviction policies LRU and LFU (lowest address sub-policy).\n";
    cout << "Cache size: " << CACHE_SIZE << ".\nValid entries: integers in [" << MIN_VALUE << ", " << MAX_VALUE << "].\n\n";
    while(!menu_in_valid)   {
        cout << "To continue, input a number corresponding to a test case:\n";
        cout << "1 - Pro LRU.\n2 - Pro LFU.\n3 - Even result.\n4 - Random entries.\n5 - Manual entries.\n\n";
        getline(cin, str_in);
        istringstream iss(str_in);
        if(iss >> menu_in)   {
            menu_in_valid = true;
            switch(menu_in) {
                case 1:
                    //Vector for LRU best case.
                    entries = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9,     
                               0, 1, 2, 3, 4, 5, 6, 7, 8, 9,   
                               10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 
                               10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 
                               10, 11, 12, 13, 14, 15, 16, 17, 18, 19};

                    break;

                case 2:
                    //Vector for LFU best case.
                    entries = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
                               0, 1, 2, 3, 4, 5,
                               10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
                               0, 1, 2, 3, 4, 5,
                               10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
                               0, 1, 2, 3, 4, 5, 6};

                    break;
                case 3:
                    //Vector with even result.
                    entries = //Fase A: Favorece LFU 
                              {0, 1, 2, 3, 4,         
                               10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 
                               0, 1, 2, 3, 4,        
                               10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 
                               // Fase B: Favorece LRU 
                               20, 21, 22, 23, 24, 25, 26, 27, 28, 29,    
                               20, 21, 22, 23, 24, 25, 26, 27, 28, 29};
     
                    break;
                case 4:
                    //Vector with random values
                    for(int i = 0; i < 20; i++){
                        entries.push_back(rand() % (101));
                    }
                    
                    break;
                case 5:
                    while(!vec_in_valid) {
                        cout << "\nInsert test data sequence - entries must be integers from " << MIN_VALUE << " to " << MAX_VALUE << ", separated only by whitespaces.\n\n";
                        getline(cin, str_in);
                        istringstream iss(str_in);
                        vec_in_valid = true;
                        while(iss >> num_in)    {
                            if(num_in >= MIN_VALUE && num_in <= MAX_VALUE)
                                entries.push_back(num_in);
                            else
                                vec_in_valid = false;
                        }
                        if(entries.empty())
                            vec_in_valid = false;
                        if(!vec_in_valid)
                            cout << "\nEntry sequence invalid.\n\n";
                    }
                    break;
                default:
                    menu_in_valid = false;
                cout << "\nInvalid input.\n\n";
            }
        } else
            cout << "\nInvalid input.\n\n";
    }
    //}
    cout << "\nResulting sequence:\n< ";
    for(int v:entries)
        cout << v << " ";

    //LRU test  {
    cout << ">\n\nSimulating LRU...\n\n";
    for(int v: entries) {
        cache_lru.add_value(v);
        cache_lru.print_cache();
        cache_lru.get_info();
    }
    cout << "LRU simulation done! Results:\nHits: " << cache_lru.hits << "\nMisses: " << cache_lru.misses << "\n\n";
    //}
    //LFU test  {
    cout << "Simulating LFU...\n\n";
    for(int v: entries) {
        cache_lfu.add_value(v);
        cache_lfu.print_cache();
        cache_lfu.get_info();
    }
    cout << "LFU simulation done! Results:\nHits: " << cache_lfu.hits << "\nMisses: " << cache_lfu.misses << "\n\n";
    //}
    cout << "Final results:\nHits:\n\tLRU: " << cache_lru.hits << "\n\tLFU: " << cache_lfu.hits;
    cout << "\nMisses:\n\tLRU: " << cache_lru.misses << "\n\tLFU: " << cache_lfu.misses << "\n\n";
    if(cache_lfu.misses > cache_lru.misses)
        cout << "LRU was more efficient.\n";
    else if (cache_lfu.misses < cache_lru.misses)
        cout << "LFU was more efficient.\n";
    else
        cout << "Eviction policies tied in performance.\n";

    return 0;
}


