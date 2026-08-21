# -*- coding: utf-8 -*-
"""
Created on Tue Dec 17 13:28:09 2024

@author: Professor
"""

import numpy as np

def f(x):
    return 4/(1+x**2)

def integral_exata(x):
    return 4*np.atan(x)

# Regras de integração simples

def trapezio(a,b):
    T = (b-a)/2*(f(a)+f(b))
    return T

def simpson(a,b):
    m = (a+b)/2
    S = (b-a)/6*(f(a)+4*f(m)+f(b))
    return S

# Intervalo de integração
a = 0
b = 1

# Valor exato

exata = integral_exata(b)-integral_exata(a)
print("Integral=",exata)

# Chamada das regras de integração

T = trapezio(a,b)
erro_T = abs(exata-T)/abs(exata)
print("Trapézio= ",T," erro_rel=",erro_T)

S = simpson(a,b)
erro_S = abs(exata-S)/abs(exata)
print("Simpson= ",S," erro_rel=",erro_S)

Tc = trapezio(a,(a+b)/2)+trapezio((a+b)/2,b)
erro_Tc = abs(exata-Tc)/abs(exata)
print("Trapézio composta= ",Tc," erro_rel=",erro_Tc)
