# -*- coding: utf-8 -*-
"""
Created on Thu Oct 31 10:04:30 2024

@author: Rudnei
"""

# Calcula a inversa de uma matriz por um loop e também diretamente na função solve_triangular;

import numpy as np
from scipy.linalg import lu
from scipy.linalg import solve_triangular
from scipy.linalg import norm

A = np.array([[2, -1, 0, 0],
              [-1, 2, -1, 0],
              [0, -1, 2, -1],
              [0, 0, -1, 2]])
#A = np.array([[1, -6, 7, -9],
#              [1, -5, 0, 0],
#              [0, 1, -5, 0],
#              [0, 0, 1, -5]])

print("\ncond(A)=", np.linalg.cond(A))

# A função lu devolve a fatoração A = P*L*U
p, l, u = lu(A)

print("\nA-P*L*U=0?", np.allclose(A, p @ l @ u))
print("\nl=\n")
print(l)
print("\nu=\n")
print(u)
print("\np=\n")
print(p)


n = np.size(A, 0)  # assume que a matriz A é quadrada
A_inv = np.zeros((n, n))
I = np.identity(n)

# Calculando acessando individualmente cada coluna da
# matriz identidade
print("\nResolvendo n sistemas individualmente")
for i in range(n):
    # Solução por PA=LU
    y = solve_triangular(l, p.T @ I[:, i], lower=True, unit_diagonal=True)
    A_inv[:, i] = solve_triangular(u, y)

print("\nA_inv=\n")
print(A_inv)

print("\nA_inv @ A=\n")
print(A_inv @ A)

print("\nI-A*A_inv=0?", np.allclose(I, A @ A_inv))

# Calcula a norma da matriz resíduo R = I-A_inv*A
R = I - A_inv @ A
print("\n||R||=", norm(R))

# Calculando resolvendo n sistemas triangulares
# diretamente na função solve_triangular; 
# observe que o termo independente se reduz à 
# transposta da matriz de permutação P
print("\nResolvendo n sistemas diretamente na função solve_triangular")

Y = solve_triangular(l, p.T, lower=True, unit_diagonal=True)
A_inv1 = solve_triangular(u, Y)

print("\nI-A*A_inv=0?", np.allclose(I, A @ A_inv1))

# Calcula a norma da matriz resíduo R = I-A_inv*A
R1 = I - A_inv1 @ A
print("\n||R1||=", norm(R1))
print("\n")