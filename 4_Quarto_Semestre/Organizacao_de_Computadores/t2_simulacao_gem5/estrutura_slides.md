# Estrutura Sugerida para Apresentação (PowerPoint — 10 Slides)

Este guia define a distribuição de conteúdo slide por slide para a apresentação do Trabalho Prático 2. A estrutura foi planejada para se encaixar no limite máximo exato exigido de 10 slides, garantindo consistência visual e teórica entre todas as seções analisadas.

---

### **Slide 1: Título e Identificação**
*   **Título:** Análise de Sensibilidade Arquitetural no Simulador gem5
*   **Subtítulo:** Impacto da Organização do Processador e Hierarquia de Memória em Diferentes Perfis de Aplicação
*   **Conteúdo:**
    *   Nomes dos integrantes do grupo
    *   Disciplina: INF01113 – Organização de Computadores B
    *   Professor: Antonio Carlos Schneider Beck Filho
    *   Data da apresentação
*   **Dica Visual:** Design limpo, profissional, com paleta de cores consistente (ex: azul escuro e verde esmeralda).

---

### **Slide 2: Metodologia e Benchmarks Utilizados**
*   **Título:** Benchmarks e Perfis de Execução
*   **Conteúdo:**
    *   **Multiplicação de Matrizes (`matrix.c`):** Aritmeticamente denso ($O(N^3)$), alta localidade espacial de dados, padrão de acesso previsível. Avalia o poder computacional bruto (ULA) e caches.
    *   **Merge Sort (`sort.c`):** Lógica intensiva em desvios condicionais (*branches*), recursivo. Avalia o impacto das tomadas de decisão e penalidade do pipeline por erro de predição.
    *   **Busca em Largura - BFS (`bfs.c`):** Algoritmo em grafo esparso, acessos aleatórios e saltos na memória. Avalia o tempo de espera do subsistema de memória (gargalo de cache/latência).
*   **Dica Visual:** Ícones ou logos simplificados para diferenciar os 3 perfis (Matemático, Controle, Grafo).

---

### **Slide 3: Configuração Baseline (Linha de Base Fixa)**
*   **Título:** Definição da Arquitetura Baseline
*   **Conteúdo:**
    *   Explicação sobre a escolha da configuração de base estável que difere da original do simulador:
        *   **Largura do Pipeline (Widths):** Aumentada de 2 para **4** (Fetch, Decode, Issue, Commit) para otimizar o Paralelismo ao Nível de Instrução (ILP).
        *   **Reorder Buffer (ROB):** Expandido para **128 entradas** para suportar a janela Out-of-Order de 4 instruções.
        *   **Cache L2:** Aumentada para **512kB** para reduzir a latência de misses secundários.
    *   *Justificativa:* O aumento do pipeline exigia buffers maiores e melhor hierarquia L2 para evitar gargalos estruturais imediatos.
*   **Dica Visual:** Uma tabela ou fluxograma simples comparando "Original do Simulador" vs. "Nosso Baseline".

---

### **Slide 4: Parâmetro 1 — Tamanho da Cache L1-D (Resultados)**
*   **Título:** Sensibilidade ao Tamanho da Cache L1 de Dados — Resultados
*   **Gráficos do Slide:**
    *   Inserir os gráficos gerados: `l1_ipc.png` (IPC) e `l1_tempo.png` (Tempo).
*   **Dados em Destaque:**
    *   `matrix`: Salto de IPC de **1.06** para **1.43** e queda de ~25% no tempo de execução ao usar 64kB.
    *   `bfs`: Performance idêntica entre 16kB, 32kB e 64kB (tempo estável em ~0.159s, IPC ~0.80).
    *   `sort`: Ganho marginal e linear de desempenho.
*   **Dica Visual:** Posicionar os dois gráficos lado a lado ou em destaque, com caixas de chamada (callouts) apontando para o salto de 64kB no `matrix`.

---

### **Slide 5: Parâmetro 1 — Tamanho da Cache L1-D (Análise)**
*   **Título:** Análise L1-D: Localidade Espacial vs. Acessos Aleatórios
*   **Análise Física dos Resultados:**
    *   **Por que o `matrix` acelerou tanto?** Os blocos das matrizes multiplicadas passaram a caber inteiramente no espaço de 64kB da cache L1, eliminando stolls por misses de dados reincidentes.
    *   **Por que o `bfs` ignorou o aumento de cache?** A travessia de grafos esparsos gera acessos dispersos sem localidade temporal ou espacial relevante. Aumentar a capacidade de L1 é inútil para amortecer acessos imprevisíveis.
