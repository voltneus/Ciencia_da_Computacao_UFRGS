# ⚙️ Introdução à Arquitetura de Computadores (INF01107)

Este diretório contém os trabalhos práticos em linguagem Assembly desenvolvidos para os processadores didáticos **Neander** e **Ahmes**, concebidos no Instituto de Informática da UFRGS para o ensino dos fundamentos de organização de computadores.

---

## 🎯 Conceitos Estudados

- **Arquitetura de Von Neumann**: Memória compartilhada para código e dados, barramentos de endereço e dados, registrador acumulador (AC) e contador de programa (PC).
- **Ciclo de Instrução**: Busca (*fetch*), decodificação e execução.
- **Flags de Condição**: Zero (Z), Negativo (N), Carry/Vai-um (C), Overflow (V) e Borrow (B).
- **Mapeamento de Memória**: Estruturação manual de variáveis, vetores e ponteiros na memória RAM.
- **Técnicas de Programação em Baixo Nível**: Máscaras de bits (*bitmasks*), loops controlados por decremento e saltos condicionais (`JZ`, `JNZ`, `JN`, `JC`, `JB`).

---

## 📂 Trabalhos Desenvolvidos

### 1. [`Trabalho_Neander/`](./Trabalho_Neander)
* **Arquitetura**: Neander (palavras de 8 bits, 16 instruções, acumulador único).
* **Arquivos**:
  * `VitorFeijo588403.txt`: Código fonte do programa Assembly Neander com comentários detalhados e mapa de variáveis.
  * `VitorFeijo588403.mem`: Imagem de memória hexadecimal gerada para o simulador.
  * `tneander242.pdf`: Especificação e enunciado do trabalho.
* **Objetivo do Programa**:
  1. **Operação Bitwise XOR**: Implementação da operação OU-Exclusivo lógico entre duas variáveis de 8 bits (`A` e `B`), utilizando apenas as operações primitivas do Neander (`NOT`, `AND`, `OR`, `STA`, `LDA`).
  2. **Distância de Hamming**: Cálculo do número de posições nas quais os bits correspondentes de `A` e `B` diferem (contagem de bits `1` no resultado do XOR), empregando rotações e máscaras lógicas.

---

### 2. [`Trabalho_Ahmes/`](./Trabalho_Ahmes)
* **Arquitetura**: Ahmes (evolução do Neander com 24 instruções, flags adicionais de Carry e Overflow, operações aritméticas e lógicas estendidas).
* **Arquivos**:
  * `vitor588403.ahd`: Código Assembly do programa para o montador Ahmes.
  * `vitor588403.mem`: Imagem de memória pronta para execução no simulador.
  * `tahm242.pdf`: Especificação técnica e requisitos do trabalho.
* **Objetivo do Programa**:
  * Implementação de rotinas de **divisão inteira de múltiplos bytes por subtrações sucessivas**, controle de flags de *Borrow/Carry* e armazenamento estruturado de Quociente e Resto na memória.

---

[⬅ Voltar para o 1º Semestre](../README.md)
