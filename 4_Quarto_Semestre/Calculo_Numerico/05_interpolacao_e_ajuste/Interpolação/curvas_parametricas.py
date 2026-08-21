# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 13:24:52 2024

@author: Prof. Rudnei
"""

import matplotlib.pyplot as plt
import numpy as np

# Curva de Ferguson

def ferguson(u,r0,r1,d0,d1):
    U = np.array([u**3,u**2,u,1])
    C = np.array([[ 2,-2, 1, 1],
                  [-3, 3,-2,-1],
                  [ 0, 0, 1, 0],
                  [ 1, 0, 0, 0]])
    SX = np.array([[r0[0]],
                   [r1[0]],
                   [d0[0]],
                   [d1[0]]])
    SY = np.array([[r0[1]],
                   [r1[1]],
                   [d0[1]],
                   [d1[1]]])
    x = U @ C @ SX
    y = U @ C @ SY
    return np.array([x[0],y[0]])

# Curva de Bézier

def bezier(u,r0,r1,r2,r3):
    U = np.array([u**3,u**2,u,1])
    N = np.array([[-1, 3,-3, 1],
                  [ 3,-6, 3, 0],
                  [-3, 3, 0, 0],
                  [ 1, 0, 0, 0]])
    RX = np.array([[r0[0]],
                   [r1[0]],
                   [r2[0]],
                   [r3[0]]])
    RY = np.array([[r0[1]],
                   [r1[1]],
                   [r2[1]],
                   [r3[1]]])
    x = U @ N @ RX
    y = U @ N @ RY
    return np.array([x[0],y[0]])


# Gráfico das curvas
# 1) Ferguson
r0 = np.array([0.0, 0.0])
r1 = np.array([10.0, 0.0])
d0 = np.array([1.0, 1.0])
d1 = np.array([1.0, -1.0])

n = 8
us = np.linspace(0, 1, n)
x = np.zeros(n)
y = np.zeros(n)

plt.figure(1)
plt.title("Curva de Ferguson")
plt.xlabel("x")
plt.ylabel("y")

# Desenha os vetores tangente nas extremidades
plt.plot([r0[0],r0[0]+d0[0]],[r0[1],r0[1]+d0[1]],'b--')
plt.plot([r1[0],r1[0]+d1[0]],[r1[1],r1[1]+d1[1]],'b--')

# Calcula os pontos na curva
for i in range(n):
    [x[i], y[i]] = ferguson(us[i],r0,r1,d0,d1)

# Exibe os pontos da curva
plt.plot(x,y,'ro-')

# Exibe o gráfico com reticulado
plt.grid()
plt.show()

# 2) Bézier
r0 = np.array([0.0, 0.0])
r1 = np.array([2.5, 5.0])
r2 = np.array([7.5, 5.0])
r3 = np.array([10.0, 0.0])

n = 8
us = np.linspace(0, 1, n)
x = np.zeros(n)
y = np.zeros(n)

plt.figure(1)
plt.title("Curva de Bézier")
plt.xlabel("x")
plt.ylabel("y")

# Desenha o polígono de controle
plt.plot([r0[0],r1[0],r2[0],r3[0]],
         [r0[1],r1[1],r2[1],r3[1]],'g--')

# Calcula os pontos na curva
for i in range(n):
    [x[i], y[i]] = bezier(us[i],r0,r1,r2,r3)

# Exibe os pontos da curva
plt.plot(x,y,'ro-')

# Exibe o gráfico com reticulado
plt.grid()
plt.show()