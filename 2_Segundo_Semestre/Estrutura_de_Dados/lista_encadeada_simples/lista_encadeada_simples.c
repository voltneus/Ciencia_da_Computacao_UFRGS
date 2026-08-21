#include <stdio.h>
#include <stdlib.h>

/*
O que falta fazer:
funções com prototipos vazios
*/



typedef struct lista{

  int valor;
  struct lista *prox;

} Lista;

Lista* Adiciona_termo_no_comeco(Lista *head, int valor);
Lista* Adiciona_termo_no_fim(Lista *head, int valor);
Lista* Adiciona_termo_em_ordem_crescente();

Lista* Retira_termo_com_valor();

Lista* Organiza_Lista_em_ordem_crescente();

void Limpa_lista(Lista *head);

void Imprime_Lista(Lista* head);


int main(){

  Lista *Lista_Simples = NULL;

  int valor = 0;
  int i = 0;

  for(i = 0; i < 10; i++){
    valor = rand() % 1000;
    Lista_Simples = Adiciona_termo_no_comeco(Lista_Simples, valor);
  }

  printf("Lista com numeros colocados no começo:\n");
  Imprime_Lista(Lista_Simples);

  for(i = 0; i < 10; i++){
    valor = rand() % 1000;
    Lista_Simples = Adiciona_termo_no_fim(Lista_Simples, valor);
  }

  printf("\nLista com mais numeros colocados no fim:\n");
  Imprime_Lista(Lista_Simples);

}

void Limpa_lista(Lista *head){
  Lista *temp = NULL;

  while(head != NULL){
    temp = head -> prox;
    free(head);
    head = temp;
  }

  return;
}




Lista* Organiza_Lista_em_ordem_crescente(){


}


















//---------------

Lista* Adiciona_termo_no_comeco(Lista *head, int valor){

  Lista *novo = (Lista*) malloc(sizeof(Lista));
  novo -> valor = valor;
  novo -> prox = NULL;

  if(head == NULL){
    head = novo;
    return head;
  }

  novo -> prox = head;
  head = novo;

  return head;

}

Lista* Adiciona_termo_no_fim(Lista *head, int valor){

  Lista *novo = (Lista*) malloc(sizeof(Lista));
  novo -> valor = valor;
  novo -> prox = NULL;

  Lista *temp = NULL;

  if(head == NULL){
    head = novo;
    return head;
  }

  for(temp = head; temp -> prox != NULL;){
    temp = temp -> prox;
  }

  temp -> prox = novo;

  return head;

}

void Imprime_Lista(Lista* head){

  Lista *temp = head;

  for(temp = head; temp -> prox != NULL;temp = temp -> prox){
    printf("%d ", temp -> valor);
  }

  return;
}

