# -*- coding: utf-8 -*-
"""
Created on Tue Dec 17 13:28:09 2024

@author: Professor
"""
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate as integrate

def f(t):
    return np.exp(-2*t) + 4

def integral_exata(t):
    return 4*t - np.exp(-2*t)/2


# Intervalo de integração
a = 0
b = 5

# Valor exato

exata = integral_exata(b)-integral_exata(a)
print("Integral=",exata)

t_media = 1/(b-a)*exata
print("Temperatura média=",t_media)

# Gráfico da função
x = np.linspace(a,b,30)

plt.plot(x,f(x),'ro-')
plt.xlabel('x')
plt.ylabel('y')
plt.grid()
plt.show()


# Chamada da regra simples de Simpson
x = np.array([a, (a+b)/2, b])
y = f(x)
s = integrate.simpson(y, x)
erro_s = abs(exata-s)/abs(exata)
print("Simpson: s=",s,
      " erro_rel=",erro_s)

t_media_s = 1/(b-a)*s
print("Temperatura média (Simpson)=",t_media_s)

# Chamada da regra de Romberg
k = 2
while 1:
    n = 2**k
    h = (b-a)/n
    m = n+1
    x = np.linspace(a,b,m)
    y = f(x)
    r = integrate.romb(y, dx=h, show=True)
    t_media_r = 1/(b-a)*r
    erro_r = abs(t_media-t_media_r)/abs(t_media)
    print("Romberg: r=",r," erro_rel=",erro_r)
    if erro_r <= 1e-6:
        break
    else:
        k = 2*k
print("h=",h)

t_media_r = 1/(b-a)*r
print("Temperatura média (Romberg)=",t_media_r)