#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>
#include <chrono>

using namespace std;

//Different M's that will be used to test the algorithm
#define M1 3793
#define M2 6637
#define M3 9473
#define M4 12323
#define M5 15149
#define MAX_SIZE 18944



//Player struct for the complete list
typedef struct {
  int sofifaid;
  string name;
  string position; //string vector, palyer can play in multiple positions
} Player;

//Player struct for the hash table
typedef struct {
  vector<Player> playervector;
} PlayerHash;

typedef struct {
    int tempo; //t
    float ocupacao; //o
    int maxM; //M
    float avgM; //m
} StatsBuild;

typedef struct {
    int id;
    string name;
    int testes[5];

} StatsConsu;

//variável global para saída
StatsConsu consulta;



//used to test file read
void FilePrint(){
  ifstream file("arquivos-suporte\\players.csv");
  string line;

  if (!file) {
    cerr << "Error opening file" << endl;
    return;
  }

  while (getline(file, line)) { // read each line until EOF
    cout << line << endl;
  }

  file.close();
  return;

}

void FileReadPlayers(vector<Player>& player_list){

  //example:
  //sofifa_id,name,player_positions
  //158023,Lionel Andres Messi Cuccittini,"RW, ST, CF"

  ifstream file("arquivos-suporte\\players.csv");
  string line;

  if (!file) {
    cerr << "Error opening file: players.csv" << endl; //unbuffered cout(better for error messages)
    return;
  }


  if (!getline(file, line)) { //parses the header line
      cerr << "Error: File is empty or cannot be read: players.csv" << endl;
      return;
  }

  // reads the rest of the file until EOF
  while (getline(file, line)) {
    stringstream ss(line); // Creates a stream based on the line
    string field;          // Temporary buffer
    Player playerbuffer;

    // Reads until first comma
    getline(ss, field, ',');
    playerbuffer.sofifaid = stoi(field); //string -> int

    // Reads until second comma
    getline(ss, field, ',');
    playerbuffer.name = field;

    // Reads until the end of the line
    getline(ss, field);
    playerbuffer.position = field;

    player_list.push_back(playerbuffer);

    }

  file.close();
  return;

}

void FileReadConsultas(vector<int>& consultas){


  ifstream file("arquivos-suporte\\consultas.csv");
  string line;

  if (!file) {
    cerr << "Error opening file: consultas.csv" << endl; //unbuffered cout(better for error messages)
    return;
  }


  if (!file) { //parses the header line
      cerr << "Error: File is empty or cannot be read: consultas.csv" << endl;
      return;
  }

  // reads the rest of the file until EOF
  while (getline(file, line)) {
    stringstream ss(line); // Creates a stream based on the line
    string field;          // Temporary buffer
    int buffer;

    getline(ss, field);
    buffer = stoi(field);

    consultas.push_back(buffer);

    }

  file.close();
  return;

}

void PrintPlayer(Player player){
  cout << player.sofifaid << " " << player.name << " " << player.position << endl;
}

void PrintAllPlayers(vector<Player>& player_list){
  for(int i = 0; i < player_list.size(); i++){
    PrintPlayer(player_list[i]);
  }
}

//This function returns the hash of a value
int HashValue(int sofifaid, int M){
  int hash = sofifaid % M;
  return hash;
}

int ConsultinHash(vector<PlayerHash>& hash_table, int sofifaid, int M){
  int hash = HashValue(sofifaid, M);
  consulta.testes[0] = 0;
  //if its empty, then the element is definitely not there
  if(hash_table[hash].playervector.empty() == true){
    //cout << "The element is not in the hash" << endl;
    return 1;
  }

  //let's check if the player is there
  for(const Player& p : hash_table[hash].playervector) {//for each player p in hash_table
    consulta.testes[0]++;

    if (p.sofifaid == sofifaid) { //equal sofifaid's
      //cout << "consultado" << endl;
      //cout << p.name << endl;
      consulta.name = p.name;
      consulta.id = p.sofifaid;
      return 0;
    }
  }

  //cout << "The element is not in the hash" << endl;
  return 1;
}

int InsertinHash(vector<PlayerHash>& hash_table, Player player, int M){
  int hash = HashValue(player.sofifaid, M);
  if(!ConsultinHash(hash_table, player.sofifaid, M)){ //returns 0 if the element is there
    //if the element is there
    //cout << "the element is already there" << endl;
    return 1;
  }

  //cout << "inserido" << endl;
  hash_table[hash].playervector.push_back(player);

  return 0;
}

int RemoveinHash(vector<PlayerHash>& hash_table, Player player, int M){
    int hash = HashValue(player.sofifaid, M);

  if(ConsultinHash(hash_table, player.sofifaid, M)){ //returns 0 if the element is there
    //if the element is not there
    //cout << "the element is not there, thus i can't remove it" << endl;
    return 1;
  }

  vector<Player>& list_at_hash = hash_table[hash].playervector; //playervector pointer

  for(auto it = list_at_hash.begin(); it != list_at_hash.end(); ++it){ //iterator for the list
    if(it->sofifaid == player.sofifaid){ //it is a pointer to each element in playervector
      list_at_hash.erase(it);
      //cout << "removido" << endl;
      return 0;
    }
  }

  //there is something there but it isn't the element we are looking for
  return 1;
}


