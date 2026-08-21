# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 19:21:50 2024

@author: Rudnei
"""

import pylab as plt
import numpy as np


def p(a, z):
    # z é um número complexo
    s = 0
    n = len(a)
    for i in range(n):
        s = s+a[i]*z**i
    return s


def dp(a, z):
    # z é um número complexo
    s = 0
    n = len(a)
    for i in range(1, n):
        s = s+i*a[i]*z**(i-1)
    return s

    
def newton_raphson(a, z, epsilon, delta, kmax):
    # retorna uma lista contendo z, número de iterações e
    # estado (0: convergiu; 1: |z-z_ant|<delta; -1: f'(z)=0)
    for k in range(kmax):
        f_k = p(a, z)
        if abs(f_k) < epsilon:
            return [z, k, 0]
        else:
            df_k = dp(a, z)
            if abs(df_k) > 0:
                x_k = z
                z = z-f_k/df_k
                if abs(z-x_k) < delta:
                    return [z, k, 1]
            else:
                return [z, k, -1]
    

def distancia(a, z):
    # z é um número complexo
    return abs(p(a, z))


def kojima(a):
    # a é uma lista contendo os coeficientes [a_0, a_1, ..., a_n]
    # do polinômio p(z)=a_0+a_1 z+...+a_n z**n
    n = len(a)-1
    i = 0
    r1 = abs(a[i] / a[n])**(1/(n-i))
    i = 1
    r2 = abs(a[i] / a[n])**(1/(n-i))
    if r1 < r2:
        [r1, r2] = [r2, r1]
    for i in range(2, n):
        r = (abs(a[i] / a[n])**(1/(n-i)))
        if r > r1:
            r2 = r1
            r1 = r
        elif r > r2:
            r2 = r
    return r1+r2


def mouse_event(event):
    print('(x,y)=({},{})'.format(event.xdata, event.ydata))


def mapa(a, x0, x1, y0, y1, n):
    #  Para utilizar:
    # 1) Acesse Ferramentas/Preferências/Console IPython/Gráficos;
    # 2) No menu "Saída gráfica", escolha a opção "Qt".
    # Execute esse script; o mapa de cores aparecerá numa janela separada;
    # clicando sobre o ponto desejado no mapa, as suas coordenadas
    # aparecerão na console; movendo o mouse sobre o mapa, as suas
    # coordenadas aparecerão no canto superior direito da janela.
    x_pontos = np.linspace(x0, x1, n)
    y_pontos = np.linspace(y0, y1, n)
    X, Y = np.meshgrid(x_pontos, y_pontos)
    Z = np.vectorize(complex)(X, Y)
    P = distancia(a, Z)
    # desenha o mapa de cores da função |p(z)|
    fig = plt.figure()
    cid = fig.canvas.mpl_connect('button_press_event', mouse_event)
    plt.pcolormesh(X, Y, P, cmap=plt.colormaps["prism"])
    plt.title("Gráfico de |p(z)|")
    plt.xlabel("Re z")
    plt.ylabel("Im z")
    plt.grid()
    plt.colorbar()
    plt.show()

# 1) p(z)=
a = [2, -1, 2, -1, 1, -5, 2]


# 2) p(z)=z**4-3*z**3+12*z**2-2*z+10
#a = [10, -2, 12, -3, 1]
# Enumeração:
# Regra de Descartes para p(z)
# sinais: + - + - + => T=4
# Regra de Descartes para p(-z)
# sinais: + + + + + => T=0
#
# No máximo, 4 raízes reais positivas;
# nenhuma raiz real negativa. Então,
# o polinômio pode ter:
# a) 4 raízes reais positivas;
# b) 2 raízes reais positivas e 
#    um par complexo conjugado;
# c) 2 pares complexos conjugados.


# 3) p(z)=z**4-5*z**3+8*z**2-4*z
# a = [0, -4, 8, -5, 1]


cota = kojima(a)
print(cota)
#cota = cota/2

# Gráfico R->R
xs = np.linspace(-1, 2.5, 30)
ys = p(a, xs)

plt.title("Gráfico de p(x)")
plt.xlabel("x")
plt.ylabel("y")
plt.plot(xs, ys)
plt.grid()
plt.show()

# Mapa de cores
mapa(a, -1.0, 1.5, -1.5, 1.5, 100)

z = complex(-0.6, 0.6)
rslt = newton_raphson(a, z, 1e-6, 1e-8, 100)
print("Newton-Raphson:")
print(rslt)