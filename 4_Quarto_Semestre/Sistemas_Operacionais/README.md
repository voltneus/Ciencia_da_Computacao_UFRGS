# 🐧 Sistemas Operacionais I (INF01151)

Este diretório reúne os laboratórios práticos desenvolvidos em linguagem **C** no ambiente Linux/POSIX para a disciplina de **Sistemas Operacionais I** do INF/UFRGS, abordando concorrência, gerência de processos e sistemas de arquivos.

---

## 📂 Laboratórios Práticos

### 1. [`lab1_ipc_mandelbrot/`](./lab1_ipc_mandelbrot) — Processos & Comunicação Inter-Processos (IPC)
* **Arquivos**: `ipc.c`, `ipc.h`, `mandelbrot.c`, `mandelbrot.h`, `colors.c`, `colors.h`, `Makefile`
* **Conceitos**:
  * Criação e ciclo de vida de processos no Linux (`fork`, `exec`, `waitpid`, `exit`).
  * Comunicação inter-processos através de **Pipes Anônimos** com bufferização de dados.
  * Captura e tratamento de sinais do sistema operacional (`signal`, `sigaction`, `SIGINT`, `SIGCHLD`).
  * Paralelização do cálculo do conjunto fractal de Mandelbrot distribuindo faixas da imagem entre múltiplos processos filhos.

---

### 2. [`lab2_threads_concorrencia/`](./lab2_threads_concorrencia) — Concorrência Multithread (Pthreads)
* **Arquivos**: `orion.c`, `Makefile`, `relatorio.md`, `relatorio.pdf`, `T2_orion_threads.pdf`
* **Conceitos**:
  * Programação multithread concorrente com **POSIX Threads** (`pthread_create`, `pthread_join`, `pthread_exit`).
  * Mecanismos de sincronização e controle de seção crítica:
    * Mutexes (`pthread_mutex_t`).
    * Variáveis de Condição (`pthread_cond_t`).
    * Semáforos POSIX (`sem_t`).
  * **Problema da Ponte Orion**: Modelagem e resolução da travessia de veículos em uma ponte estreita de pista única em ambos os sentidos, prevenindo colisão frontal, condição de corrida (*race condition*), inanição (*starvation*) e impasses (*deadlocks*).

---

### 3. [`lab4_sofs_filesystem/`](./lab4_sofs_filesystem) — Sistema de Arquivos (SOFS)
* **Arquivos**: `sofs/src/sofs.c`, `sofs-block.c`, `include/sofs.h`, `lib/`, `Makefile`, `lab4_specs.md`, `T4_sofs.pdf`
* **Conceitos**:
  * Projeto e implementação de um **Sistema de Arquivos em Espaço de Usuário (SOFS)** com blocos de disco simulados (`t2fs_disk.dat`).
  * Estruturação de Superbloco, Tabela de Inodes (nós-índice), Mapa de Bits de Blocos Livres (*Bitmap*) e Entradas de Diretório.
  * Operações de criação de arquivos (`sofs_create`), abertura (`sofs_open`), leitura (`sofs_read`), escrita (`sofs_write`), exclusão (`sofs_delete`) e navegação de diretórios (`sofs_opendir`, `sofs_readdir`).

---

[⬅ Voltar para o 4º Semestre](../README.md)
