# 📗 2º Semestre — Ciência da Computação (UFRGS)

Este diretório contém os trabalhos práticos, implementações de estruturas de dados e projetos em linguagem Assembly desenvolvidos durante o **segundo semestre** do curso de Bacharelado em Ciência da Computação na UFRGS (período letivo 2025/1).

---

## 📑 Disciplinas do Semestre

### 1. [Arquitetura de Computadores I (INF01108)](./Arquitetura_de_Computadores_1)
* **Linguagens e Arquiteturas**: `RAMSES`, `CÉSAR` e `Intel 8086 x86 Assembly`
* **Principais Tópicos**:
  * Modos de endereçamento avançados (direto, indireto, indexado, relativo).
  * Estruturas de pilha (*stack frame*), convenções de chamada e subrotinas.
  * Mecanismos de interrupção (hardware/software), vetor de interrupções e I/O mapeado em memória.
  * Programação x86 real em ambiente DOS, manipulação de arquivos com *file handles* e avaliação de expressões matriciais.

### 2. [Estrutura de Dados (INF01203)](./Estrutura_de_Dados)
* **Linguagem**: `C`
* **Principais Tópicos**:
  * Alocação dinâmica e liberação rigorosa de memória (`malloc`, `calloc`, `realloc`, `free`).
  * Implementação de ponteiros simples e ponteiros para ponteiros (`**ptr`).
  * Listas Encadeadas Simples (inserção ordenada, busca, remoção e percurso).
  * Listas Encadeadas Circulares e variações estruturais.

### 3. [Outros Projetos](./Outros)
* **Projeto**: Calculadora de Análise Combinatória em C (permutações, combinações e arranjos).

---

## 📂 Estrutura de Pastas

```
2_Segundo_Semestre/
├── Arquitetura_de_Computadores_1/
│   ├── Trabalho_Ramses/                  # Assembly RAMSES (.rad)
│   ├── Trabalho_Cesar/                   # Assembly CÉSAR com interrupções (.ced / .mem)
│   └── Trabalho_Intel/                   # Assembly x86 DOS com I/O de arquivos (.asm)
├── Estrutura_de_Dados/
│   ├── lista_encadeada_simples/          # Implementação canônica de lista encadeada
│   └── exercicios_lista/                 # Exercícios de listas lineares e circulares
└── Outros/
    └── calculadora_combinatoria.c        # Programa em C para cálculos combinatórios
```

---

[⬅ Voltar para a Página Principal](../README.md)
