# 📐 Linguagens Formais e Autômatos — LFA (INF05005)

Este diretório contém os trabalhos práticos de modelagem formal desenvolvidos na ferramenta **JFLAP** para a disciplina de **Linguagens Formais e Autômatos**, aplicando a Hierarquia de Chomsky na especificação de sistemas de controle.

---

## 📂 Etapas do Projeto: Modelagem de Máquina de Vendas

O projeto consiste na formalização do comportamento de uma **Máquina de Vendas Automática** (*Vending Machine*), capaz de receber moedas, computar créditos acumulados, validar seleções de produtos, entregar mercadorias e calcular troco.

### 1. [`Trabalho_Etapa_1/`](./Trabalho_Etapa_1) — Linguagens Regulares
* **Arquivos**:
  * `Automato_finito_maquina_de_vendas_...jff`: Autômato Finito Determinístico (DFA) projetado no JFLAP.
  * `Gramatica_glud_maquina_de_vendas_...jff`: Gramática Linear Unitária à Direita (GLUD) equivalente.
  * `Vending-Machine _...pdf`: Relatório teórico descrevendo o alfabeto (\(\Sigma\)), estados, função de transição (\(\delta\)), estado inicial e estados de aceitação.
* **Foco Teórico**: Expressividade dos modelos de estados finitos e limites da memória finita para transações comerciais.

---

### 2. [`Trabalho_Etapa_2/`](./Trabalho_Etapa_2) — Linguagens Livres de Contexto
* **Arquivos**:
  * `Gramatica_GLC_maquina_de_vendas _...jff`: Gramática Livre de Contexto (GLC) modelando operações com empilhamento de moedas/crédito.
  * `Vending-Machine-Parte2 _...pdf` / `Vending_Machine.pdf`: Relatórios técnicos aprofundados contendo a formalização do Autômato com Pilha (PDA), árvores de derivação e análise sintática.
* **Foco Teórico**: Capacidade de contagem não-limitada e gerenciamento de pilha para controle dinâmico de inserção e devolução de valores.

---

[⬅ Voltar para o 3º Semestre](../README.md)
