# 🔌 Circuitos Digitais (INF01058)

Este diretório contém os projetos de lógica digital, esquemáticos e circuitos sintetizados em **Verilog HDL** utilizando o ambiente **Intel Quartus Prime** para a disciplina de **Circuitos Digitais**.

---

## 🎯 Conceitos Chave

- **Lógica Combinacional**: Portas lógicas fundamentais, simplificação por mapas de Karnaugh, tabelas-verdade e minimização por mintermos.
- **Lógica Sequencial**: Flip-flops tipo D, registradores paralelos e contadores síncronos.
- **Máquinas de Estados Finitos (FSM)**: Projeto de controladores com modelos de Moore e Mealy.
- **Microarquitetura de Processadores**: Projeto integrado de Caminho de Dados (*Datapath*) e Unidade de Controle (*Control Unit*).

---

## 📂 Projetos Desenvolvidos

### 1. [`Meio_Somador/`](./Meio_Somador)
* **Documento**: `Meio_somador_-_circuitos_digitais.pdf`
* **Descrição**: Projeto, simulação e formas de onda de um meio-somador de 1 bit (`Half Adder`), gerando saídas de Soma (\(S = A \oplus B\)) e Vai-um (\(C_{out} = A \cdot B\)).

### 2. [`Somador_Completo/`](./Somador_Completo)
* **Arquivos**: `sc.v` (módulo Verilog), `ms_esq_verilog.bdf` (diagrama de blocos no Quartus), `Waveform.vwf`
* **Descrição**: Projeto de somador completo (`Full Adder`) com entrada de *Carry-in* (\(C_{in}\)), propagação de vai-um e validação por diagramas de temporização vetorial.

### 3. [`cout_e_soma_com_mintermos/`](./cout_e_soma_com_mintermos)
* **Arquivo**: `cout_e_soma_com_mintermos.txt`
* **Descrição**: Dedução formal de funções booleanas a partir da soma canônica de produtos (mintermos).

### 4. [`pitanga/`](./pitanga) e [`quartus/`](./quartus)
* **Arquivos**: `me012p.v`, `Cdpitangap2.pdf`, `Relatorio me012p.pdf`
* **Descrição**: Projeto da Máquina de Estados Finitos (FSM) do processador Pitanga e simulações funcionais no Quartus.

### 5. [`Saci_Vitor/`](./Saci_Vitor) — Processador SACI (Projeto Completo)
* **Arquivos Principais**:
  * `Vitor_Saci.v` / `saci_pitanga.v`: Top-level integrando todos os blocos do processador SACI.
  * `saci/ula_pit.v`: Unidade Lógica e Aritmética com operações de adição, subtração, lógica booleana e deslocamentos.
  * `saci/controle_saci_pit.v`, `ccSaidaMoore.v`, `ccSaidaMealy.v`: Unidade de controle e decodificação de instruções.
  * `saci/reg8_pit.v`, `reg3.v`: Bancos de registradores de uso geral e registradores de estado.
  * `saci/display7seg.v`: Decodificador e multiplexador para visualização de dados em displays de 7 segmentos.
  * `saci/memoria_pit.v`, `rom_prog_pit.v`: Memória RAM de dados e ROM de instruções.
  * `Relatorio Saci.pdf`: Relatório técnico completo documentando a arquitetura, simulações de temporização e testes de instruções.

---

[⬅ Voltar para o 3º Semestre](../README.md)
