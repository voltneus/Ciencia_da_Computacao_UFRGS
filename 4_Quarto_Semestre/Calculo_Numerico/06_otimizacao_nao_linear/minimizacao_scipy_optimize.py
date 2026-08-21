# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 13:24:52 2024

@author: Prof. Rudnei
"""

import numpy as np
from scipy.linalg import norm
from scipy.optimize import minimize
import sys


def F(X):
    x = X[0]
    y = X[1]
    return x**2+2*x*y-6*x+4*y**2

X = np.array([1.0, -2.0]) #<-- Ponto inicial

# O Gradiente (vetor com as derivadas parciais de 1ª ordem)
# df/dx =
# df/dy =
def grad(X):
    x = X[0]
    y = X[1]
    return np.array([2*x+2*y-6, 2*x+8*y])


# A Matriz Hessiana (matriz com as derivadas parciais de 2ª ordem)
# d²f/dx²  = 
# d²f/dxdy = 
# d²f/dydx = 
# d²f/dy²  = 
def Hess(X):
    x = X[0]
    y = X[1]
    return np.array([[2.0, 2.0],
                     [2.0, 8.0]])

# Não alterar abaixo

def vetor_canonico(n,k):
    e = np.zeros(n)
    e[k] = 1
    return e

def grad_num(X):
    # Calcula uma aproximação numérica para a derivada da função F.
    # X : vetor, n elementos; ponto no qual será avaliada a derivada.
    # k : valor inteiro; índice da variável (em termos dos elementos de x) em 
    #     relação à qual será calculada a derivada.
    n = np.size(X, 0)
    g = np.zeros(n)
    eps_maquina = sys.float_info.epsilon
    quase_zero = np.sqrt(sys.float_info.min)
    h = np.sqrt(eps_maquina)
    normax = norm(X)
    delta = h*normax
    F2 = F(X)
    for k in range(n):
        if normax < quase_zero:
            e = vetor_canonico(n,k)
            F1 = F(h*e)
            g[k] = (1.0/h)*(F1-F2)
        else:
            e = vetor_canonico(n,k)
            F1 = F(X+delta*e)
            g[k] = (1.0/delta)*(F1-F2)
    return g

# Chamadas da função scipy.optimize.minimize

print("\nNelder-Mead:")
rslt = minimize(F, X, method='nelder-mead',
                options={'xatol': 1e-6, 'disp': True})
print("X*=",rslt.x)

print("\nCG com gradiente explícito:")
rslt = minimize(F, X, method='CG', jac=grad, 
                options={'gtol': 1e-6, 'disp': True})
print("X*=",rslt.x)

print("\nCG com gradiente numérico:")
rslt = minimize(F, X, method='CG', jac=grad_num, 
                options={'gtol': 1e-6, 'disp': True})
print("X*=",rslt.x)

print("\nNewton-CG com gradiente explícito:")
rslt = minimize(F, X, method='Newton-CG', jac=grad, hess=Hess,
                options={'xtol': 1e-6, 'disp': True})
print("X*=",rslt.x)

print("\nNewton-CG com gradiente numérico:")
rslt = minimize(F, X, method='Newton-CG', jac=grad_num, hess=Hess,
                options={'xtol': 1e-6, 'disp': True})
print("X*=",rslt.x)

print("\nBFGS com gradiente explícito:")
rslt = minimize(F, X, method='BFGS', jac=grad, 
                options={'gtol': 1e-6, 'disp': True})
print("X*=",rslt.x)

print("\nBFGS com gradiente numérico:")
rslt = minimize(F, X, method='BFGS', jac=grad_num, 
                options={'gtol': 1e-6, 'disp': True})
print("X*=",rslt.x)
