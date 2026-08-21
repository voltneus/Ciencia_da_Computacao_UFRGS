# -*- coding: utf-8 -*-
"""
Modelo Genérico para Métodos Iterativos - Álgebra Linear
Pronto para uso em provas.
"""

import numpy as np
from scipy.linalg import norm, solve_triangular

def metodo_richardson(A, b, x, tol=1e-8, imax=1000):
    """
    Retorna: [solução_x, norma_resíduo, iterações_feitas, status(0=Ok, -1=Falha)]
    """
    
    # PRÉ-CÁLCULOS (Opcional)
    n = np.size(A, 0)  # assume que a matriz A é quadrada
    I = np.identity(n)
    m_temp = I - A
    
    # LOOP (Não mexer)
    for i in range(imax):
        
        # Calcula o resíduo e a norma
        r = b - A @ x
        rnorm = norm(r)
        
        # Testa a convergência
        if rnorm < tol:
            return [x, rnorm, i, 0] # Sucesso: Convergiu
        
        # EQUAÇÃO GOVERNANTE
        x = m_temp @ x + b
        
    # Retorna falha se atingir o limite de iterações
    return [x, rnorm, i, -1]


# Matriz A (Estritamente diagonal dominante para garantir convergência)
A = np.array([[ 1.0, -0.25,  0.0,   0.0],
              [ 0.0,  1.0,   0.0,   0.0],
              [ 0.0,  0.0,   1.0,  -0.25],
              [ 0.0,  0.0,  -0.25,  1.0]], dtype=float)

# Define o vetor independente b
n = np.size(A, 0)
exata = np.zeros((n, 1))
exata[0] = 1
exata[n-1] = 1
b = A @ exata

# Define o chute inicial (Vetor de zeros)
x0 = np.zeros((n, 1))

print("\nMétodo ------Template------")
resultado = metodo_richardson(A, b, x0, tol=1e-8, imax=400)

print("\nx =\n", resultado[0])
print("\n||r|| =", resultado[1])
print("\nIterações =", resultado[2])

if resultado[3] == 0:
    print("\nConvergiu\n")
else:
    print("\nNão convergiu\n")