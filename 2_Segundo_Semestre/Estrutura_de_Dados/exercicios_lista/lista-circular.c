#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*
Uma lista circular simplesmente encadeada recebe 100 n´umeros que devem
ser armazenados em n´os, quando a lista estiver completa, deve-se criar
uma lista simplesmente encadeada que receber´a os n´umeros pares da lista
circular, deixando a lista circular com menos elementos. Depois disso,
outra lista simplesmente encadeada deve ser feita com os n´umeros ´ımpares.
Como mostrado em aula, existem as assinaturas de fun¸c˜ao que devem ser
utilizadas, no caso esse projeto deve utilizar fun¸c˜oes com essas assinaturas:
*/


typedef struct lista {
    int valor;
    struct lista *prox;
} Lista;


struct lista* add_no(struct lista *no);
struct lista* filtra_listas(struct lista *lista_circular , struct lista **lista_pares, struct lista **lista_impares);
void imprime_lista(Lista *inicio);

int main(){

  int i = 0;
  srand(time(NULL));
  Lista *lista_circular = NULL;
  Lista **lista_pares = NULL;
  Lista **lista_impares = NULL;


  for(i = 0; i < 100; i++){
    lista_circular = add_no(lista_circular);
  }

  printf("lista circular: \n");
  imprime_lista(lista_circular);

  lista_circular = filtra_listas(lista_circular , lista_pares, lista_impares);

  printf("lista circular: \n");
  imprime_lista(lista_circular);

  printf("lista_pares: \n");
  imprime_lista(*lista_pares);

  printf("lista_impares: \n");
  imprime_lista(*lista_impares);



}


struct lista* add_no(struct lista *no){

  Lista *nodo_novo = (struct lista *)malloc(sizeof(struct lista));
  nodo_novo -> valor = rand() % 100;

  Lista *temp = no;

  if(no == NULL){
    nodo_novo -> prox = nodo_novo;
    return nodo_novo;
  }


  while(temp -> prox != no){
    temp = temp -> prox;
  }

  temp -> prox = nodo_novo;
  nodo_novo->prox = no;


  return no;

}


struct lista* filtra_listas(struct lista *lista_circular , struct lista **lista_pares, struct lista **lista_impares){

  Lista *atual = lista_circular;
  Lista *temp = NULL;
  Lista *ultimo = NULL;

  while(atual -> prox != lista_circular){

    if((atual -> prox -> valor) % 2 == 0){
      temp = atual -> prox;
      atual -> prox = atual -> prox -> prox;
      temp -> prox = NULL;

      if(*lista_pares == NULL){
        *lista_pares = temp;
      }
      else{
        ultimo = *lista_pares;
        while(ultimo -> prox != NULL){
          ultimo = ultimo -> prox;
        }
        ultimo -> prox = temp;
      }

    }
    else if((atual -> prox -> valor) % 2 == 1){

      temp = atual -> prox;
      temp -> prox = NULL;
      if(*lista_impares == NULL){
        *lista_impares = temp -> prox;
      }
      else{
        ultimo = *lista_impares;
        while(ultimo -> prox != NULL){
          ultimo = ultimo -> prox;
        }
        ultimo -> prox = temp;
      }
    }


  }

  return lista_circular;
}

void imprime_lista(Lista *inicio){
  Lista *temp = inicio;
  do {
    printf("%d ", temp->valor);
    temp = temp->prox;
  } while (temp != NULL && temp != inicio);
  printf("\n");


}

