#include <stdio.h>
#include <stdlib.h>

struct lista {
    int valor;
    struct lista *prox;
};


struct lista *add_no(struct lista *no);
//ponteiro de ponteiro
void filtra_no(struct lista *first, struct lista *second);
void imprimir_lista_circular(struct lista *no);
void imprimir_lista(struct lista *no);

int main() {
    struct lista *circular = NULL;
    struct lista *pares = NULL;
    struct lista *impares = NULL;


    for (int i = 0; i < 100; i++) {
        circular = add_no(circular);
    }

    printf("Lista circular:\n");
    imprimir_lista_circular(circular);


    pares = NULL;
    filtra_no(circular, pares);
    printf("Lista de pares:\n");
    imprimir_lista(pares);

    impares = NULL;
    filtra_no(circular, impares);
    printf("\n");
    printf("Lista de impares:\n");
    imprimir_lista_circular(circular);

    printf("\n");
    printf("\n");
    printf("lista circular final:(vazia)\n");
    imprimir_lista(impares);

    return 0;
}

struct lista *add_no(struct lista *no) {
    struct lista *novo = (struct lista *)malloc(sizeof(struct lista));
    novo -> valor = rand() % 1000;

    if (no == NULL) {
        novo->prox = novo;
        return novo;
    } else {
        struct lista *temp = no;
        while (temp->prox != no) {
            temp = temp->prox;
        }
        temp->prox = novo;
        novo->prox = no;
        return no;
    }
}

void filtra_no(struct lista *first, struct lista *second) {
    struct lista *atual = first;
    struct lista *anterior = NULL;
    int primeira_passagem = 1;

    do {
        if ((atual->valor % 2 == 0 && second == NULL) || (atual->valor % 2 != 0 && second != NULL)) {

            struct lista *novo = (struct lista *)malloc(sizeof(struct lista));

            novo->valor = atual->valor;
            novo->prox = NULL;

            if (second == NULL) {
                second = novo;
            } else {
                struct lista *temp = second;
                while (temp->prox != NULL) {
                    temp = temp->prox;
                }
                temp->prox = novo;
            }


            if (anterior == NULL) {
                struct lista *ultimo = first;
                while (ultimo->prox != first) {
                    ultimo = ultimo->prox;
                }
                if (atual->prox == atual) {
                    free(atual);
                    first = NULL;
                    break;
                } else {
                    first = atual->prox;
                    ultimo->prox = first;
                    free(atual);
                    atual = first;
                }
            } else {
                anterior->prox = atual->prox;
                free(atual);
                atual = anterior->prox;
            }
            if (first == NULL)
                break;
        } else {
            anterior = atual;
            atual = atual->prox;
        }

        primeira_passagem = 0;
    } while (atual != first || primeira_passagem);
}

void imprimir_lista_circular(struct lista *no) {
    struct lista *temp = no;
    do {
        printf("%d -> ", temp->valor);
        temp = temp->prox;
    } while (temp != no);
}

void imprimir_lista(struct lista *no) {
    while (no != NULL) {
        printf("%d -> ", no->valor);
        no = no->prox;
    }
}

