# 🖥️ Organização de Computadores B (INF01113)

Este diretório contém os trabalhos práticos desenvolvidos para a disciplina de **Organização de Computadores B**, focada no projeto de processadores com arquitetura de conjunto de instruções (ISA) **RISC-V** e na exploração microarquitetural de alto desempenho através do simulador **gem5**.

---

## 📂 Trabalhos Desenvolvidos

### 1. [`t1_processador_riscv/`](./t1_processador_riscv) — Processador RISC-V (RV32I)

Projeto e implementação do conjunto de instruções básico e do caminho de dados (*Datapath*) da arquitetura aberta **RISC-V (RV32I de 32 bits)**.

#### 🛠️ Conteúdo e Arquivos
* **Módulos do Processador**: Banco de registradores (`x0`-`x31`), Unidade Lógica e Aritmética (ULA com suporte a `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLT`, `SLL`, `SRL`, `SRA`), unidade de extensão de imediatos (*ImmGen*) e decodificador de instruções.
* **Instruções Implementadas**: Formatos R (aritmético-lógicas), I (imediatos e loads), S (stores), B (branches condicionais: `BEQ`, `BNE`, `BLT`, `BGE`), U (`LUI`, `AUIPC`) e J (`JAL`, `JALR`).
* **Documentação & Validação**:
  * Esquemáticos e diagramas de interconexão do datapath.
  * Relatório técnico detalhando o tratamento de hazards, cálculos de sinais de controle e formas de onda de teste.

---

### 2. [`t2_simulacao_gem5/`](./t2_simulacao_gem5) — Simulação Microarquitetural com gem5

Estudo empírico e exploração de espaço de projeto (*Design Space Exploration*) utilizando o simulador arquitetural de padrão industrial **gem5**.

#### 🛠️ Conteúdo e Arquivos
* **Cargas de Trabalho (Benchmarks em C)**:
  * Diretório `c_programs/`: Algoritmos intensivos em computação e acesso à memória (multiplicação de matrizes, processamento de vetores, algoritmos de ordenação).
* **Configuração da Microarquitetura (`gem5`)**:
  * Modelagem de processadores *In-Order* (TimingSimpleCPU) vs *Out-of-Order* (O3CPU / superscalar).
  * Variação de parâmetros da hierarquia de memória: tamanhos de cache L1I/L1D e L2, associatividade e políticas de substituição.
  * Preditores de desvio (*Branch Predictors*): Tournament, BiMode, Local e Global.
* **Resultados e Análise Estatística**:
  * Diretório `results/`: Extração de métricas de simulação (`stats.txt`), incluindo IPC (*Instructions Per Cycle*), contagem de ciclos, taxas de *miss* de cache e taxas de acerto de branches.
  * Diretório `graficos/`: Scripts em Python para compilação visual e gráficos comparativos de desempenho.

---

[⬅ Voltar para o 4º Semestre](../README.md)
