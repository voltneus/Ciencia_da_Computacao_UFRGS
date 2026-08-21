# 🧠 Teoria da Computação (INF05504)

Este diretório contém os trabalhos práticos e relatórios teóricos desenvolvidos para a disciplina de **Teoria da Computação**, explorando os limites fundamentais da computabilidade, equivalência de modelos formais e o fenômeno da indecidibilidade.

---

## 📂 Trabalhos Desenvolvidos

### 1. [`Trabalho_Norma/`](./Trabalho_Norma) — Máquina Norma
* **Arquivos**: Programas `1a.mn` até `3a.mn`, `Trabalho-1-Máquina-Norma.pdf`
* **Modelo**: Máquina de registradores com operações elementares: adição (`add`), subtração (`sub`), teste de zero (`zero`) e desvios condicionais.
* **Objetivo**: Implementação de funções aritméticas computáveis (multiplicação, exponenciação, divisão inteira) e predicados de decisão estruturados com controle rigoroso de registradores.

---

### 2. [`Trabalho_Lambda/`](./Trabalho_Lambda) — Cálculo Lambda Puro
* **Arquivos**: `trabalho.lam`, `Trabalho-2-Calculo-Lambda.pdf`
* **Modelo**: Cálculo Lambda não-tipado com aplicação, abstração e variáveis puras.
* **Objetivo**: Codificação de numerais de Church, operadores booleanos (*true*, *false*, *and*, *or*, *not*), operações aritméticas (sucessor, adição, multiplicação, predecessor) e recursão por meio do **Combinador de Ponto Fixo (Combinador Y)**.

---

### 3. [`Trabalho_Turing/`](./Trabalho_Turing) — Máquinas de Turing
* **Arquivos**: Programas `1b.mt` até `4d.mt`, `Trabalhos_teoria_da_computação_Turing.pdf`
* **Modelo**: Máquina de Turing determinística com fita infinita e cabeçote de leitura/escrita.
* **Objetivo**: Projeto de máquinas para reconhecimento de linguagens formais não-livres de contexto (\(\{a^n b^n c^n \mid n \ge 0\}\)), cópia de cadeias, deslocamentos de fita e computação de funções unárias e binárias.

---

### 4. [`Trabalho_Reducoes/`](./Trabalho_Reducoes) — Reduções e Indecidibilidade
* **Arquivos**: `Trabalho4_teoria_da_computação_reducao.pdf`, `Trabalho_4_-_Indecidibilidade_de_Problemas.pdf`
* **Temas e Provas**:
  * Provas formais de indecidibilidade através de **Reduções de Mapeamento** (\(A \le_m B\)).
  * Aplicação do **Problema da Parada** (\(HALT_{TM}\)) e da Linguagem de Aceitação (\(A_{TM}\)).
  * Aplicação do **Teorema de Rice** para demonstrar que qualquer propriedade semântica não-trivial de linguagens Turing-reconhecíveis é indecidível.

---

[⬅ Voltar para o 3º Semestre](../README.md)
