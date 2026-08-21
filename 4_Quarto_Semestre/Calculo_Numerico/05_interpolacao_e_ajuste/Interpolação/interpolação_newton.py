# -*- coding: utf-8 -*-
"""
Created on Fri Nov  8 08:40:13 2024

@author: Rudnei
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy.linalg import solve

# ====================================================================
# PASSO 1: CONFIGURAÇÃO DOS DADOS DA QUESTÃO
# ====================================================================
# [Caso padrão]: X nas entradas, Y nas saídas.
# Se for uma questão de Interpolação Inversa (como a da bomba), basta 
# você colocar os dados de Z em 'dados_entradas' e os de X em 'dados_saidas'.

#dados_entradas = np.array([1869.06, 1400.46, 916.87, 426.64, -66.45])
#dados_saidas   = np.array([1200.45, 1286.73, 1340.02, 1372.71, 1392.69])
dados_entradas = np.array([5.0, 10.0, 15.0, 20.0])
dados_saidas   = np.array([1.269, 1.247, 1.225, 1.204])

# Ponto que você deseja estimar/descobrir
ponto_desejado = 12.5

# Valor exato fornecido pelo enunciado (Mude para 'None' se não houver)
valor_exato = None

# Quantidade de casas decimais para o arredondamento por corte
casas_decimais = 8


# ====================================================================
# PASSO 2: FUNÇÕES MATEMÁTICAS DE NEWTON (Não precisa mexer)
# ====================================================================
def interp_Newton(x, y):
    m = np.size(x)
    A = np.zeros((m, m))
    A[:, 0] = np.ones(m)
    for j in range(1, m):
        for i in range(j, m):
            A[i, j] = A[i, j-1] * (x[i] - x[j-1])
    c = solve(A, y, lower=True)
    return c

def horner(x, c, nos):
    n = np.size(c) - 1
    p = c[n]
    for i in range(n-1, -1, -1):
        p = (x - nos[i]) * p + c[i]
    return p

def avalia_interp_Newton(z, c, nos):
    m = np.size(z)
    y = np.zeros(m)
    for k in range(m):
        y[k] = horner(z[k], c, nos)
    return y


# ====================================================================
# PASSO 3: EXECUÇÃO DOS CÁLCULOS E EXIBIÇÃO
# ====================================================================
print("--- RESULTADOS DA INTERPOLAÇÃO ---")

# 1. Calcula os coeficientes e a aproximação
c = interp_Newton(dados_entradas, dados_saidas)
print("Coeficientes do polinômio de Newton:", c)

z_arr = np.array([ponto_desejado])
resultado_aproximado = avalia_interp_Newton(z_arr, c, dados_entradas)[0]
print(f"Valor aproximado no ponto {ponto_desejado}: {resultado_aproximado:.10f}")

# 2. Se houver valor exato, calcula o erro relativo truncado por corte
if valor_exato is not None:
    erro_relativo = abs(valor_exato - resultado_aproximado) / abs(valor_exato)
    
    # Faz o corte puro (truncamento) jogando fora o resto das casas
    fator = 10**casas_decimais
    erro_cortado = int(erro_relativo * fator) / fator
    
    print(f"\n--- CÁLCULO DE ERRO ---")
    print(f"Erro relativo bruto: {erro_relativo}")
    print(f"Erro relativo final (corte {casas_decimais} casas): {erro_cortado:.{casas_decimais}f}")

# Gráfico básico para conferência visual
plt.plot(dados_entradas, dados_saidas, 'ro', label='Dados')
plt.plot(ponto_desejado, resultado_aproximado, 'cx', markersize=10, label='Ponto Estimado')
plt.grid()
plt.legend()
plt.show()