# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 13:24:52 2024

@author: Prof. Rudnei
"""

import numpy as np
from scipy.linalg import norm
from scipy.linalg import solve
from scipy.linalg import LinAlgError
import sys

# Intersecção entre três elipses

def F(X):
    x = X[0]
    y = X[1]
    return np.array([[x**2 + y**2 - 4],
                     [(x-2)**2 + (y+2)**2 - 4],
                     [(x-4)**2 + y**2 - 4]])


def jac(X):
    x = X[0]
    y = X[1]
    return np.array([[2*x, 2*y],
                     [2*x-4, 2*y+4],
                     [2*x-8, 2*y]])


# Não alterar abaixo

def vetor_canonico(n,k):
    e = np.zeros(n)
    e[k] = 1
    return e


def dernum(X,k):
    # Calcula uma aproximação numérica para a derivada da função F.
    # X : vetor, n elementos; ponto no qual será avaliada a derivada.
    # k : valor inteiro; índice da variável (em termos dos elementos de x) em 
    #     relação à qual será calculada a derivada.
    n = np.size(X, 0)
    eps_maquina = sys.float_info.epsilon
    quase_zero = np.sqrt(sys.float_info.min)
    h = np.sqrt(eps_maquina)
    normax = norm(X)
    if normax < quase_zero:
        e = vetor_canonico(n,k)
        F1 = F(h*e)
        F2 = F(X)
        d = (1.0/h)*(F1-F2)
    else:
        e = vetor_canonico(n,k)
        F1 = F(X+h*normax*e)
        F2 = F(X)
        d = (1.0/(h*normax))*(F1-F2)
    return d


def jac_num(X,m):
    # A matriz Jacobiana tem m linhas por n colunas
    n = np.size(X, 0)
    J = np.zeros((m,n))
    for k in range(n):
        d = dernum(X,k)
        J[:, k] = d.reshape(m)
    return J


def newton(X, tau_a, kmax, num=True):
    # retorna uma lista contendo X, número de iterações e
    # estado ( 0: convergiu;
    #         -1: estourou número máximo de iterações);
    #         -2 : matriz Jacobiana é singular).
    n = np.size(X, 0) # quantidade de variáveis
    Fx = F(X)
    m = np.size(Fx) # quantidade de equações
    # Iterações
    for k in range(kmax):
        # Testa a convergência
        norma_Fx = norm(Fx)
        print("k=", k, " ||F(X)||=", norma_Fx)
        if norma_Fx < tau_a:
            return [X, k, 0]
        else:
            # Calcula a matriz Jacobiana
            if num:
                J = jac_num(X,m)
            else:
                J = jac(X)
            print("J=\n", J)
            # Calcula a correção h
            if m == n:
                try:
                    h = solve(J, -Fx)
                except LinAlgError:
                    return [X, k, -2]
            else:
                try:
                    h = solve(J.T @ J, -(J.T @ Fx))
                except LinAlgError:
                    return [X, k, -2]
            # Corrige X
            X = X + h.reshape(n)
            print("X=\n", X)
            Fx = F(X)
    return [X, k, -1]



print("Newton:")
X = np.array([4.0, 0.5])
rslt = newton(X, 1e-8, 100)
print(rslt)
