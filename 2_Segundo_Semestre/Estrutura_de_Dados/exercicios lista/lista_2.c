#include <stdio.h>
#include <stdlib.h>
#include <time.h>


/*
Faca uma lista simplesmente encadeada que receba 100 letras aleat´orias e
ent˜ao, crie uma nova lista simplesmente encadeada que receber´a os n´os
que n˜ao s˜ao vogais da lista anterior, separando consoantes e vogais.
Sem vari´aveis globais!
*/


typedef struct Lista {
    char letra;
    struct Lista *prox;
} Lista;

void show_lista(Lista *head);
Lista* adiciona_letras_na_lista(Lista *head, char letra);
Lista* cria_lista_de_consoantes(Lista *head);
int eh_vogal(char c);

int main() {
    Lista *head = NULL;
    Lista *Lista_consoantes = NULL;
    char letra = 0;
    srand(time(NULL));

    for (int i = 0; i < 100; i++) {
        letra = (rand() % 26) + 65;
        head = adiciona_letras_na_lista(head, letra);
    }

    Lista_consoantes = cria_lista_de_consoantes(head);

    printf("Lista completa:\n");
    show_lista(head);

    printf("\nLista apenas de consoantes:\n");
    show_lista(Lista_consoantes);

    return 0;
}

Lista* adiciona_letras_na_lista(Lista *head, char letra) {
    Lista *novo = (Lista*) malloc(sizeof(Lista));
    novo->letra = letra;
    novo->prox = NULL;

    if (head == NULL) {
        return novo;
    }

    Lista *temp = head;
    while (temp->prox != NULL) {
        temp = temp->prox;
    }
    temp->prox = novo;
    return head;
}

int eh_vogal(char c) {
    // Se for minúscula, transforma em maiúscula
    if (c >= 'a' && c <= 'z') {
        c = c - 32;
    }
    return (c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U');
}

Lista* cria_lista_de_consoantes(Lista *head) {
    Lista *nova_lista = NULL;
    Lista *temp = head;

    while (temp != NULL) {
        if (!eh_vogal(temp->letra)) {
            nova_lista = adiciona_letras_na_lista(nova_lista, temp->letra);
        }
        temp = temp->prox;
    }
    return nova_lista;
}

void show_lista(Lista *head) {
    Lista *temp = head;
    while (temp != NULL) {
        printf("%c -> ", temp->letra);
        temp = temp->prox;
    }
    printf("NULL\n");
}
