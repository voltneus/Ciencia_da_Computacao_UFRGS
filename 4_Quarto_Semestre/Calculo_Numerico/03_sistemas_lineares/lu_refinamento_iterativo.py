# -*- coding: utf-8 -*-
"""
Created on Thu Oct 31 10:04:30 2024

@author: Rudnei
"""

import numpy as np
from scipy.linalg import lu
from scipy.linalg import solve_triangular
from scipy.linalg import norm


def refinamento_iterativo(A, b, eps, kmax):
    p, l, u = lu(A)
    y = solve_triangular(l, p.T @ b, lower=True, unit_diagonal=True)
    x = solve_triangular(u, y)
    xtil = x
    r = b-A @ xtil
    norma_r = norm(r)
    k = 0
    while norma_r >= eps and k <= kmax:
        y = solve_triangular(l, -p.T @ r, lower=True, unit_diagonal=True)
        e = solve_triangular(u, y)
        x = xtil-e
        xtil = x
        r = b-A @ xtil
        norma_r = norm(r)
        k = k+1
    return [x, k]


# Matriz bem condicionada
A = np.array([[3, 2, -1],
              [6, 6, 2],
              [-1, 1, 3]])

# Matriz mal condicionada
'''delta = 1e-15
A = np.array([[2, 5, 8, 7],
              [5, 2, 2, 8],
              [2+delta, 5+delta, 8+delta, 7+delta],
              [5, 4, 4, 8]])'''

print("cond(A)=", np.linalg.cond(A))

n = np.size(A, 0)  # assume que a matriz A é quadrada
exata = np.zeros((n, 1))
exata[0] = 1
exata[n-1] = 1
b = A @ exata

# Solução por PA=LU
p, l, u = lu(A)
y = solve_triangular(l, p.T @ b, lower=True, unit_diagonal=True)
print("y=", y)
x = solve_triangular(u, y)
print("x=", x)

# Compara a solução obtida com a exata
print("Ax=b?", np.allclose(A @ x, b))

# Calcula o resíduo r=b-A*x e a sua norma
r = b - A @ x
print(r)
print("||r||=", norm(r))

# Resolve pelo refinamento iterativo
x, k = refinamento_iterativo(A, b, 1e-16, 100)

print("x =\n", x, "\nk=", k)

# Compara a solução obtida com a exata
print("Ax=b?", np.allclose(A @ x, b))

# Calcula o erro e=exata-x e a sua norma
e = exata - x
print("e=\n", e)
print("||e||=", norm(e))

# Calcula o resíduo r=b-A*x e a sua norma
r = b - A @ x
print("r=\n", r)
print("||r||=", norm(r))

print("L=", l)
print("U=", u)
print("P=", p)