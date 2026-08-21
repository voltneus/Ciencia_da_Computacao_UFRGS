# 🗄️ Bancos de Dados (INF01145)

Este diretório contém o projeto prático completo de modelagem, implementação e consulta de um **Banco de Dados Relacional** em **PostgreSQL** para a disciplina de **Fundamentos de Banco de Dados** do INF/UFRGS.

---

## 🎯 Escopo do Projeto: Ecossistema de Jogos & E-Sports (Steam)

O projeto modela um sistema robusto de gerenciamento para plataformas digitais de jogos (inspirado na Steam/Twitch/e-Sports), contemplando:
- **Jogos, Desenvolvedoras e Distribuidoras**: Metadados de jogos, categorias, preços, lançamentos e requisitos de sistema.
- **Usuários, Bibliotecas e Conquistas**: Perfis de jogadores, histórico de compras, tempo de jogo, avaliações e progresso de conquistas (*achievements*).
- **Competições & E-Sports**: Equipes, torneios, partidas e premiações.

---

## 📂 Estrutura de Arquivos

### 1. [`sql/`](./sql) — Scripts SQL (PostgreSQL)
* [`tabelas.sql`](./sql/tabelas.sql): **Data Definition Language (DDL)** com criação de tabelas, tipos de dados adequados, restrições de chave primária (`PRIMARY KEY`), chave estrangeira (`FOREIGN KEY`), checagens (`CHECK`) e índices para otimização de busca.
* [`instancias.sql`](./sql/instancias.sql): **Data Manipulation Language (DML)** com inserção de instâncias e massa de testes consistente para todas as tabelas.
* [`consultas.sql`](./sql/consultas.sql): Bateria de consultas analíticas e relatórios utilizando:
  * Junções múltiplas (`INNER JOIN`, `LEFT JOIN`).
  * Funções de agregação (`COUNT`, `SUM`, `AVG`, `MAX`, `MIN`) com cláusulas `GROUP BY` e `HAVING`.
  * Subconsultas correlacionadas e não-correlacionadas (`IN`, `EXISTS`, `NOT EXISTS`).
  * Operações de conjuntos (`UNION`, `INTERSECT`, `EXCEPT`).

### 2. [`scripts/`](./scripts) — Automação e Povoamento
* [`json-parser.py`](./scripts/json-parser.py): Script em Python para carregar dados brutos de jogos em formato JSON (`jogos_filtrados.json`), realizar limpeza/filtragem e gerar os comandos SQL de inserção automaticamente.
* [`data/processed/jogos_filtrados.json`](./scripts/data/processed/jogos_filtrados.json): Conjunto de dados estruturados utilizados no povoamento.

### 3. [`docs/`](./docs) — Especificação e Modelagem
* [`projeto_dicionario.md`](./docs/projeto_dicionario.md): Dicionário de dados completo descrevendo cada tabela, atributos, tipos e restrições semânticas.
* [`scenario_description.md`](./docs/scenario_description.md) / [`universo.md`](./docs/universo.md): Descrição detalhada das regras de negócio do universo de discurso.
* [`enunciado_FBD_2026.pdf`](./docs/enunciado_FBD_2026.pdf): Enunciado e diretrizes oficiais da disciplina.

---

[⬅ Voltar para o 4º Semestre](../README.md)
