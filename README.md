# 🎓 Ciência da Computação — UFRGS

<div align="center">

![UFRGS](https://img.shields.io/badge/Universidade-UFRGS-005BA2?style=for-the-badge&logo=education)
![Curso](https://img.shields.io/badge/Curso-Ci%C3%AAncia%20da%20Computa%C3%A7%C3%A3o-blue?style=for-the-badge&logo=codeforces)
![Status](https://img.shields.io/badge/Status-Em%20Andamento-success?style=for-the-badge)
![Licença](https://img.shields.io/badge/Licen%C3%A7a-MIT-green?style=for-the-badge)
![Linguagens](https://img.shields.io/badge/Linguagens-C%20%7C%20C%2B%2B%20%7C%20Python%20%7C%20Java%20%7C%20SQL%20%7C%20Verilog%20%7C%20RISC--V-orange?style=for-the-badge)

<p align="center">
  <b>Repositório com os trabalhos práticos, listas de exercícios, simulações e projetos desenvolvidos durante o curso de Bacharelado em Ciência da Computação no Instituto de Informática (INF) da Universidade Federal do Rio Grande do Sul (UFRGS).</b>
</p>

[📚 Estrutura do Curso](#-estrutura-do-curso) •
[💻 Tecnologias & Ferramentas](#-tecnologias--ferramentas) •
[📂 Árvore de Diretórios](#-árvore-de-diretórios) •
[🚀 Destaques dos Projetos](#-destaques-dos-projetos)

---

</div>

## 📚 Estrutura do Curso

Abaixo encontra-se a divisão por semestres e disciplinas, com links diretos para a documentação e os códigos de cada matéria:

### [1º Semestre (2024/2)](./1_Primeiro_Semestre)
> Foco na transição para o ensino superior, fundamentos da programação imperativa e funcional, e introdução aos primeiros conceitos de arquitetura de processadores.

| Disciplina | Código | Conteúdos Principais | Tecnologias |
| :--- | :---: | :--- | :--- |
| **[Algoritmos e Programação](./1_Primeiro_Semestre/Algoritmos_e_Programacao)** | INF01202 | Lógica imperativa, ponteiros, matrizes, arquivos, desenvolvimento de jogo 2D | `C`, `Raylib` |
| **[Fundamentos de Algoritmos](./1_Primeiro_Semestre/Fundamentos_de_Algoritmos)** | INF05501 | Paradigma funcional, recursão, funções de alta ordem, árvores | `Racket` / `Scheme` |
| **[Introdução à Arquitetura de Computadores](./1_Primeiro_Semestre/Introducao_a_Arquitetura_de_Computacao)** | INF01107 | Máquinas hipotéticas, código de máquina e assembly didático | `Neander`, `Ahmes` |

---

### [2º Semestre (2025/1)](./2_Segundo_Semestre)
> Aprofundamento em arquitetura de computadores (I/O, interrupções, arquiteturas CISC/x86) e consolidação em estruturas de dados clássicas e gerenciamento de memória.

| Disciplina | Código | Conteúdos Principais | Tecnologias |
| :--- | :---: | :--- | :--- |
| **[Arquitetura de Computadores I](./2_Segundo_Semestre/Arquitetura_de_Computadores_1)** | INF01108 | Modos de endereçamento, subrotinas, interrupções e programação x86 real | `RAMSES`, `CÉSAR`, `x86 Assembly` |
| **[Estrutura de Dados](./2_Segundo_Semestre/Estrutura_de_Dados)** | INF01203 | Alocação dinâmica de memória, listas encadeadas simples, listas circulares | `C` |
| **[Outros Projetos](./2_Segundo_Semestre/Outros)** | — | Calculadora de combinações, permutações e arranjos | `C` |

---

### [3º Semestre (2025/2)](./3_Terceiro_Semestre)
> Domínio de projeto e síntese de circuitos digitais em HDL, análise avançada de arquitetura (memória cache e ILP), complexidade de algoritmos de pesquisa/ordenação e fundamentação formal de autômatos e teoria da computação.

| Disciplina | Código | Conteúdos Principais | Tecnologias |
| :--- | :---: | :--- | :--- |
| **[Arquitetura de Computadores II](./3_Terceiro_Semestre/Arquitetura_de_Computadores_2)** | INF01112 | Simulador de hierarquia de memória cache, previsores de desvio e ILP | `C++`, `Python` (Matplotlib) |
| **[Circuitos Digitais](./3_Terceiro_Semestre/Circuitos_Digitais)** | INF01058 | Síntese de circuitos combinacionais/sequenciais, FSMs e processador SACI | `Verilog HDL`, `Quartus Prime` |
| **[Classificação e Pesquisa de Dados (CPD)](./3_Terceiro_Semestre/Classificacao_e_Pesquisa_de_Dados)** | INF01124 | Quicksort, Radix Sort, Tabelas Hash e Sistema de Busca com Árvore Trie | `C++`, `Python`, `Tkinter` |
| **[Linguagens Formais e Autômatos (LFA)](./3_Terceiro_Semestre/Linguagens_Formais_e_Automatos)** | INF05005 | Autômatos Finitos (DFA), Gramáticas Regulares (GLUD), GLC e Autômatos com Pilha | `JFLAP` |
| **[Teoria da Computação](./3_Terceiro_Semestre/Teoria_da_Computacao)** | INF05504 | Máquinas Norma, Cálculo Lambda puro, Máquinas de Turing e Reduções/Indecidibilidade | `Norma`, `Lambda`, `Turing` |

---

### [4º Semestre (2026/1)](./4_Quarto_Semestre)
> Engenharia de software moderna, modelagem de bancos de dados relacionais, cálculo numérico computacional, ciência de dados/machine learning, processadores RISC-V com simulação arquitetural no gem5, concorrência e sistemas de arquivos no kernel Linux.

| Disciplina | Código | Conteúdos Principais | Tecnologias |
| :--- | :---: | :--- | :--- |
| **[Bancos de Dados](./4_Quarto_Semestre/Bancos_de_Dados)** | INF01145 | Modelagem E/R, DDL, DML, consultas analíticas e parser de dados | `PostgreSQL`, `SQL`, `Python` |
| **[Cálculo Numérico](./4_Quarto_Semestre/Calculo_Numerico)** | MAT01169 | Raízes, sistemas lineares/não-lineares, Simpson, interpolação e MMQ | `Python 3`, `NumPy` |
| **[Ciência de Dados I](./4_Quarto_Semestre/Ciencia_de_Dados)** | INF01057 | EDA, pré-processamento, regressão, árvores, Random Forest e CatBoost | `Python`, `Pandas`, `CatBoost` |
| **[Desenvolvimento de Software](./4_Quarto_Semestre/Desenvolvimento_de_Software)** | INF01120 | Testes unitários com JUnit 5, cobertura JaCoCo, Docker, Spring Boot e UML | `Java 17+`, `Spring`, `Docker` |
| **[Organização de Computadores B](./4_Quarto_Semestre/Organizacao_de_Computadores)** | INF01113 | Processador RISC-V RV32I e simulação de microarquitetura no gem5 | `RISC-V`, `gem5`, `C`, `Python` |
| **[Projeto e Análise de Algoritmos](./4_Quarto_Semestre/Projeto_e_Analise_de_Algoritmos)** | INF05515 | Divisão e conquista, PD, gulosos, grafos e NP-completude ([Repo Externo](https://github.com/vitorsfeijo/paa)) | `Algoritmos`, `Teoria` |
| **[Sistemas Operacionais I](./4_Quarto_Semestre/Sistemas_Operacionais)** | INF01151 | Comunicação IPC (pipes/sinais), Pthreads/concorrência e SOFS (Filesystem) | `C`, `POSIX Threads`, `FUSE` |

---

## 💻 Tecnologias & Ferramentas

<table>
  <tr>
    <td align="center" width="100">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/c/c-original.svg" width="36" height="36" alt="C" /><br />
      <b>C</b>
    </td>
    <td align="center" width="100">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/cplusplus/cplusplus-original.svg" width="36" height="36" alt="C++" /><br />
      <b>C++</b>
    </td>
    <td align="center" width="100">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/python/python-original.svg" width="36" height="36" alt="Python" /><br />
      <b>Python 3</b>
    </td>
    <td align="center" width="100">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/java/java-original.svg" width="36" height="36" alt="Java" /><br />
      <b>Java</b>
    </td>
    <td align="center" width="100">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/postgresql/postgresql-original.svg" width="36" height="36" alt="PostgreSQL" /><br />
      <b>PostgreSQL</b>
    </td>
    <td align="center" width="100">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original.svg" width="36" height="36" alt="Docker" /><br />
      <b>Docker</b>
    </td>
    <td align="center" width="100">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/spring/spring-original.svg" width="36" height="36" alt="Spring" /><br />
      <b>Spring</b>
    </td>
    <td align="center" width="100">
      <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/embeddedc/embeddedc-original.svg" width="36" height="36" alt="Verilog" /><br />
      <b>Verilog</b>
    </td>
  </tr>
</table>

- **Simuladores & Ferramentas**: gem5 Architectural Simulator, Intel Quartus Prime, JFLAP, DrRacket, Simuladores Didáticos UFRGS (Neander, Ahmes, Ramses, César).
- **Compiladores & Ambientes**: GCC/G++, Clang, OpenJDK 17+, Maven, Python Virtualenv, Jupyter Notebook.

---

## 🚀 Destaques dos Projetos

- 🎮 **[Jogo 2D com Raylib (Algoritmos e Programação)](./1_Primeiro_Semestre/Algoritmos_e_Programacao/Vitor_Feijo_E_Gabriel_Nunes)**: Jogo de nave/jetpack desenvolvido em C com rolagem lateral contínua, geração e leitura de mapas por arquivos de texto, controle de física/gravidade e persistência de leaderboard em arquivo binário.
- ⚡ **[Processador SACI em Verilog (Circuitos Digitais)](./3_Terceiro_Semestre/Circuitos_Digitais/Saci_Vitor)**: Implementação completa em HDL do processador didático SACI, incluindo ULA parametrizada, decodificador de instruções, FSM (Moore/Mealy), banco de registradores e display de 7 segmentos.
- 🎬 **[Sistema de Busca de Filmes e Tags (CPD)](./3_Terceiro_Semestre/Classificacao_e_Pesquisa_de_Dados/Trabalho_Final)**: Aplicação desktop em Python (GUI Tkinter) combinando **Árvore Trie** para autocompletar títulos e **Tabelas Hash** para indexar avaliações, gêneros e tags do dataset MovieLens.
- 🗄️ **[Banco de Dados Relacional Steam (Bancos de Dados)](./4_Quarto_Semestre/Bancos_de_Dados)**: Modelagem relacional completa em PostgreSQL para o ecossistema de jogos, contendo DDL com constraints estritas, DML populado via parser Python JSON e dezenas de consultas analíticas avançadas.
- 🖥️ **[Processador RISC-V e Simulação gem5 (Org. Computadores)](./4_Quarto_Semestre/Organizacao_de_Computadores)**: Implementação do datapath RV32I e estudo microarquitetural com o simulador **gem5**, avaliando o impacto de caches L1/L2, preditores de desvio e latência de memória sob benchmarks em C.
- 🐧 **[Sistema de Arquivos SOFS & Pthreads (Sistemas Operacionais)](./4_Quarto_Semestre/Sistemas_Operacionais)**: Implementação em C de um sistema de arquivos baseado em inodes/blocos e resolução de concorrência multithread com Pthreads e semáforos.

---

## 📂 Árvore de Diretórios

```
Ciencia_da_Computacao_UFRGS/
├── 1_Primeiro_Semestre/
│   ├── Algoritmos_e_Programacao/              # C e Jogo 2D com Raylib
│   ├── Fundamentos_de_Algoritmos/             # Listas 1-4, Árvores e Provas em Racket
│   └── Introducao_a_Arquitetura_de_Computacao/ # Trabalhos Neander e Ahmes
├── 2_Segundo_Semestre/
│   ├── Arquitetura_de_Computadores_1/         # Trabalhos Ramses, Cesar e Intel x86
│   ├── Estrutura_de_Dados/                    # Listas Encadeadas e Circulares em C
│   └── Outros/                                # Calculadora de Combinatória em C
├── 3_Terceiro_Semestre/
│   ├── Arquitetura_de_Computadores_2/         # Simulador Cache C++ e Relatórios
│   ├── Circuitos_Digitais/                    # Projetos Verilog Quartus (Saci, Somadores)
│   ├── Classificacao_e_Pesquisa_de_Dados/     # Labs C++ e Trabalho Final Trie/Hash
│   ├── Linguagens_Formais_e_Automatos/        # Modelagem JFLAP (DFA, GLC, Pilha)
│   └── Teoria_da_Computacao/                  # Norma, Cálculo Lambda, Turing e Reduções
└── 4_Quarto_Semestre/
    ├── Bancos_de_Dados/                     # Projeto Relacional PostgreSQL (Steam)
    ├── Calculo_Numerico/                    # Implementações de Métodos Numéricos Python
    ├── Ciencia_de_Dados/                    # Labs 1-6 de EDA e Machine Learning (CatBoost)
    ├── Desenvolvimento_de_Software/         # Java, Spring Boot, Testes JUnit, Docker e UML
    ├── Organizacao_de_Computadores/         # Processador RISC-V e Simulação gem5
    ├── Projeto_e_Analise_de_Algoritmos/     # Paradigmas de Algoritmos (Link Repo PAA)
    └── Sistemas_Operacionais/               # Labs C de IPC, Threads e Filesystem SOFS
```

---

<div align="center">
  <sub>Desenvolvido por <b>Vítor Santana Feijó</b> durante o curso de Bacharelado em Ciência da Computação — INF / UFRGS.</sub>
</div>
