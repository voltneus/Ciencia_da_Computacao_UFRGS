# INF01113 – Organização de Computadores B
Prof. Antonio Carlos Schneider Beck Filho

## Especificação do Segundo Trabalho Prático

### Objetivo
Simular a execução de 3 aplicações no simulador gem5 (modo de simulação para processadores x86), usando diferentes configurações de organização.

### Programas exigidos
- Desenvolver 3 programas distintos.
- Exemplos:
  - algoritmos de ordenação ou busca
  - algoritmos de processamento como FFT ou CRC
- Preferir programas com características diferentes:
  - complexidade diferente
  - mais ou menos instruções de controle
  - mais ou menos acessos à memória
  - mesmo programa compilado com flags de otimização diferentes ou compiladores diferentes
- Quanto mais complexa a comparação, maior o valor da avaliação.

### Procedimento
1. Escolher uma configuração fixa para todos os parâmetros.
   - A configuração fixa deve ter, no mínimo, 3 parâmetros diferentes da configuração original fornecida como base.
2. A partir da configuração fixa, escolher três parâmetros a serem modificados.
   - Explicar por que esses parâmetros foram escolhidos.
   - Explicar qual era o efeito esperado de cada modificação.
   - (Figura 1: etapas 1 e 2)
3. Simular as três aplicações usando cada configuração resultante, inclusive a configuração fixa.
   - Coletar, no mínimo:
     - tempo de execução da aplicação
     - IPC da execução
   - Outros dados podem ser coletados para explicar o comportamento dos programas.
4. Gerar gráficos para cada parâmetro modificado:
   - gráfico de IPC
   - gráfico de tempo de execução
   - eixo X: níveis do parâmetro
   - eixo Y: IPC ou tempo de execução
   - três linhas, uma para cada benchmark
   - total: 6 gráficos
   - (Figura 2: exemplo de gráfico)
5. Para cada benchmark e cada gráfico:
   - explicar a variação do IPC
   - relacionar os resultados com as características de cada benchmark
   - discutir o desempenho final (tempo de execução)
   - verificar os comentários no arquivo de configuração do simulador para lista de parâmetros modificáveis
6. Para cada variação de parâmetro:
   - calcular a média do IPC das três aplicações
   - discutir a diferença dessas médias
   - relacionar com as diferentes configurações e o custo-benefício de cada variação
   - ex: dobrando o tamanho do parâmetro, o desempenho aumenta na mesma proporção?

### Entrega
- Apresentação em PowerPoint com no máximo 10 slides (incluindo título).
- A apresentação será feita para a turma ou o professor.
- A ordem de apresentação poderá ser definida por sorteio ou pelo professor.
- Enviar o arquivo `.pptx` até o início do encontro para apresentação, conforme cronograma.

## Como usar o gem5
1. Descompacte o arquivo `.ova` que contém a imagem da máquina virtual.
   - Use um programa compatível, como VirtualBox.
   - Importar o arquivo `.ova` no VirtualBox.
2. Acesse a VM com usuário e senha `orgb`.
3. Abra o terminal do Linux (barra de aplicativos ou `Ctrl + Alt + T`).
4. No terminal, navegue até a pasta do gem5:
   - `$ cd gem5`
5. Para listar arquivos e diretórios, use:
   - `$ ls`
6. Execute um programa de exemplo no gem5 usando o script de simulação `orbg_configs/simulate.py`:
   - `$ ./gem5 orgb_configs/simulate.py run-benchmark -c tests/test-progs/hello/bin/x86/linux/hello`
7. Se a simulação for bem-sucedida, o arquivo `stats.txt` será gerado na pasta `m5out` dentro da pasta `gem5`.
8. Seus benchmarks devem ser compilados estaticamente para rodar no gem5.
   - A pasta modelo para programas já existe dentro da pasta `gem5`.
   - Exemplo de compilação:
     - `$ cd orgb_progs`
     - `$ gcc hello.c -o hello -static`
   - A flag `-o` define o nome do executável e `-static` realiza o link estático.
9. Volte para a pasta base do gem5 e execute o executável compilado:
   - `$ cd ..`
   - `$ ./gem5 orgb_configs/simulate.py run-benchmark -c orgb_progs/hello`
10. Um novo arquivo `stats.txt` será gerado em `m5out`.
11. O mesmo procedimento vale para os benchmarks escolhidos para o trabalho: compile e simule no gem5.
12. Parâmetros do processador e do cache podem ser modificados nos arquivos:
   - `orgb_configs/systems/cpus/MyO3CPU.py` (CPU)
   - `orgb_configs/systems/caches/basic_caches.py` (caches)
 
