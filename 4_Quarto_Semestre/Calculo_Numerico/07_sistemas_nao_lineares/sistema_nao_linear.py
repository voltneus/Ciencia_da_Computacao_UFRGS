# -*- coding: utf-8 -*-
"""
Created on Fri Nov  8 07:58:20 2024

@author: Rudnei
"""

# Exemplo de uso do método de Newton para sistemas não-lineares

import numpy as np
from scipy.optimize import root

# Ex 2: Intersecção de esferas


def f(vetor):
    x = vetor[0]
    y = vetor[1]
    z = vetor[2]
    return [x**2 + y**2 + z**2 - 25,
            (x-5)**2 / 10 + (y+3)**2 / 20 + z**2 / 10 - 1,
            (x-5)**2 / 10 + (y-3)**2 / 20 + z**2 / 10 - 1]


solucao1 = root(f, [0, 0, 5], jac=False, tol=1e-12, method='hybr')

print("Solucao1:")
print(solucao1)

# Ex 3: Mínimo da função de Rosenbrock


def grad_rosenbrock(x):
    return [2 * x[0] - 2 - 400 * x[0]*(x[1] - x[0]**2),
            200 * (x[1] - x[0]**2)]


solucao2 = root(grad_rosenbrock, [4, 2], jac=False, tol=1e-12, method='hybr')

print("Solucao2:")
print(solucao2)
