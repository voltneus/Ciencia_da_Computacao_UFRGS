# 📘 1º Semestre — Ciência da Computação (UFRGS)

Este diretório reúne as atividades práticas, trabalhos acadêmicos e projetos desenvolvidos durante o **primeiro semestre** do curso de Bacharelado em Ciência da Computação na UFRGS (período letivo 2024/2).

---

## 📑 Disciplinas do Semestre

### 1. [Algoritmos e Programação (INF01202)](./Algoritmos_e_Programacao)
* **Linguagem**: `C` (padrão C99/C11)
* **Biblioteca Gráfica**: `Raylib`
* **Principais Tópicos**: Estruturas de controle de fluxo, vetores e matrizes, modularização de código, ponteiros e structs, I/O com arquivos binários e de texto.
* **Destaque**: Desenvolvimento de um **jogo 2D completo** com física de voo, rolagem de tela infinita, mapas modulares em `.txt` e sistema de recordes (*leaderboard*) salvo em binário.

### 2. [Fundamentos de Algoritmos (INF05501)](./Fundamentos_de_Algoritmos)
* **Linguagem**: `Racket` / `Scheme` (DrRacket)
* **Paradigma**: Funcional
* **Principais Tópicos**: Definição indutiva de dados, funções recursivas, recursão de cauda (*tail recursion*), funções de alta ordem (`map`, `filter`, `foldr`), árvores binárias e avaliação por substituição.
* **Conteúdo**: Resolução das Listas 1 a 4, exercícios com árvores e resolução preparatória para a Prova 2.

### 3. [Introdução à Arquitetura de Computadores (INF01107)](./Introducao_a_Arquitetura_de_Computacao)
* **Arquiteturas Didáticas**: `Neander` e `Ahmes`
* **Conceitos**: Modelo de Von Neumann, ciclo de busca/execução de instruções, mapa de memória, acumulador, flags de condição (NZVC), codificação em hexadecimal e assembly básico.
* **Trabalhos**:
  * **Trabalho Neander**: Implementação da operação bitwise XOR e cálculo da Distância de Hamming entre duas palavras de 8 bits.
  * **Trabalho Ahmes**: Algoritmo de divisão por subtrações sucessivas e aritmética com números inteiros em múltiplos bytes.

---

## 📂 Estrutura de Pastas

```
1_Primeiro_Semestre/
├── Algoritmos_e_Programacao/
│   ├── Fatorial.c
│   └── Vitor_Feijo_E_Gabriel_Nunes/      # Projeto final do jogo 2D com Raylib
├── Fundamentos_de_Algoritmos/
│   ├── Lista_1/                          # Introdução ao Racket e tipos básicos
│   ├── Lista_2/                          # Condicionais e funções geométricas
│   ├── Lista_3/                          # Recursão e processamento de listas
│   ├── Lista_4/                          # Alta ordem e árvores
│   ├── Outros/                           # Exercícios de árvores
│   └── Prova_2/                          # Simulado/resolução P2
└── Introducao_a_Arquitetura_de_Computacao/
    ├── Trabalho_Ahmes/                   # Assembly Ahmes (.ahd / .mem)
    └── Trabalho_Neander/                 # Assembly Neander (.txt / .mem)
```

---

[⬅ Voltar para a Página Principal](../README.md)