*   **Conclusão/Diretriz de Custo-Benefício:** Caches maiores são recomendadas especificamente para processamento aritmético de vetores e matrizes estruturadas.

---

### **Slide 6: Parâmetro 2 — Preditor de Desvios (Resultados)**
*   **Título:** Sensibilidade ao Tipo de Preditor de Desvios — Resultados
*   **Gráficos do Slide:**
    *   Inserir os gráficos gerados: `bp_ipc.png` (IPC) e `bp_tempo.png` (Tempo).
*   **Dados em Destaque:**
    *   `sort`: Melhor desempenho com o preditor `BiModeBP` (IPC = **1.022**, tempo = **0.0077s**).
    *   `bfs`: Pior desempenho com `LocalBP` (IPC despenca para **0.711**) e `BiModeBP` (IPC de **0.736**), mantendo excelente desempenho com o `TournamentBP` do baseline (IPC = **0.803**).
    *   `matrix`: Praticamente imune a variações (IPC estável em 1.06).

---

### **Slide 7: Parâmetro 2 — Preditor de Desvios (Análise)**
*   **Título:** Análise da Predição: Histórico Global vs. Aliasing
*   **Análise Física dos Resultados:**
    *   **Por que o `sort` melhorou com o `BiModeBP`?** O Merge Sort possui loops internos e tomadas de decisão rápidas que alternam a direção do branch dinamicamente. O `BiModeBP` divide a tabela de predição em caminhos de "tomado" e "não-tomado", reduzindo significativamente a colisão e aliás de histórico prejudicial de desvios concorrentes.
    *   **Por que o `bfs` piorou fora do `TournamentBP`?** O BFS possui desvios que dependem fortemente de correlações globais distantes (ex: se o nó anterior tinha filhos ou não). O `TournamentBP`, por ser híbrido e usar histórico global maior, é mais eficaz para este tipo de lógica do que preditores estritamente locais ou bipartidos.

---

### **Slide 8: Parâmetro 3 — Quantidade de ULAs (Resultados)**
*   **Título:** Sensibilidade ao Número de ULAs Inteiras — Resultados
*   **Gráficos do Slide:**
    *   Inserir os gráficos gerados: `alu_ipc.png` (IPC) e `alu_tempo.png` (Tempo).
*   **Dados em Destaque:**
    *   `matrix`: Redução no tempo de **0.0440s** (1 ALU) para **0.0390s** (4 ALUs) e subida de IPC de **0.98** para **1.11**.
    *   `bfs`: Grande salto de 1 para 2 ALUs (IPC subindo de **0.68** para **0.80**), mas ganho nulo com 4 ALUs.
    *   `sort`: Desempenho ideal com 2 ALUs, sofrendo degradação sutil com 4 ALUs (IPC cai de **0.967** para **0.963**).

---

### **Slide 9: Parâmetro 3 — Quantidade de ULAs (Análise)**
*   **Título:** Análise ULA: Paralelismo Aritmético vs. Gargalo Estrutural
*   **Análise Física dos Resultados:**
    *   **1 ULA (Gargalo Estrutural):** Limitar o pipeline largo (width=4) para apenas 1 ALU causou queda severa em todos os benchmarks, pois as instruções aritméticas precisavam aguardar em filas de espera na unidade de execução (*Execute stall*).
    *   **4 ULAs (Retornos Decrescentes):** Apenas o `matrix` (puramente numérico) se beneficiou de 4 ALUs, demonstrando Paralelismo ao Nível de Instrução (ILP) aritmético abundante.
    *   O `bfs` e o `sort` são limitados por dependências de dados seriais e latência de memória/controle, deixando as ALUs adicionais ociosas.
*   **Conclusão/Diretriz:** **2 ULAs** representam o *sweet spot* de custo-benefício de área e consumo.

---

### **Slide 10: Conclusões Gerais e Diretrizes de Projeto**
*   **Título:** Conclusões e Diretrizes de Projeto
*   **Diretrizes Consolidadas:**
    1.  **Investimento na L1-D (64kB):** Recomendado apenas se o foco da CPU for processamento científico/álgebra linear (ex. Matrix).
    2.  **Robustez do TournamentBP:** Embora o `BiModeBP` seja excelente para ordenações, o preditor híbrido `TournamentBP` é o mais indicado como padrão por se adaptar melhor a estruturas complexas (ex. BFS) sem prejudicar os demais.
    3.  **Dimensionamento de ALUs:** Manter **2 ALUs** evita desperdício de energia e área de silício, sendo suficiente para a maior parte das cargas de trabalho práticas do dia a dia.
*   **Mensagem Final:** A arquitetura ideal depende diretamente do domínio da aplicação. Não existe um "tamanho único de hardware" ideal.
