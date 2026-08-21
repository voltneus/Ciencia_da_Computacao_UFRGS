# 📕 4º Semestre — Ciência da Computação (UFRGS)

Este diretório centraliza os projetos, laboratórios práticos, relatórios e códigos desenvolvidos durante o **quarto semestre** do curso de Bacharelado em Ciência da Computação na UFRGS (período letivo 2026/1).

---

## 📑 Disciplinas do Semestre

### 1. [Bancos de Dados (INF01145)](./Bancos_de_Dados)
* **Tecnologias**: `PostgreSQL`, `SQL`, `Python` (Parser JSON)
* **Conteúdos Principais**: Modelagem conceitual e lógica (DER / Esquema Relacional), normalização, integridade referencial, DDL (`tabelas.sql`), DML (`instancias.sql`) e consultas analíticas avançadas (`consultas.sql`) para o ecossistema de jogos e e-sports (Steam).

### 2. [Cálculo Numérico (MAT01169)](./Calculo_Numerico)
* **Linguagem**: `Python 3` (NumPy, Matplotlib)
* **Conteúdos Principais**: Representação de números em ponto flutuante/fixo, raízes de funções (Newton-Raphson, Bisseção, Secante), resolução de sistemas lineares (Eliminação de Gauss, Fatoração LU, Métodos iterativos de Jacobi e Gauss-Seidel), integração numérica (Regra dos Trapézios e Simpson), interpolação polinomial (Lagrange, Newton) e ajuste de curvas por Mínimos Quadrados.

### 3. [Ciência de Dados I (INF01057)](./Ciencia_de_Dados)
* **Linguagem**: `Python 3` (`Pandas`, `NumPy`, `Scikit-Learn`, `CatBoost`, `Jupyter Notebook`)
* **Conteúdos Principais**: Análise exploratória de dados (EDA), tratamento de valores ausentes e outliers, engenharia de atributos (*feature engineering*), modelos de regressão, árvores de decisão, florestas aleatórias (*Random Forest*) e algoritmos de *Gradient Boosting* (CatBoost).

### 4. [Desenvolvimento de Software (INF01120)](./Desenvolvimento_de_Software)
* **Linguagens & Tecnologias**: `Java 17+`, `Spring Boot`, `JUnit 5`, `JaCoCo`, `Docker`, `Maven`, `UML`
* **Conteúdos Principais**: Metodologias ágeis e fluxo Git, testes unitários automatizados com cobertura de código, arquitetura orientada a objetos, diagramas de classe UML e desenvolvimento de aplicação backend de processamento de transações financeiras containerizada com Docker.

### 5. [Organização de Computadores B (INF01113)](./Organizacao_de_Computadores)
* **Tecnologias**: `RISC-V`, `gem5`, `C`, `Python` (Matplotlib)
* **Conteúdos Principais**: Microarquitetura do processador RISC-V (datapath monociclo/pipeline, unidade de controle, decodificação de instruções e hazard handling) e simulação de microarquitetura avançada com **gem5** (análise de IPC, políticas de cache, branch prediction e latência de memória sob benchmarks em C).

### 6. [Projeto e Análise de Algoritmos (INF05515)](./Projeto_e_Analise_de_Algoritmos)
* **Paradigmas**: Divisão e Conquista, Programação Dinâmica, Algoritmos Gulosos, Algoritmos em Grafos, Análise Amortizada e NP-Completude.
* **Nota**: Esta disciplina possui um **[repositório dedicado próprio](https://github.com/vitorsfeijo/paa)**.

### 7. [Sistemas Operacionais I (INF01151)](./Sistemas_Operacionais)
* **Linguagem**: `C` (POSIX/Linux API)
* **Conteúdos Principais**:
  * **Lab 1 (IPC)**: Comunicação entre processos via *pipes*, tratamento de sinais (`SIGINT`, `SIGCHLD`) e renderização paralela de fractal Mandelbrot.
  * **Lab 2 (Concorrência)**: Programação multithread com **POSIX Threads (`pthreads`)**, exclusão mútua (`pthread_mutex`), variáveis de condição e semáforos para simulação da ponte Orion.
  * **Lab 4 (SOFS)**: Implementação de um **Sistema de Arquivos** baseado em blocos/inodes (*Simple Operating File System*) com suporte à API FUSE em Linux.

---

## 📂 Estrutura de Pastas

```
4_Quarto_Semestre/
├── Bancos_de_Dados/                     # Projeto Relacional PostgreSQL (Steam/Jogos)
├── Calculo_Numerico/                    # Implementações de Métodos Numéricos em Python
├── Ciencia_de_Dados/                    # Labs 1 a 6 de Análise e Machine Learning
├── Desenvolvimento_de_Software/         # Testes JUnit, Docker, Java/Spring e UML
├── Organizacao_de_Computadores/         # Processador RISC-V e Simulação gem5
├── Projeto_e_Analise_de_Algoritmos/     # Paradigmas de Algoritmos (Link para repo PAA)
└── Sistemas_Operacionais/               # Labs C de IPC, Threads e Filesystem SOFS
```

---

[⬅ Voltar para a Página Principal](../README.md)
