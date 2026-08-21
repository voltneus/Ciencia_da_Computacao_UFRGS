# 🚀 Algoritmos e Programação (INF01202)

Este diretório contém os códigos, atividades práticas e o trabalho final desenvolvidos para a disciplina de **Algoritmos e Programação** do Instituto de Informática (INF) da UFRGS.

---

## 🎯 Objetivos de Aprendizado

- Domínio da linguagem **C** e boas práticas de programação estruturada.
- Manipulação de tipos primitivos, estruturas condicionais, laços de repetição e funções.
- Alocação e manipulação de vetores, matrizes multidimensionais e cadeias de caracteres (*strings*).
- Uso de **ponteiros** e passagens de parâmetros por referência.
- Definição e composição de tipos de dados heterogêneos (`struct`).
- Manipulação de fluxo de arquivos em formato de texto e formato binário (`fopen`, `fread`, `fwrite`, `fclose`).

---

## 📂 Conteúdo e Projetos

### 1. `Fatorial.c`
* **Descrição**: Implementação em C para cálculo fatorial, exercitando conceitos fundamentais de laços de repetição e manipulação de tipos numéricos.

---

### 2. [Vitor_Feijo_E_Gabriel_Nunes](./Vitor_Feijo_E_Gabriel_Nunes) — Trabalho Final (Jogo 2D com Raylib)

Desenvolvido em dupla por **Vítor Santana Feijó** e **Gabriel Nunes**.

Trata-se de um jogo 2D de corrida contínua com temática espacial/foguete, inspirado em clássicos de *side-scroller* (como *Jetpack Joyride* / *Flappy Bird*).

#### 🛠️ Tecnologias Utilizadas
* **Linguagem**: C (padrão C99)
* **Biblioteca Gráfica**: [Raylib](https://www.raylib.com/)
* **Compilação**: GCC / Code::Blocks / Makefile

#### 🎮 Principais Mecânicas e Funcionalidades
1. **Física e Movimentação**:
   * Gravidade constante e aceleração vertical ao acionar a propulsão (`JET_SPEED_Y`).
   * Limites de tela superior e inferior (`LIM_SUPERIOR`, `LIM_INFERIOR`).
2. **Cenário Dinâmico e Rolagem de Mapa**:
   * Leitura de fases a partir de matrizes em arquivos de texto (`mapa1.txt`, `mapa2.txt`, `mapa3.txt`).
   * Rolagem contínua suave do mapa com velocidade progressiva.
3. **Detecção de Colisões**:
   * Algoritmo de colisão retangular entre a *hitbox* do personagem (`Rectangle`) e os obstáculos do mapa.
4. **Sistema de Pontuação e Moedas**:
   * Coleta de moedas ao longo do percurso e cálculo de distância percorrida baseada no contador de quadros (*frames*).
5. **Persistência de Recordes (*Leaderboard*)**:
   * Leitura e gravação do ranking dos melhores jogadores em arquivo binário (`leaderboard.bin`).

#### 📁 Estrutura de Arquivos do Jogo
* [`jogo.c`](./Vitor_Feijo_E_Gabriel_Nunes/jogo.c): Loop principal de jogo (`Gameplayloop`), controle de estados (Menu, Jogo, Leaderboard) e renderização.
* [`funcoes.c`](./Vitor_Feijo_E_Gabriel_Nunes/funcoes.c) / [`funcoes.h`](./Vitor_Feijo_E_Gabriel_Nunes/funcoes.h): Funções de carregamento de mapas, colisões, física, e manipulação de pontuações.
* [`definicoes.h`](./Vitor_Feijo_E_Gabriel_Nunes/definicoes.h): Constantes do jogo, dimensões da janela, velocidades e estruturas `Jogador` e `Bloco`.
* [`mapa1.txt`](./Vitor_Feijo_E_Gabriel_Nunes/mapa1.txt), [`mapa2.txt`](./Vitor_Feijo_E_Gabriel_Nunes/mapa2.txt), [`mapa3.txt`](./Vitor_Feijo_E_Gabriel_Nunes/mapa3.txt): Definições dos blocos e obstáculos de cada fase.
* [`foguetao.png`](./Vitor_Feijo_E_Gabriel_Nunes/foguetao.png): Sprite do personagem.
* [`Relatório.pdf`](./Vitor_Feijo_E_Gabriel_Nunes/Relatório.pdf): Documento técnico detalhando o design, decisões de arquitetura e instruções do jogo.

---

[⬅ Voltar para o 1º Semestre](../README.md)
