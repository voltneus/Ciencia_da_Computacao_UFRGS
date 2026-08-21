[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/Hh7Ezb62)
# projeto-base

# Sentinel Financial Analysis System

## Sobre o Projeto (About the Project)
O Sentinel Financial Analysis System é uma aplicação web desenvolvida em Java (Servlets e JSP) para processamento, auditoria e análise de transações financeiras. 
O sistema permite que o usuário faça o upload de um arquivo CSV de transações por meio de uma interface web interativa. O back-end lê e processa as transações aplicando diversas regras de validação e detectores de anomalias (verifiers). Por fim, os resultados auditados são exibidos diretamente na interface de usuário (Dashboard) e podem ser baixados em formato de relatório.

## Como rodar o projeto (How to run)

A forma mais simples e recomendada de executar o projeto é utilizando o **Docker Compose**, pois ele já configura todo o ambiente (Java e servidor web) automaticamente.

1. Certifique-se de ter o **Docker** e o **Docker Compose** instalados na sua máquina.
2. Clone o repositório para sua máquina local.
3. Abra um terminal na raiz do projeto (onde se encontra o arquivo `docker-compose.yml`).
4. Execute o comando:
   ```bash
   docker compose up --build
   ```
   *(Ou `docker-compose up --build` dependendo da versão do seu Docker)*
5. O Docker irá compilar o projeto e iniciar o servidor.
6. Acesse a aplicação no seu navegador: `http://localhost:8080/`

*Nota:* Para rodar os comandos do docker no linux é necessário dar para ele permissões de root, portanto o comando será `sudo docker compose up --build`.

*Nota:* Caso prefira rodar manualmente sem o Docker, o projeto utiliza Maven. Você pode usar `mvn clean package` e realizar o deploy do arquivo `.war` gerado (na pasta `target/`) em um container como o Apache Tomcat.


## Autores e Divisão do Trabalho

- **Thiago Fontoura**: Desenvolveu o Controller da aplicação (Servlets como o `ServletMedia`) e o serviço `DataManager` e trabalhou na configuração de tabelas de saída.
- **Cristopher de Wallau**: Responsável pelo modelo de dados principal (`Transaction.java`) e implementou a suite de testes unitários dedicada a ele (`TransactionTest.java`).
- **Lucas Bagolin**: Desenvolveu as classes responsáveis por manipular arquivos (`CSVManager.java`).
- **Gabriel Knopp**: Focou principalmente na implementação das regras de negócio e validação de transações (classes do pacote `verifiers`, como `ValueVerifier`, `TimeVerifier`, `CategoryVerifier`, `OriginVerifier`), bem como no modelo `Audit` e nos testes individuais para cada uma das classes mencionadas.
- **Vítor Feijó**: Desenvolveu a camada de Front-End e interface gráfica (`index.jsp`), criando o design visual do painel, animações, drag-and-drop e tabelas de resultados dinâmicas.