int CountOccupied(const vector<PlayerHash>& hash_table) {
    int occupied_count = 0;
    for (const auto& bucket : hash_table) {
        if (!bucket.playervector.empty()) {
            occupied_count++;
        }
    }
    return occupied_count;
}

float GetAvgListSize(const vector<PlayerHash>& hash_table) {
    int n_empty = 0;
    long long total_list_size = 0; //long long para evitar overflow

    for (const auto& bucket : hash_table) {
        int current_size = bucket.playervector.size();

        if (current_size > 0) {
            n_empty ++;
            total_list_size += current_size;
        }
    }

    if (n_empty > 0) {
        return (float)total_list_size / n_empty;
    } else {
        return 0.0f;
    }
}

int GetMaxListSize(const vector<PlayerHash>& hash_table) {
    int max_size = 0;
    for (const auto& bucket : hash_table) {
        if (bucket.playervector.size() > max_size) {
            max_size = bucket.playervector.size();
        }
    }
    return max_size;
}

void PrintInsertionResults(StatsBuild saidaBuild[5]){

  ofstream arquivo_de_saida("estatisticas_construcao.txt");

  if (!arquivo_de_saida){
    cerr << "error creating the file" << endl;
  }


  for(int i = 0; i < 5; i++){
    arquivo_de_saida << saidaBuild[i].tempo;
    if(i != 4){
      arquivo_de_saida << ",";
    }
  }
  arquivo_de_saida << endl;
  for(int i = 0; i < 5; i++){
    arquivo_de_saida << saidaBuild[i].ocupacao;
    if(i != 4){
      arquivo_de_saida << ",";
    }
  }
  arquivo_de_saida << endl;
  for(int i = 0; i < 5; i++){
    arquivo_de_saida << saidaBuild[i].maxM;
    if(i != 4){
      arquivo_de_saida << ",";
    }
  }
  arquivo_de_saida << endl;
  for(int i = 0; i < 5; i++){
    arquivo_de_saida << saidaBuild[i].avgM;
    if(i != 4){
      arquivo_de_saida << ",";
    }
  }
  arquivo_de_saida << endl;

  arquivo_de_saida.close();

}



void PrintConsultationsResults(int totaltimeconsult[5], vector<StatsConsu>& saidaCons){

  ofstream arquivo_de_saida("estatisticas_consultas.txt");

  if (!arquivo_de_saida){
    cerr << "error creating the file" << endl;
  }

  for(int i = 0; i < 5; i++){
    arquivo_de_saida << totaltimeconsult[i];
    if(i != 4){
      arquivo_de_saida << ",";
    }
  }
  arquivo_de_saida << endl;

  for(int i = 0; i < saidaCons.size(); i++){
    arquivo_de_saida << saidaCons[i].id << ",";
    arquivo_de_saida << saidaCons[i].name << ",";
    for(int j = 0; j < 5; j++){
      arquivo_de_saida << saidaCons[i].testes[j];
      if(j != 4){
       arquivo_de_saida << ",";
      }
    }
    arquivo_de_saida << endl;
  }
  
  arquivo_de_saida.close();

}

int main() {

  vector<int> consultas;
  vector<Player> player_list;
  vector<StatsConsu> saidaCons;
  StatsBuild saidaBuild[5];
  int totaltimeconsult[5];
  int m[] = {M1, M2, M3, M4, M5};

  FileReadPlayers(player_list);
  FileReadConsultas(consultas);
  cout << "files read" << endl;
  saidaCons.resize(consultas.size());
  //PrintAllPlayers(player_list);

  vector<PlayerHash> hash_table(MAX_SIZE);
  cout << "tests:" << endl;


  for (int i = 0; i < 5; i++){
      vector<PlayerHash> current_hash(m[i]);

      auto inicio = chrono::high_resolution_clock::now();
      for (int j = 0; j < MAX_SIZE; j++){
        InsertinHash(current_hash, player_list[j], m[i]);
      }

      auto fim = chrono::high_resolution_clock::now();
      auto tempo = fim - inicio;

      //armazena os dados de saída de build
      saidaBuild[i].tempo = chrono::duration_cast<chrono::milliseconds>(tempo).count();
      saidaBuild[i].ocupacao = (float)CountOccupied(current_hash) / m[i] ;
      saidaBuild[i].avgM = GetAvgListSize(current_hash);
      saidaBuild[i].maxM = GetMaxListSize(current_hash);

      inicio = chrono::high_resolution_clock::now();
      for (int j = 0; j < consultas.size() ; j++){  //enche o vector com stats de saida de consulta

        if (ConsultinHash(current_hash, consultas[j], m[i])){
            saidaCons[j].id = 99999;
            saidaCons[j].name = "NAO_ENCONTRADO";

        }
        else{
            saidaCons[j].id = consulta.id;
            saidaCons[j].name = consulta.name;
        }
        saidaCons[j].testes[i] = consulta.testes[0];
        //cout << "testes:" << consulta.testes[i] << endl;
      }

      fim = chrono::high_resolution_clock::now();
      tempo = fim - inicio;
      totaltimeconsult[i] = chrono::duration_cast<chrono::milliseconds>(tempo).count();
  }

  PrintInsertionResults(saidaBuild);

  PrintConsultationsResults(totaltimeconsult, saidaCons);



  return 0;
}

//tempo
//entradas/tamanho
//tamanho maximo
//media do tamanho
