# -*- coding: utf-8 -*-
"""
Created on Wed Sep 25 14:27:14 2024

@author: Prof. Rudnei
"""

import numpy as np
from scipy.linalg import solve_triangular
from scipy.linalg import norm
from scipy.io import mmread


def jacobi(A, b, x, tol, imax):
    # Guarda o inverso da diagonal de A num vetor para poder efetuar
    # o produto elemento-a-elemento usando o operador *
    invD = np.reshape(1.0/np.diag(A), (-1, 1))
    # Iterações
    for i in range(imax):
        # Calcula o resíduo e a sua norma
        r = b - A @ x
        rnorm = norm(r)
        print("i= ", i, " rnorm=", rnorm)
        # Testa a convergência
        if rnorm < tol:
            return [x, rnorm, i, 0]
        else:
            # Corrige a estimativa para a solução
            x = x + invD*r
    return [x, rnorm, i, -1]


def gauss_seidel(A, b, x, tol, imax):
    # Iterações
    for i in range(imax):
        # Calcula o resíduo e a sua norma
        r = b - A @ x
        rnorm = norm(r)
        print("i= ", i, " rnorm=", rnorm)
        # Testa a convergência
        if rnorm < tol:
            return [x, rnorm, i, 0]
        else:
            # Corrige a estimativa para a solução
            x = x + solve_triangular(A, r, lower=True)
    return [x, rnorm, i, -1]


def sor(A, b, x, omega, tol, imax):
    # Separando a matriz A em partes
    # Abaixo da diagonal
    L = np.tril(A, -1)
    
    # Diagonal
    D = np.diag(np.diag(A))
    
    # Montando a matriz M para usar no solve_triangular
    M = L + (D/omega)
    
    # Iterações
    for i in range(imax):
        # Calcula o resíduo e a sua norma
        r = b - A @ x
        rnorm = norm(r)
        print("i= ", i, " rnorm=", rnorm)
        # Testa a convergência
        if rnorm < tol:
            return [x, rnorm, i, 0]
        else:
            # Corrige a estimativa para a solução
            # Usamos o sistema M*delta_x = r
            x = x + solve_triangular(M, r, lower=True)
    return [x, rnorm, i, -1]

# Para alterar a entrada, basta alterar A e trocar o vetor B.

A = np.array([[4, -1, -1, 0],
              [-1, 4, 0, -1],
              [-1, 0, 4, -1],
              [0, -1, -1, 4]])


n = np.size(A, 0)  # assume que a matriz A é quadrada
exata = np.zeros((n, 1))
exata[0] = 1
exata[n-1] = 1
b = A @ exata
x = np.zeros((n, 1))


# Método de Jacobi
print("Jacobi:")
res_j = jacobi(A, b, x, 1e-8, 100)
print("x=\n", res_j[0])
print("||r||=", res_j[1])
print("número de iterações=", res_j[2])
print("estado=", res_j[3])

# Método de Gauss-Seidel
print("\nGauss-Seidel:")
res_gs = gauss_seidel(A, b, x, 1e-8, 100)
print("x=\n", res_gs[0])
print("||r||=", res_gs[1])
print("número de iterações=", res_gs[2])
print("estado=", res_gs[3])

# Método SOR (lembrar do omega)
print("\nSOR:")
res_sor = sor(A, b, x, 1.2, 1e-8, 100)
print("x=\n", res_sor[0])
print("||r||=", res_sor[1])
print("número de iterações=", res_sor[2])
print("estado=", res_sor[3])