# 🔍 Classificação e Pesquisa de Dados — CPD (INF01124)

Este diretório armazena os laboratórios práticos em **C++** e o trabalho final em **Python** desenvolvidos para a disciplina de **Classificação e Pesquisa de Dados** (CPD), abordando algoritmos eficientes de ordenação, estruturas de indexação e recuperação de informação.

---

## 📂 Laboratórios Práticos (C++)

### 1. [`Lab1/`](./Lab1) — Manipulação de Arquivos e Registros
* **Arquivos**: `main.cpp`, `arquivo_csv.txt`
* **Objetivo**: Leitura, análise léxica (*parsing*) e carregamento de conjuntos de dados tabulares em memória estruturada.

### 2. [`Lab2/`](./Lab2) — Algoritmos de Ordenação por Comparação (Quicksort)
* **Arquivos**: `main.cpp`, `notas_quicksort.txt`
* **Objetivo**: Implementação do algoritmo Quicksort com instrumentação para contagem de comparações de chaves e trocas (*swaps*), avaliando o comportamento sob diferentes estratégias de seleção de pivô.

### 3. [`Lab3/`](./Lab3) — Ordenação Digital (Radix Sort em Textos)
* **Arquivos**: `radixsort.cpp`, `domcasmurro.txt`, `war_and_peace.txt`
* **Objetivo**: Implementação de Radix Sort LSD/MSD para ordenação alfabética de palavras e contabilização de frequência léxica em grandes obras literárias (*Dom Casmurro* e *War and Peace*), gerando arquivos de ranking de frequência.

### 4. [`Lab4/`](./Lab4) — Indexação com Tabela Hash
* **Arquivos**: `main.cpp`, `players.csv`, `consultas.csv`, `estatisticas_construcao.txt`, `estatisticas_consultas.txt`
* **Objetivo**: Implementação de Tabela Hash com função de dispersão customizada e tratamento de colisões para indexação e recuperação rápida de dados de jogadores de futebol.

---

## 🎬 [`Trabalho_Final/`](./Trabalho_Final) — Sistema de Busca de Filmes e Tags (MovieLens)

Aplicação desktop completa desenvolvida em **Python 3** com interface gráfica em **Tkinter** para consulta rápida e autocompletar sobre bases de dados do MovieLens (`movies.csv`, `tags.csv`, `miniratings.csv`).

### 🏗️ Estruturas de Dados Utilizadas
1. **Árvore Trie ([`triefile.py`](./Trabalho_Final/Trabalho_CPD/triefile.py))**:
   * Utilizada para busca por **Prefixo do Título** em tempo \(O(k)\), onde \(k\) é o comprimento do prefixo digitado. Permite autocompletar e listagem instantânea de filmes.
2. **Tabelas Hash ([`hashfile.py`](./Trabalho_Final/Trabalho_CPD/hashfile.py), [`ratinghashfile.py`](./Trabalho_Final/Trabalho_CPD/ratinghashfile.py), [`tagshashfile.py`](./Trabalho_Final/Trabalho_CPD/tagshashfile.py))**:
   * Indexação direta de identificadores de filmes, histórico de avaliações de usuários e associação de tags descritivas.
3. **Interface Gráfica ([`main.py`](./Trabalho_Final/Trabalho_CPD/main.py))**:
   * Quatro modos de pesquisa interativa:
     * **Modo Prefixo**: Busca rápida de filmes pelo início do título.
     * **Modo Usuário**: Consulta dos filmes assistidos e notas atribuídas por um determinado usuário.
     * **Modo Gênero**: Filtragem dos melhores filmes com base em gênero específico e nota média.
     * **Modo Tags**: Busca de filmes associados a uma ou mais tags temáticas.

---

[⬅ Voltar para o 3º Semestre](../README.md)
