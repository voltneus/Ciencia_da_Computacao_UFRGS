# ⚡ Arquitetura de Computadores II (INF01112)

Este diretório contém as implementações práticas, códigos de simulação e relatórios técnicos desenvolvidos para a disciplina de **Arquitetura de Computadores II**, focada em técnicas avançadas de microarquitetura, hierarquia de memória e paralelismo.

---

## 📂 Trabalhos e Relatórios

### 1. [`Trabalho_1/`](./Trabalho_1) — Simulador de Memória Cache

Implementação de um simulador de memória cache modular e configurável em **C++**, com análise estatística e geração de gráficos automatizada em **Python**.

#### 🛠️ Arquivos
* `Cache_INF01112.cpp`: Código principal do simulador em C++, modelando linhas de cache, tags, bits de validade, contadores de *Hits* e *Misses*.
* `Cache_INF01112_Tests.cpp`: Bateria de testes e geração de cargas de trabalho sintéticas de acessos à memória.
* `graph_hitmiss.py`: Script Python com Matplotlib para traçar curvas comparativas de taxas de acerto e falha em diferentes configurações de capacidade e associatividade.
* `graph_boxplot.py`: Script Python para renderizar gráficos *Boxplot* de dispersão e variabilidade de desempenho.
* `trabalho_cache.pdf`: Enunciado e requisitos do simulador.

#### 📊 Principais Aspectos Simulados
* Mapeamento direto, associatividade por conjuntos e associatividade plena.
* Políticas de substituição (LRU — *Least Recently Used*, Random).
* Impacto da localidade espacial e temporal no comportamento da cache.

---

### 2. [`Trabalho_2/`](./Trabalho_2) — Paralelismo em Nível de Instrução (ILP)
* **Arquivo**: `Trabalho2ArqII.pdf`
* **Temas Abordados**:
  * Execução fora de ordem (*Out-of-Order Execution*) e algoritmo de Tomasulo.
  * Resolução de conflitos de dados (RAW, WAR, WAW) através de renomeação de registradores (*Register Renaming*).
  * Estágios de Pipeline superescalar, estações de reserva (*Reservation Stations*) e *Reorder Buffer* (ROB).

---

### 3. [`Trabalho_3/`](./Trabalho_3) — Previsão de Desvios (Branch Prediction)
* **Arquivo**: `Predictions.pdf`
* **Temas Abordados**:
  * Preditores estáticos (*Always Taken*, *Backward Taken / Forward Not Taken*).
  * Preditores dinâmicos locais (contadores saturados de 1 e 2 bits).
  * Preditores correlacionados globais e híbridos (Gshare, Yeh & Patt).
  * Análise de penalidades de desvio (*branch misprediction penalties*) no desempenho geral do pipeline.

---

[⬅ Voltar para o 3º Semestre](../README.md)
