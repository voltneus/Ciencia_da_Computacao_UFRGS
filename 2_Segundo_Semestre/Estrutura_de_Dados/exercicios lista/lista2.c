#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*
Faca uma lista simplesmente encadeada que receba 100 letras aleat´orias e
ent˜ao, crie uma nova lista simplesmente encadeada que receber´a os n´os
que n˜ao s˜ao vogais da lista anterior, separando consoantes e vogais.
Sem vari´aveis globais!
*/

typedef struct Lista{
  char letra;
  struct Lista *prox;

}Lista;

void show_lista(Lista *head);
Lista* adiciona_letras_na_lista(Lista *head, char letra);
Lista* cria_lista_de_consoantes(Lista *head);


int main(){

  struct Lista *head = NULL;
  struct Lista *Lista_consoantes = NULL;
  char letra = 0;
  srand(time(NULL));
  int i = 0;

  for(i = 0; i < 100; i++){
    letra = (rand() % 26) + 65;
    head = adiciona_letras_na_lista(head, letra);
  }

  show_lista(head);

  Lista_consoantes = cria_lista_de_consoantes(head);

  show_lista(head);

  show_lista(Lista_consoantes);
  return 0;
}

Lista* adiciona_letras_na_lista(Lista *head, char letra){

  Lista *NovoPtLista = (Lista*) malloc(sizeof(Lista));
  NovoPtLista->letra = letra;
  NovoPtLista->prox = NULL;
  Lista *temp = head;


  if(head == NULL){
    head = NovoPtLista;
    return head;
  }

  while(temp->prox != NULL){
    temp = temp -> prox;
  }

  temp -> prox = NovoPtLista;
  return head;

  return head;
}

Lista* cria_lista_de_consoantes(Lista *head){



  Lista *temp1 = head;
  Lista *temp2 = head;

  Lista *Lista_consoantes = NULL;

  while(temp1 -> prox != NULL){
    temp2 = temp1;
    temp1 -> prox = temp1;
    if(temp1 -> letra != 'A' && temp1 -> letra != 'E' && temp1 -> letra != 'I' && temp1 -> letra != 'O' && temp1 -> letra != 'U'){
      Lista *NovoPtLista = (Lista*) malloc(sizeof(Lista));
      NovoPtLista->letra = temp1 -> letra;
      NovoPtLista->prox = NULL;

      if(Lista_consoantes == NULL){
        Lista_consoantes = NovoPtLista;
      }
      else{
        Lista_consoantes -> prox = NovoPtLista;
      }
      temp2 -> prox = temp1 -> prox;
      temp1 = temp1 -> prox;

    }


  }

  return Lista_consoantes;

}

void show_lista(Lista *head) {
    Lista *temp = head;
    while (temp != NULL) {
        printf("%d -> ", temp->letra);
        temp = temp->prox;
    }
    printf("NULL\n");
}
