# Enunciado do Trabalho Prático

**Disciplina:** Fundamentos de Banco de Dados  
**Professora:** Karin Becker  

O trabalho prático da disciplina versa sobre o projeto e uso de uma base de dados para um Sistema de Informação (SI), a ser implantado em um sistema de gerência de banco de dados (SGBD) relacional. O trabalho abrange o projeto lógico da base de dados, a elaboração de consultas em SQL e a implementação de um programa que acessa a base através dos recursos do SGBD.

O trabalho deve ser desenvolvido em duplas. Trabalhos individuais serão admitidos apenas em circunstâncias extraordinárias, com o acordo prévio da professora.

## Estrutura do Trabalho

| Etapa | Descrição Resumida | Data Entrega | Peso |
| :--- | :--- | :--- | :--- |
| **Preparação\*** | Informar a dupla de trabalho | 07/06\* | - |
| **Parte 1** | Projeto Lógico da Base de Dados + Dicionário de Dados + Instâncias | 21/06\*\* | 35% |
| **Parte 2** | Consultas SQL + Visão | 21/06\*\* | 40% |
| **Parte 3** | Programa de acesso à base de dados (vídeo) | 01/07\*\* | 25% |

*\* Alunos que informarem a dupla no prazo ganham 1 ponto adicional na nota do trabalho.*  
*\*\* Há uma penalização de 5% por dia de atraso.*

---

## Declaração do Uso de IA

O uso de ferramentas de IA generativa (ex: ChatGPT, Claude, Copilot, Gemini) é permitido como apoio ao desenvolvimento do trabalho, desde que não substitua o raciocínio próprio. Os alunos são integralmente responsáveis pelo conteúdo entregue e devem ser capazes de explicar e defender qualquer parte do trabalho — incluindo código, consultas e decisões de modelagem. O aluno deve declarar o uso (ou não) de ferramentas de IA para apoio ao trabalho. A ausência de declaração quando houver uso caracteriza desonestidade acadêmica.

---

## Parte 1 – Projeto Lógico da Base de Dados

Os alunos escolhem um universo de discurso (UdD) a modelar, criando o projeto lógico de acordo com o modelo relacional. O escopo escolhido deve ser uma simplificação coerente da realidade modelada, explicitada pelo grupo. Os alunos podem escolher entre os seguintes temas abaixo, com sugestões de sistemas reais para inspiração:

* Comércio eletrônico (ex: Mercado Livre, Amazon, Shopee, Enjoei)
* Plataforma de streaming (ex: Netflix, Prime, Spotify, YouTube)
* Sistema de resenhas de livros, filmes ou músicas (Goodreads, IMDb)
* Redes sociais (ex: LinkedIn, Instagram)

### Item 1.a) Descrição do Universo de Discurso

Para permitir a correção do trabalho, descreva em português, de forma clara, o universo de discurso escolhido: o que o SI representa, quais simplificações foram feitas e quais requisitos informacionais deve atender. Os requisitos informacionais justificam a necessidade de cada tabela e relacionamento modelados. Use frases do tipo "deve ser possível consultar/registrar/manter...".

### Item 1.b) Esquema Relacional

Para o UdD descrito, proponha o esquema relacional correspondente, observando:
* Deve haver pelo menos 8 tabelas relevantes.
* Chaves primárias em todas as tabelas.
* Chaves alternativas e chaves estrangeiras onde pertinentes.
* Podem haver restrições de integridade em SQL (ex.: `CHECK`), se pertinentes.
* As tabelas devem estar normalizadas (FNBC), com uma breve justificativa com base nas dependências funcionais existentes.
* Essas tabelas devem estar descritas através de comandos SQL padrão (`CREATE TABLE`).

> **Observação:** Todos esses universos de discurso são muito ricos, e se prestam a modelagens muito ricas. Não inclua tabelas/relacionamentos cuja única razão de ser é atingir os requisitos quantitativos, descaracterizando o propósito do sistema.

### Item 1.c) Dicionário de Dados

Elabore um Dicionário de Dados (DD) textual correspondente ao esquema relacional, especificando para cada tabela:
* Propósito da tabela (breve descrição detalhando o que representa).
* Atributos: nome, tipo de dados, restrições (`NOT NULL`, `UNIQUE`, `DEFAULT`, etc.) e descrição sucinta do significado.
* Chave primária e chaves estrangeiras (indicando a tabela referenciada).
* Demais restrições de integridade relevantes (`CHECK`, etc.).

### Item 1.d) Instâncias

Popule a base de dados com instâncias que:
* Cubram diversidade de casos, permitindo testar os cenários relevantes das consultas.
* Retornem resultados para todas as 10 consultas definidas no Item 2.
* Estejam em conformidade com todas as restrições de integridade definidas.
* **Qualidade e diversidade é mais importante que volume.**

---

## Parte 2 – Consultas e Visão

### Item 2.a) Visão

Defina uma visão (`VIEW`) útil ao seu universo de discurso, envolvendo no mínimo 2 tabelas. Sua utilidade deve ser demonstrada pelo uso em no mínimo duas consultas do Item 2.b.

### Item 2.b) Consultas SQL

Defina um conjunto de 10 consultas úteis e variadas sobre o Sistema de Informação. As consultas devem ser significativamente distintas entre si. Serão consideradas utilidade, diversidade e correção na avaliação. O conjunto das consultas deve envolver todas as tabelas de seu projeto lógico.

