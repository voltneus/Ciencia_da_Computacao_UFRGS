# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 13:24:52 2024

@author: Prof. Rudnei
"""

import numpy as np
from scipy.linalg import norm
import sys


def F(X):
    x = X[0]
    y = X[1]
    # return x**2+2*x*y-6*x+4*y**2
    return 4*x**2 + 9*y**2 + 8*x - 36*y + 24

X = np.array([-2.0, 1.0])

def grad(X):
    x = X[0]
    y = X[1]
    return np.array([8*x + 8, 18*y - 36])

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


def buscalinear_retrocessao(X,p,alfa,tau,c1,c2):
    # Iteração
    eps_maquina = sys.float_info.epsilon
    h = np.sqrt(eps_maquina)
    alfa_min = alfa
    while 1:
        phi = F(X+alfa_min*p)
        fk = F(X)
        g = grad_num(X)
        gphi = np.dot(grad_num(X+alfa_min*p),p)
        pg = np.dot(p,g)
        if phi <= fk+c1*alfa_min*pg and norm(p*gphi) <= c2*abs(pg):
            break
        alfa_min0 = tau*alfa_min
        if alfa_min0 < h:
            break
        else:
            alfa_min = alfa_min0
    return alfa_min


def gradiente(X, eps, kmax, num=True):
    # retorna uma lista contendo X, número de iterações e
    # estado ( 0: convergiu;
    #         -1: estourou número máximo de iterações.
    for k in range(kmax):
        # Calula o gradiente
        if num:
            p = -grad_num(X)
        else:
            p = -grad(X)
        #print("p=",p)
        # Testa a convergência
        norma_p = norm(p)
        #print("k=", k, " ||p||=", norma_p)
        if norma_p < eps:
            return [X, k, 0]
        else:
            # Calcula alfa
            #alfa = buscalinear_retrocessao(X,p,1.0,0.5,1e-4,0.1)
            alfa = 0.1 # ALFA É DEFINIDO AQUI --------------------------------- ATENÇÃO
            #print("alfa=",alfa)
            # Corrige X
            X = X + alfa*p
            #print("X=\n", X)
    return [X, k, -1]


print("Gradiente:")
rslt = gradiente(X, 1e-6, 100)
print(rslt)
print("f(",rslt[0],")=",F(rslt[0]))

