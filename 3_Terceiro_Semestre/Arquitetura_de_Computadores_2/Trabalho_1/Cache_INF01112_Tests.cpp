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

    vector<float> propotrionslru;
    vector<float> propotrionslfu;
  
    for(int i = 0; i < 100; i++){
    
        cout << i << endl;

        cache_lfu.reset_cache();
        cache_lru.reset_cache();
       
        entries.clear();
        cache_lfu.hits = 0;
        cache_lfu.misses = 0;

        cache_lru.hits = 0;
        cache_lru.misses = 0;

        //reset_cache();

        for(int i = 0; i < 50; i++){
            entries.push_back(rand() % (21));
        }
                        
        //LRU test  
        for(int v: entries) {
            cache_lru.add_value(v);
            
            //cache_lru.get_info();
        }
    
        
        //LFU test  
        
        for(int v: entries) {
            cache_lfu.add_value(v);

            //cache_lfu.get_info();
        }

        //cout << cache_lfu.hits << "    "  << cache_lfu.misses << endl;

        propotrionslfu.push_back(static_cast<float>(cache_lfu.hits) / cache_lfu.misses);
        propotrionslru.push_back(static_cast<float>(cache_lru.hits) / cache_lru.misses);
        
    }

    

    cout << "lfu: " << endl;
    for(int i = 0; i < 100; i++)
        cout <<  propotrionslfu[i] << ", ";

    cout << endl << "lru: " << endl;
    for(int i = 0; i < 100; i++)
        cout << propotrionslru[i] <<  ", ";


    
    return 0;
}


