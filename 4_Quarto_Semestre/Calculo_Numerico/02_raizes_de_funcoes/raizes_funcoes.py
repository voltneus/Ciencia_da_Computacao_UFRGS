# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 13:24:52 2024

@author: Prof. Rudnei
"""

import matplotlib.pyplot as plt
import numpy as np
import sys


def f(x):
    return np.exp(np.sin(x))-2*np.cos(3*x)

def df(x):
    #return 2*x
     eps_maquina = sys.float_info.epsilon
     h = np.sqrt(eps_maquina)
    # Aproximação progressiva para f'(x)
    # return (f(x+h)-f(x))/h
    # Aproximação regressiva para f'(x)
    # return (f(x)-f(x-h))/h
    # Aproximação central para f'(x)
     return (f(x+h)-f(x-h))/(2*h)


def d2f(x):
    eps_maquina = sys.float_info.epsilon
    h = np.sqrt(eps_maquina)
    return (df(x+h)-df(x-h))/(2*h)

# 1. Métodos de enquadramento

def bisseccao(a, b, epsilon, delta, kmax):
    # retorna uma lista contendo a, b, m, número de iterações e
    # estado (0: convergiu; 1: |a-b|<delta;
    # -2: no intervalo inicial, f(a)*f(b)>0)
    m = []
    f_a = f(a)
    f_b = f(b)
    if f_a * f_b < 0:
        for k in range(kmax):
            m = (a+b)/2
            f_m = f(m)
            # plt.plot([a, b], [f_a, f_b], 'o:r')
            if abs(f_m) < epsilon:
                return [a, b, m, k, 0]
            elif abs(a-b) < delta:
                return [a, b, m, k, 1]
            elif f_a * f_m < 0:
                b = m
                f_b = f_m
            else:
                a = m
                f_a = f_m
    else:
        return [a, b, m, 0, -2]


def posicao_falsa(a, b, epsilon, delta, kmax):
    # retorna uma lista contendo a, b, m, número de iterações e
    # estado (0: convergiu; 1: |a-b|<delta;
    # -2: no intervalo inicial, f(a)*f(b)>0)
    c = []
    f_a = f(a)
    f_b = f(b)
    if f_a * f_b < 0:
        for k in range(kmax):
            c = (f_b*a-f_a*b)/(f_b-f_a)
            f_c = f(c)
            # plt.plot([a, b], [f_a, f_b], 'o:r')
            if abs(f_c) < epsilon:
                return [a, b, c, k, 0]
            elif abs(a-b) < delta:
                return [a, b, c, k, 1]
            elif f_a * f_c < 0:
                b = c
                f_b = f_c
            else:
                a = c
                f_a = f_c
    else:
        return [a, b, c, 0, -2]

# 2. Métodos de busca

def newton_raphson(x, epsilon, delta, kmax):
    # retorna uma lista contendo x, número de iterações e
    # estado (0: convergiu; 1: |x-x_ant|<delta; -1: f'(x)=0)
    for k in range(kmax):
        f_k = f(x)
        print(x,abs(f_k))
        # plt.plot([x], [f_k], 'd:g')
        if abs(f_k) < epsilon:
            return [x, k, 0]
        else:
            df_k = df(x)
            if abs(df_k) > 0:
                x_k = x
                x = x-f_k/df_k
                if abs(x-x_k) < delta:
                    return [x, k, 1]
            else:
                return [x, k, -1]


def halley(x, epsilon, delta, kmax):
    # retorna uma lista contendo x, número de iterações e
    # estado (0: convergiu; 1: |x-x_ant|<delta; -1: f'(x)=f''(x)=0)
    for k in range(kmax):
        f_k = f(x)
        print(x,abs(f_k))
        # plt.plot([x], [f_k], 'd:g')
        if abs(f_k) < epsilon:
            return [x, k, 0]
        else:
            df_k = df(x)
            d2f_k = d2f(x)
            if abs(df_k) and abs(d2f_k) > 0:
                x_k = x
                x = x-(2*f_k*df_k)/(2*df_k**2-f_k*d2f_k)
                if abs(x-x_k) < delta:
                    return [x, k, 1]
            else:
                return [x, k, -1]


def secante(x0, x1, epsilon, delta, kmax):
    # retorna uma lista contendo x, número de iterações e
    # estado (0: convergiu; 1: |x-x_ant|<delta;
    # -1: f(x[k+1])-f(x[k])=0)
    x2 = []
    f_x0 = f(x0)
    f_x1 = f(x1)
    eps_maquina = sys.float_info.epsilon
    for k in range(kmax):
        # plt.plot([x0, x1], [f_x0, f_x1], 'd:g')
        if abs(f_x1-f_x0) < eps_maquina:
            return [x2, k, -1]
        else:
            x2 = x1-f_x1*(x1-x0)/(f_x1-f_x0)
            f_x2 = f(x2)
            print(x2,abs(f_x2))
            if abs(f_x2) < epsilon:
                return [x2, k, 0]
            elif abs(x2-x1) < delta:
                return [x2, k, 1]
            else:
                # Corrige para a próxima iteração
                x0 = x1
                x1 = x2
                f_x0 = f_x1
                f_x1 = f_x2

# Gráfico da função e chamada dos procedimentos

xs = np.linspace(-5, 5, 30)
ys = f(xs)

plt.title("Gráfico de f(x)")
plt.xlabel("x")
plt.ylabel("y")
plt.plot(xs, ys)


epsilon=1e-12
delta=4e-16
kmax=100

print("\nBissecção:")
rslt = bisseccao(1, 2, epsilon,delta,kmax)
print(rslt)
print("\nPosição falsa:")
rslt = posicao_falsa(1, 4, epsilon,delta,kmax)
print(rslt)
print("\nNewton-Raphson:")
rslt = newton_raphson(-0.5, epsilon,delta,kmax)
print(rslt)
print(df(rslt[0]))
print("\nHalley:")
rslt = halley(1, epsilon,delta,kmax)
print(rslt)
print("\nSecante:")
rslt = secante(1, 4, epsilon,delta,kmax)
print(rslt)


plt.grid()
plt.show()

