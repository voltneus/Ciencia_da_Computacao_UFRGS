import numpy as np
import scipy.integrate as integrate

# ====================================================================
# PASSO 1: DEFINIÇÃO DA FUNÇÃO E PARÂMETROS
# ====================================================================
K = 1000
N = 10
r = 0.1
h = 0.5

a = 0
b = N

# Note que a variável de integração na fórmula é 't'
def f(t):
    return K * np.exp(r * (N - t))

# ====================================================================
# PASSO 2: CÁLCULO DO NÚMERO DE NÓS (n)
# ====================================================================
# Número de intervalos: (b - a) / h
# Número de nós: intervalos + 1
n_nos = int((b - a) / h) + 1

# ====================================================================
# PASSO 3: INTEGRAÇÃO POR SIMPSON COMPOSTA
# ====================================================================
x = np.linspace(a, b, n_nos)
y = f(x)

resultado_bruto = integrate.simpson(y, x)

# O enunciado pede arredondamento por adição com 2 casas
resultado_final = round(resultado_bruto, 2)

print(f"Número de nós calculado para h={h}: {n_nos}")
print(f"Valor bruto calculado: {resultado_bruto}")
print(f"Resposta final para o Moodle: {resultado_final}")