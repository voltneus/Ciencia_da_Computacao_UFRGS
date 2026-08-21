# 💻 Desenvolvimento de Software (INF01120)

Este diretório armazena as atividades práticas, suítes de testes unitários e o trabalho final desenvolvidos para a disciplina de **Desenvolvimento de Software** (Técnicas de Construção de Programas) do INF/UFRGS, enfatizando boas práticas de engenharia de software, desenvolvimento orientado a objetos, testes automatizados e containerização.

---

## 🛠️ Tecnologias & Ferramentas

* **Linguagem**: Java 17+
* **Framework & Build**: Spring Boot, Apache Maven (`pom.xml`)
* **Testes & Qualidade**: JUnit 5, JaCoCo (Cobertura de Código)
* **DevOps**: Docker, Docker Compose
* **Modelagem**: Diagramas de Classes e Arquitetura UML

---

## 📂 Atividades e Projetos

### 1. [`atividade01_git_setup/`](./atividade01_git_setup) — Fluxo de Trabalho e Versionamento
* Configuração de ambiente de desenvolvimento, boas práticas com controle de versão Git, branching strategy (*Git Flow*), mensagens semânticas de commit e automação de setup.

---

### 2. [`atividade03_testes_junit/`](./atividade03_testes_junit) — Testes Unitários e Cobertura (JaCoCo)
* **Foco**: Desenvolvimento guiado por especificações e testes unitários rigorosos.
* **Conteúdo**:
  * Implementação de regras de negócio para mercado de capitais / bolsa de valores (`regras_bolsa.csv`).
  * Criação de casos de teste exaustivos com **JUnit 5** cobrindo cenários nominais e de exceção.
  * Medição de cobertura de linhas e branches com o plugin **JaCoCo**.
  * Execução containerizada via **Docker** e **Docker Compose**.

---

### 3. [`trabalho_final_sistema_transacoes/`](./trabalho_final_sistema_transacoes) — Sistema de Processamento Financeiro

Projeto final integrador desenvolvido em equipe, modelando e implementando um motor de ingestão, validação e liquidação de transações financeiras em larga escala.

#### 🌟 Destaques da Arquitetura
1. **Modelagem Orientada a Objetos**:
   * Diagrama formal de classes UML ([`Classe_UML.pdf`](./trabalho_final_sistema_transacoes/Classe_UML.pdf)) definindo entidades, serviços, repositórios e DTOs.
2. **Processamento em Lote**:
   * Leitura e validação de transações brutas em formato tabular/CSV (`transacoes_brutas_exemplo.csv`).
3. **Padrões de Projeto (Design Patterns)**:
   * Aplicação de princípios SOLID, Service Layer, Factory e Strategy para regras de validação financeira.
4. **Infraestrutura Pronta para Produção**:
   * Arquivos [`Dockerfile`](./trabalho_final_sistema_transacoes/Dockerfile) e [`docker-compose.yml`](./trabalho_final_sistema_transacoes/docker-compose.yml) para build multiestágio e execução isolada da aplicação.

---

[⬅ Voltar para o 4º Semestre](../README.md)
