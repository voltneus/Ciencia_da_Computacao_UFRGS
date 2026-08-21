# -*- coding: utf-8 -*-
"""
Created on Thu Oct 31 10:04:30 2024

@author: Rudnei
"""
# resolve um sistema linear por fatoração LU.

import numpy as np
from scipy.linalg import lu
from scipy.linalg import solve_triangular
from scipy.linalg import norm

# nova matriz A deve ser sempre quadrada e não singular
A = np.array([[1, -1, 0, 0, 0, 0],
              [-1, 2, -1, 0, 0, 0],
              [0, -1, 2, -1, 0, 0],
              [0, 0, -1, 2, -1, 0],
              [0, 0, 0, -1, 2, -1],
              [0, 0, 0, 0, -1, 1]])

b = np.array([[0.4127], [1.7321], [-0.8621]])

print("\ncond(A)=", np.linalg.cond(A))

# A função lu devolve a fatoração A = P^{T}*L*U
p, l, u = lu(A)

print("\nA-P*L*U=0?", np.allclose(A, p @ l @ u))
print("\nl=")
print(l)
print("\nu=")
print(u)
print("\np=")
print(p)

# Solução por PA=LU
y = solve_triangular(l, p.T @ b, 
                     lower=True, unit_diagonal=True)
print("\ny=\n", y)
x = solve_triangular(u, y)
print("\nx=\n", x)

# Calcula o resíduo r=b-A*x e a sua norma
r = b - A @ x
print("\n", r)
print("||r||=", norm(r))
