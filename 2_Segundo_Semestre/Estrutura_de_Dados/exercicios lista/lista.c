#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct lista {
    int conteudo;
    struct lista *prox;
} Lista;

Lista* add_no(Lista *head, int numero);
void show_lista(Lista *head);

int main() {
    Lista *head = NULL;
    srand(time(NULL));

    for(int i = 0; i < 100; i++) {
        int numeroaleatorio = rand() % 10000; // limite opcional
        head = add_no(head, numeroaleatorio);
    }

    show_lista(head);

    return 0;
}

Lista* add_no(Lista *head, int numero) {
    Lista *NovoPtLista = (Lista*) malloc(sizeof(Lista));
    NovoPtLista->conteudo = numero;
    NovoPtLista->prox = NULL;

    if (head == NULL || numero < head->conteudo) {
        NovoPtLista->prox = head;
        return NovoPtLista;
    }

    Lista *atual = head;
    while (atual->prox != NULL && atual->prox->conteudo < numero) {
        atual = atual->prox;
    }

    NovoPtLista->prox = atual->prox;
    atual->prox = NovoPtLista;

    return head;
}

void show_lista(Lista *head) {
    Lista *temp = head;
    while (temp != NULL) {
        printf("%d -> ", temp->conteudo);
        temp = temp->prox;
    }
    printf("NULL\n");
}
