# 📙 3º Semestre — Ciência da Computação (UFRGS)

Este diretório concentra os trabalhos práticos, simulações de hardware, implementações de algoritmos de pesquisa/ordenação e modelos formais de computação desenvolvidos durante o **terceiro semestre** do curso de Bacharelado em Ciência da Computação na UFRGS (período letivo 2025/2).

---

## 📑 Disciplinas do Semestre

### 1. [Arquitetura de Computadores II (INF01112)](./Arquitetura_de_Computadores_2)
* **Linguagens**: `C++`, `Python` (Matplotlib)
* **Principais Tópicos**:
  * Hierarquia de memória e simulação de cache (Mapeamento Direto, Associativo por Conjunto, Totalmente Associativo).
  * Políticas de substituição (LRU, Random) e taxa de acertos/falhas (*Hit/Miss Ratio*).
  * Paralelismo em Nível de Instrução (ILP), arquiteturas superescalares e algoritmo de Tomasulo.
  * Previsão de desvios (*Branch Prediction* estático e dinâmico: bimodal, 2-bit saturating counter, gshare).

### 2. [Circuitos Digitais (INF01058)](./Circuitos_Digitais)
* **Linguagem & Ferramenta**: `Verilog HDL`, `Intel Quartus Prime`
* **Principais Tópicos**:
  * Projeto e simulação de circuitos combinacionais (Meio-Somador, Somador Completo, minimização de mintermos).
  * Máquinas de Estados Finitos (FSM - Moore e Mealy).
  * Projeto e integração do processador didático **SACI** (Datapath, ULA, decodificador, display 7 segmentos e registradores).

### 3. [Classificação e Pesquisa de Dados — CPD (INF01124)](./Classificacao_e_Pesquisa_de_Dados)
* **Linguagens**: `C++`, `Python 3` (`Tkinter`)
* **Principais Tópicos**:
  * Algoritmos de ordenação em memória principal: Quicksort (análise de pivôs) e Radix Sort sobre strings/textos.
  * Tabelas Hash com tratamento de colisões e indexação de dados.
  * **Trabalho Final**: Sistema completo de busca e recomendação de filmes (MovieLens) integrando **Árvore Trie** para prefixos de títulos e **Tabelas Hash** para consultas por usuário, gênero e tags, com interface gráfica desktop.

### 4. [Linguagens Formais e Autômatos — LFA (INF05005)](./Linguagens_Formais_e_Automatos)
* **Ferramenta**: `JFLAP`
* **Principais Tópicos**:
  * Hierarquia de Chomsky: Linguagens Regulares e Livres de Contexto.
  * Modelagem de sistema de Máquina de Vendas em duas etapas:
    * Etapa 1: Autômato Finito Determinístico (DFA) e Gramática Linear Unitária à Direita (GLUD).
    * Etapa 2: Gramática Livre de Contexto (GLC) e Autômato com Pilha (PDA).

### 5. [Teoria da Computação (INF05504)](./Teoria_da_Computacao)
* **Modelos e Simuladores**: `Máquina Norma`, `Cálculo Lambda puro`, `Máquinas de Turing`
* **Principais Tópicos**:
  * Computabilidade e equivalência de modelos formais.
  * Programação com registradores (Norma) e redução de expressões lambda (combinadores de ponto fixo).
  * Máquinas de Turing com múltiplas fitas e transições de cabeçote.
  * Provas formais de indecidibilidade por **Redução** (Teorema de Rice, Problema da Parada).

---

## 📂 Estrutura de Pastas

```
3_Terceiro_Semestre/
├── Arquitetura_de_Computadores_2/         # Simulador Cache C++, gráficos Python e relatórios
├── Circuitos_Digitais/                    # Módulos Verilog, Somadores e Processador SACI
├── Classificacao_e_Pesquisa_de_Dados/     # Labs C++ (1 a 4) e Trabalho Final Trie/Hash em Python
├── Linguagens_Formais_e_Automatos/        # Modelagens no JFLAP (DFA, GLUD, GLC, Pilha)
└── Teoria_da_Computacao/                  # Máquina Norma, Cálculo Lambda, Turing e Reduções
```

---

[⬅ Voltar para a Página Principal](../README.md)
