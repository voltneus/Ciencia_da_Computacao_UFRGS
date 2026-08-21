# -*- coding: utf-8 -*-
"""
Created on Tue Dec 17 13:28:09 2024

@author: Professor
"""
import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate as integrate
import sys

def f(t):
    if t>=0 and t<=5:
        return 2*t
    else:
        return t**2-15

def integral_exata(t):
    if t>=0 and t<=5:
        return t**2
    else:
        return t**3/3-15*t


# Intervalo de integração
a = 0
b = 10

# Valor exato

eps_maquina = sys.float_info.epsilon

exata = integral_exata(b)-integral_exata(5+np.sqrt(eps_maquina))+integral_exata(5)-integral_exata(a)
print("Integral=",exata)

vf = np.vectorize(f)

# Gráfico da função
n = 30
x = np.linspace(a,b,n)
y = vf(x)

plt.plot(x,y,'ro-')
plt.xlabel('x')
plt.ylabel('y')
plt.grid()
plt.show()

# Chamada da regra simples do trapézio
x = np.array([a, b])
t = integrate.trapezoid(vf(x), x)
erro_t = abs(exata-t)/abs(exata)
print("Trapézio: t=",t,
      " erro_rel=",erro_t)

# Chamada da regra composta do trapézio
x = np.linspace(a,b,4)
tc = integrate.trapezoid(vf(x), x)
erro_tc = abs(exata-tc)/abs(exata)
print("Trapézio composta: tc=",tc,
      " erro_rel=",erro_tc)

# Chamada da regra simples de Simpson
x = np.array([a, (a+b)/2, b])
s = integrate.simpson(vf(x), x)
erro_s = abs(exata-s)/abs(exata)
print("Simpson: s=",s,
      " erro_rel=",erro_s)

# Chamada da regra composta de Simpson
x = np.linspace(a,b,4)
sc = integrate.simpson(vf(x), x)
erro_sc = abs(exata-sc)/abs(exata)
print("Simpson composta: sc=",sc,
      " erro_rel=",erro_sc)

# Chamada da regra de Romberg
k = 4
n = 2**k
h = (b-a)/n
m = n+1
x = np.linspace(a,b,m)
r = integrate.romb(vf(x), dx=h, show=True)
erro_r = abs(exata-r)/abs(exata)
print("Romberg: r=",r,
      " erro_rel=",erro_r)

# Chamada da Quadratura Gaussiana, com N=4
q = integrate.fixed_quad(vf, a, b, n=4)
Q4 = q[0]
erro_Q4 = abs(exata-Q4)/abs(exata)
print("Quadratura Gaussiana (N=4)= ",Q4,
      " erro_rel=",erro_Q4)

# Chamada da Quadratura Gaussiana, com N=16
q = integrate.fixed_quad(vf, a, b, n=16)
Q16 = q[0]
erro_Q16 = abs(exata-Q16)/abs(exata)
print("Quadratura Gaussiana (N=16)= ",Q16,
      " erro_rel=",erro_Q16)

# Chamada da Quadratura Gaussiana, com N=32
q = integrate.fixed_quad(vf, a, b, n=32)
Q32 = q[0]
erro_Q32 = abs(exata-Q32)/abs(exata)
print("Quadratura Gaussiana (N=32)= ",Q32,
      " erro_rel=",erro_Q32)