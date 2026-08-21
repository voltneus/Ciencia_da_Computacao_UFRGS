# 🔗 Estruturas de Dados (INF01203)

Este diretório reúne as implementações em linguagem **C** desenvolvidas para a disciplina de **Estruturas de Dados**, com ênfase no domínio de ponteiros, alocação dinâmica e tipos abstratos de dados lineares.

---

## 🎯 Conceitos Estudados

- **Gerenciamento de Memória Heap**: Uso consciente de `malloc` e `free` para prevenir vazamentos de memória (*memory leaks*) e ponteiros pendentes (*dangling pointers*).
- **Manipulação de Ponteiros**: Acesso indireto, ponteiros para estruturas (`struct Node*`) e passagem de ponteiro por referência (`Node**`).
- **Encadeamento de Nós**: Conexão linear e encadeamento circular de elementos.
- **Complexidade Assintótica**: Análise de tempo \(O(1)\) vs \(O(n)\) para operações de inserção, remoção e busca.

---

## 📂 Pastas e Conteúdo

### 1. [`lista_encadeada_simples/`](./lista_encadeada_simples)
* **Arquivo**: [`lista_encadeada_simples.c`](./lista_encadeada_simples/lista_encadeada_simples.c)
* **Implementação**:
  * Definição da estrutura de nó (`struct Lista` contendo `int info` e `struct Lista *prox`).
  * Funções fundamentais:
    * `inicializa()`: Inicialização de lista vazia (`NULL`).
    * `insere_inicio()`: Inserção com complexidade \(O(1)\).
    * `insere_ordenado()`: Inserção mantendo os elementos em ordem crescente \(O(n)\).
    * `imprime()`: Percurso iterativo e formatação de saída.
    * `busca()`: Busca linear por chave.
    * `retira()`: Remoção de nó com religamento de ponteiros e liberação de memória.
    * `libera()`: Desalocação completa de todos os nós da lista.

### 2. [`exercicios_lista/`](./exercicios_lista)
* **Arquivos**:
  * `lista.c`, `lista2.c`, `lista_2.c`, `lista_3.c`: Exercícios práticos envolvendo intercalação de listas, inversão de ponteiros, união, interseção e contagem de nós.
  * `lista-circular.c`: Implementação de lista simplesmente encadeada circular (onde o último nó aponta para o primeiro), com suporte a inserção, percurso cíclico e remoção segura de elementos.

---

[⬅ Voltar para o 2º Semestre](../README.md)
