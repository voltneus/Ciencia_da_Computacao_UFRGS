# -*- coding: utf-8 -*-
"""
Created on Thu Jun 18 12:48:35 2026

@author: Prof. Rudnei
"""

import numpy as np

def nos_chebyshev(a,b,n):
    # O código abaixo calcula (n-2) nós de Chebyshev, x[j], tais que 
    # b > x[1] > ... > x[n-2] > a; o arranjo x é retornado em ordem reversa
    x = np.zeros(n)
    i = 1
    x[0] = b
    for j in range(n-2):
        x[j+1] = (a+b)/2+(b-a)/2*np.cos((2*i-1)/(2*(n-2))*np.pi)
        i = i+1
    x[n-1] = a
    return x[::-1]

x = nos_chebyshev(0,1,5)
print(x)