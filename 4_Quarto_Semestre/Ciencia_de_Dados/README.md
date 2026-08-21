# 📊 Ciência de Dados I (INF01057)

Este diretório contém os laboratórios práticos, notebooks interativos e códigos desenvolvidos para a disciplina de **Ciência de Dados I**, cobrindo o pipeline completo de ciência de dados — desde ingestão e pré-processamento até treinamento e avaliação de modelos de Aprendizado de Máquina (*Machine Learning*).

---

## 🛠️ Stack Tecnológica

* **Linguagem**: Python 3
* **Manipulação & Análise**: `Pandas`, `NumPy`
* **Visualização**: `Matplotlib`, `Seaborn`
* **Machine Learning**: `Scikit-Learn`, `CatBoost`
* **Ambiente**: Jupyter Notebook / VS Code

---

## 📂 Laboratórios Práticos

### 1. [`lab01/`](./lab01) — Ingestão e Manipulação Estruturada
* Leitura de conjuntos de dados em múltiplos formatos (CSV, JSON), manipulação de `DataFrames` e `Series`, indexação avançada, agrupamentos (`groupby`) e visualizações preliminares.

### 2. [`lab02/`](./lab02) — Limpeza e Pré-Processamento de Dados
* Identificação e tratamento de valores ausentes (*missing values* por imputação média/mediana), remoção de duplicatas, detecção de *outliers* (escore Z e IQR), normalização/padronização (*MinMax* e *StandardScaler*) e codificação categórica (*One-Hot Encoding*).

### 3. [`lab03/`](./lab03) — Análise Exploratória de Dados (EDA)
* Estatística descritiva multivariada, análise de distribuições, gráficos de dispersão, mapas de calor (*heatmaps*) de correlação de Pearson/Spearman e formulação de hipóteses estatísticas.

### 4. [`lab04/`](./lab04) — Modelagem Preditiva: Regressão
* Implementação e ajuste de modelos de **Regressão Linear Simples e Múltipla**, técnicas de regularização (Ridge e Lasso), e avaliação de métricas de erro (\(MSE\), \(RMSE\), \(MAE\), \(R^2\)).

### 5. [`lab05/`](./lab05) — Modelagem Preditiva: Classificação
* Treinamento e comparação de classificadores supervisionados:
  * K-Nearest Neighbors (KNN).
  * Árvores de Decisão (*Decision Trees*) e Florestas Aleatórias (*Random Forests*).
  * Análise de Matriz de Confusão, Acurácia, Precisão, Revocação (*Recall*), F1-Score e Curva ROC-AUC.

### 6. [`lab06/`](./lab06) — Modelos Avançados e Gradient Boosting (CatBoost)
* Aplicação de algoritmos de *Gradient Boosting on Decision Trees* utilizando a biblioteca **CatBoost**, tratamento nativo de variáveis categóricas, validação cruzada (*k-fold cross validation*) e ajuste fino de hiperparâmetros.

---

[⬅ Voltar para o 4º Semestre](../README.md)
