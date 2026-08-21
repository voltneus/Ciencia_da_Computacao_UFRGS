# -*- coding: utf-8 -*-
"""
Created on Tue Dec 17 13:28:09 2024

@author: Professor
"""
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate as integrate

def f(x):
    return 4/(1+x**2)

def integral_exata(x):
    return 4*np.atan(x)


# Intervalo de integração
a = 0
b = 1

# Valor exato

exata = integral_exata(b)-integral_exata(a)
print("Integral=",exata)


# Gráfico da função
x = np.linspace(a,b,30)

plt.plot(x,f(x),'ro-')
plt.xlabel('x')
plt.ylabel('y')
plt.grid()
plt.show()

# Chamada da regra simples do trapézio
x = np.array([a, b])
y = f(x)
t = integrate.trapezoid(y, x)
erro_t = abs(exata-t)/abs(exata)
print("Trapézio: t=",t,
      " erro_rel=",erro_t)

# Chamada da regra composta do trapézio
x = np.linspace(a,b,4)
y = f(x)
tc = integrate.trapezoid(y, x)
erro_tc = abs(exata-tc)/abs(exata)
print("Trapézio composta: tc=",tc,
      " erro_rel=",erro_tc)

# Chamada da regra simples de Simpson
x = np.array([a, (a+b)/2, b])
y = f(x)
s = integrate.simpson(y, x)
erro_s = abs(exata-s)/abs(exata)
print("Simpson: s=",s,
      " erro_rel=",erro_s)

# Chamada da regra composta de Simpson
x = np.linspace(a,b,4)
y = f(x)
sc = integrate.simpson(y, x)
erro_sc = abs(exata-sc)/abs(exata)
print("Simpson composta: sc=",sc,
      " erro_rel=",erro_sc)

# Chamada da regra de Romberg
k = 4
n = 2**k
h = (b-a)/n
m = n+1
x = np.linspace(a,b,m)
y = f(x)
r = integrate.romb(y, dx=h, show=True)
erro_r = abs(exata-r)/abs(exata)
print("Romberg: r=",r,
      " erro_rel=",erro_r)

# Chamada da Quadratura Gaussiana, com N=4
q = integrate.fixed_quad(f, a, b, n=4)
Q4 = q[0]
erro_Q4 = abs(exata-Q4)/abs(exata)
print("Quadratura Gaussiana (N=4)= ",Q4,
      " erro_rel=",erro_Q4)

# Chamada da Quadratura Gaussiana, com N=16
q = integrate.fixed_quad(f, a, b, n=16)
Q16 = q[0]
erro_Q16 = abs(exata-Q16)/abs(exata)
print("Quadratura Gaussiana (N=16)= ",Q16,
      " erro_rel=",erro_Q16)

# Chamada da Quadratura Gaussiana, com N=32
q = integrate.fixed_quad(f, a, b, n=32)
Q32 = q[0]
erro_Q32 = abs(exata-Q32)/abs(exata)
print("Quadratura Gaussiana (N=32)= ",Q32,
      " erro_rel=",erro_Q32)