**Requisitos quantitativos obrigatórios:**
* **Mínimo de tabelas por consulta:** cada consulta deve envolver pelo menos 3 tabelas (o uso de uma visão conta como 1 tabela).
* **GROUP BY (mínimo 3 consultas):** a resposta deve combinar atributos e totalizações sobre grupos. Dentre essas, pelo menos uma deve incluir também a cláusula `HAVING`.
* **Subconsulta (mínimo 2 consultas, diferentes das anteriores):** deve ser utilizada uma subconsulta que não possua formulação equivalente usando apenas `JOIN`s.
* **Consulta do tipo TODOS ou NENHUM que referencial (mínimo 1, diferente das anteriores):** formulada sobre o resultado vazio de uma interseção ou diferença. Não existe formulação equivalente usando simplesmente `JOIN`s, e não correspondem ao mero aninhamento de subconsultas.
* **Visão (mínimo 2 consultas):** ao menos duas consultas devem utilizar a visão definida no Item 2.a.

> **Obs:** A base deve estar populada de forma a retornar resultados em todos os cenários testados.

---

## Entregáveis (Parte 1 e 2)

Nomeie os arquivos conforme solicitado:
* `universo.pdf`: documento PDF contendo a descrição do universo de discurso que viabilize compreender sua modelagem, com os requisitos informacionais.
* `projeto_dicionario.pdf`: documento PDF contendo: (i) o esquema relacional descrito como comandos SQL `CREATE TABLE` (e demais DDL pertinentes); (ii) o Dicionário de Dados. Deve ser possível compreender no contexto do UdD o significado das tabelas, seus atributos, chaves e restrições de integridade.
* `tabelas.sql`: arquivo `.sql` com os comandos de criação das tabelas. Deve executar corretamente em PostgreSQL ou MySQL (SQL padrão).
* `instancias.sql`: arquivo `.sql` com instanciação para todas as tabelas. Deve executar corretamente em PostgreSQL ou MySQL (SQL padrão).
* `consultas.sql`: arquivo SQL contendo a definição da visão e as 10 consultas. Cada consulta/visão deve ter:
  * Um enunciado claro e preciso em português da informação que representa.
  * O comando SQL correspondente.
  * *Consultas sem enunciado, ou cujo enunciado esteja confuso/ambíguo em relação ao comando fornecido, serão consideradas incorretas.*
* `declaracaoIA.pdf`: Caso IA tenha sido utilizada, os alunos devem declarar: (i) quais ferramentas foram usadas; (ii) para quais finalidades (ex: geração de código, revisão de SQL, geração de instâncias, revisão de texto, etc.). Caso não tenha sido utilizada, devem declarar igualmente.

---

## Parte 3 – Programa de Acesso à Base de Dados

### Item 3.a) Programa de Acesso à Base de Dados

Construa um programa que permita realizar manipulações na base de dados, demonstrando domínio sobre como integrar uma aplicação a um SGBD usando comandos SQL. Você pode escolher qualquer linguagem de programação e qualquer SGBD relacional, desde que os comandos SQL sejam padrão. O programa deve:

* **Conexão:** conectar-se à base de dados.
* **Consultas sem parâmetro:** executar as consultas SQL definidas na Parte II, mostrando os resultados.
* **Consultas com parâmetro (mínimo 2):** ao menos 2 das consultas devem receber parâmetros em tempo de execução. As consultas com parâmetros devem utilizar obrigatoriamente os recursos de parametrização da biblioteca usada (e.g., prepared statements, bind variables). Não serão consideradas como corretas soluções onde uma string é manipulada para que a consulta inclua os parâmetros.

> **Observações:** A interface com o usuário pode ser bem simples — ela visa apenas demonstrar as funcionalidades acima. Interfaces sofisticadas não serão valorizadas. É vedado o uso de frameworks que tornem obscuros os detalhes de conexão com a base de dados. Em caso de dúvida, consulte a professora.

### Item 3.b) Vídeo de Demonstração

Prepare um vídeo (preferencialmente YouTube não-listado) de 6 a 10 minutos demonstrando e explicando a implementação. Comece esclarecendo a linguagem e as bibliotecas usadas. O vídeo deve cobrir:

a. **Consultas:** demonstre uma consulta com parâmetro e uma sem, mostrando que suas consultas executam corretamente.
b. **Aspectos técnicos do código:** seu vídeo deve explicar os pontos importantes do seu código, em particular:
   * Como foi estabelecida a conexão com a base de dados.
   * Como preparou e enviou consultas sem parâmetros ao banco de dados.
   * Como preparou e enviou consultas com parâmetros (enfatizando as funções específicas da biblioteca usadas para esse fim).
   * Como processa o retorno das consultas para mostrar os resultados.

* **Exemplo positivo:** "Para conectar à base de dados, utilizamos dois comandos da API: X, que faz [descrição], seguido de Y, que faz [descrição]. Para executar consultas sem parâmetros, usamos os comandos A, B e C. Para consultas com parâmetros, usamos os comandos M, N e O, que servem para [descrição], pois [motivo]. Para processar os resultados retornados pelo comando C, utilizamos H [descrição] e K [descrição] da seguinte forma [descrição]."
* **Exemplo negativo:** "Usei X, chamei Y, depois executei A. Tá funcionando."

> **Atenção:** O vídeo deve ser narrado pela dupla de forma que ambos demonstrem domínio sobre o código. Caso seja passada a impressão de que um dos alunos não está familiarizado com o código, os alunos serão chamados para uma demonstração presencial.
