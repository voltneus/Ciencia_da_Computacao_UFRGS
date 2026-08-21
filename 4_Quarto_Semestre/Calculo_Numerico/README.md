# 🔢 Cálculo Numérico (MAT01169)

Este diretório contém as implementações em **Python 3** dos principais métodos numéricos estudados na disciplina de **Cálculo Numérico**, cobrindo desde aritmética computacional até resolução de sistemas complexos e otimização.

---

## 📂 Tópicos e Módulos Implementados

### 1. [`01_aritmetica_ponto_flutuante/`](./01_aritmetica_ponto_flutuante)
* **Arquivos**: `calc-bitspontofixo.py`, `ctes-pontofixo.py`, `ctes-pontoflutuante.py`
* **Conceitos**: Padrão IEEE 754 (sinal, expoente, mantissa), representação em ponto fixo vs. ponto flutuante, épsilon de máquina, erros de truncamento e arredondamento (*underflow* e *overflow*).

---

### 2. [`02_raizes_de_funcoes/`](./02_raizes_de_funcoes)
* **Arquivos**: `raizes_funcoes.py`, `mapa_newton-raphson.py`
* **Conceitos**: Métodos de busca de zeros/raízes de funções contínuas \(f(x) = 0\):
  * Método da Bisseção.
  * Método da Falsa Posição (*Regula Falsi*).
  * Método de Newton-Raphson com cálculo analítico/numérico de derivada.
  * Método das Secantes.
  * Mapas visuais e análise de taxa de convergência quadrática vs linear.

---

### 3. [`03_sistemas_lineares/`](./03_sistemas_lineares)
* **Arquivos**: `lu_com_exata.py`, `lu_sem_exata.py`, `lu_refinamento_iterativo.py`, `inversa_por_lu.py`, `metodos_selas_jacobi.py`, `metodos_selas_todos.py`
* **Conceitos**:
  * **Métodos Diretos**: Eliminação Gaussiana, Fatoração \(LU\) (\(A = L \cdot U\)) com e sem pivoteamento parcial, cálculo de matriz inversa e refinamento iterativo de resíduos.
  * **Métodos Iterativos**: Método de Jacobi e Método de Gauss-Seidel, critérios de convergência (Critério das Linhas e de Sassenfeld).

---

### 4. [`04_integracao_numerica/`](./04_integracao_numerica)
* **Arquivos**: `regras_trapezio_simpson.py`, `master_integracao.py`, `integracao_temperatura_média.py`, `integracao_velocidade.py`, `homer-simpson.py`
* **Conceitos**: Integração numérica por Quadratura de Newton-Cotes:
  * Regra dos Trapézios (simples e generalizada/composta).
  * Primeira Regra de Simpson (1/3) e Segunda Regra de Simpson (3/8).
  * Estimativa assintótica de limites de erro e aplicações práticas em perfis de velocidade e temperatura.

---

### 5. [`05_interpolacao_e_ajuste/`](./05_interpolacao_e_ajuste)
* **Conceitos**:
  * **Interpolação Polinomial**: Forma de Lagrange e Forma de Newton (Diferenças Divididas).
  * **Ajuste de Curvas**: Método dos Mínimos Quadrados (MMQ) para modelos lineares, polinomiais e linearizáveis (exponenciais/potências), cálculo de coeficiente de determinação (\(R^2\)).

---

### 6. [`06_otimizacao_nao_linear/`](./06_otimizacao_nao_linear)
* **Conceitos**: Métodos de busca de extremos (mínimos/máximos) para funções univariadas e multivariadas (Método da Seção Áurea, Método do Gradiente Descendente).

---

### 7. [`07_sistemas_nao_lineares/`](./07_sistemas_nao_lineares)
* **Conceitos**: Resolução de sistemas de equações não-lineares via Método de Newton multivariado com montagem da matriz Jacobiana (\(J(x)\)) e resolução de subproblemas lineares a cada iteração.

---

[⬅ Voltar para o 4º Semestre](../README.md)
