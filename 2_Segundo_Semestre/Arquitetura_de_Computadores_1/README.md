# 🏛️ Arquitetura de Computadores I (INF01108)

Este diretório contém os três trabalhos práticos de programação em linguagem Assembly desenvolvidos para a disciplina de **Arquitetura de Computadores I**, explorando a evolução dos modelos de computadores didáticos até a arquitetura x86 real (Intel 8086).

---

## 📂 Trabalhos Desenvolvidos

### 1. [`Trabalho_Ramses/`](./Trabalho_Ramses)
* **Arquitetura**: RAMSES (máquina didática da UFRGS com múltiplos modos de endereçamento: direto, indireto e indexado por registradores `X`, `A` e `B`).
* **Arquivos**:
  * `Trabalho_Ramses_-_Vitor_Santana_Feijo.rad`: Código fonte Assembly do programa RAMSES.
  * `Especificacao_RAMSES.pdf`: Enunciado e especificações das operações e dados.
* **Problema Resolvido**:
  * O programa processa uma lista de paredes representadas por triplas na memória (compostas por altura, largura e quantidade de azulejos). Para cada parede, calcula se haverá falta ou sobra de azulejos em relação a uma altura alvo (`HIG`), calculando as diferenças multiplicadas e acumulando nas variáveis de saída `ADQ` (adquirir) e `DES` (descartar).

---

### 2. [`Trabalho_Cesar/`](./Trabalho_Cesar)
* **Arquitetura**: CÉSAR (máquina didática de 16 bits baseada no PDP-11, com registradores de uso geral `R0`-`R7`, suporte nativo a pilha e periféricos mapeados em memória).
* **Arquivos**:
  * `trabalho_final_vitor_feijo.ced`: Código fonte Assembly CÉSAR com tratamento de interrupções e rotinas de I/O.
  * `trabalho_final.mem` / `trabalho_final.map`: Imagem binária e mapa de símbolos.
  * `Especificacao_CESAR_-_Grellert.pdf`: Especificação do trabalho.
* **Problema Resolvido**:
  * Utilização da tabela de vetores de interrupção (`IVET`), configuração das máscaras de habilitação (`INTE`) e status (`INTS`), tratamento de temporizador (`TIMDT`), teclado (`TECDT`/`TECST`) e renderização de saída no display/visor (`VISOR`).

---

### 3. [`Trabalho_Intel/`](./Trabalho_Intel)
* **Arquitetura**: Intel 8086 (x86 Assembly real em modo real / DOS).
* **Arquivos**:
  * `Trabalho_Intel.asm`: Código fonte x86 estruturado com segmentos `.model small`, `.stack 100h`, `.data` e `.code`.
  * `DADOS.TXT`: Arquivo de entrada contendo matriz de valores numéricos.
  * `EXP.TXT`: Arquivo de entrada contendo expressões aritméticas / fórmulas de planilha eletrônica.
  * `Especificaçcao_INTEL-_v2.pdf`: Especificação do projeto.
* **Problema Resolvido**:
  * Implementação de um **avaliador de planilhas eletrônicas / fórmulas matriciais**:
    1. **I/O de Arquivos com Interrupções DOS (`INT 21h`)**: Abertura, leitura em buffer de múltiplos bytes e fechamento dos arquivos `DADOS.TXT` e `EXP.TXT`.
    2. **Parser e Tokenizador**: Conversão de caracteres ASCII para números inteiros (com suporte a inteiros negativos via flags) e separadores.
    3. **Avaliação e Cálculo de Expressões**: Processamento de referências de células matriciais (linhas/colunas) e aplicação das operações aritméticas correspondentes.

---

[⬅ Voltar para o 2º Semestre](../README.md)
