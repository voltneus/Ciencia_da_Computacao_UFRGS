# -*- coding: utf-8 -*-
"""
Created on Tue Dec 17 13:28:09 2024

@author: Professor
"""
import numpy as np
import scipy.integrate as integrate

# Exercícios em aula

# Questão 1.a

def f(x):
    return x**4/3

def integral_exata(x):
    return x**5/15

print("Questão 1.a\n-----------")

# Intervalo de integração
a = -1
b = 1

# Valor exato
exata = integral_exata(b)-integral_exata(a)
print("Integral=",exata)

# Chamada da regra simples do trapézio
x = np.array([a, b])
y = f(x)
t = integrate.trapezoid(y, x)
erro_t = abs(exata-t)/abs(exata)
print("Trapézio: t=",t,
      " erro_rel=",erro_t)

# Chamada da regra simples de Simpson
x = np.array([a, (a+b)/2, b])
y = f(x)
s = integrate.simpson(y, x)
erro_s = abs(exata-s)/abs(exata)
print("Simpson: s=",s,
      " erro_rel=",erro_s)

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

print("----------------------------------------------------------------")

# Questão 1.b

def f(x):
    return x*np.exp(-x)

def integral_exata(x):
    return np.exp(-x)*(-x-1)

print("Questão 1.b\n-----------")

# Intervalo de integração
a = 0
b = 10

# Valor exato
exata = integral_exata(b)-integral_exata(a)
print("Integral=",exata)

# Chamada da regra simples do trapézio
x = np.array([a, b])
y = f(x)
t = integrate.trapezoid(y, x)
erro_t = abs(exata-t)/abs(exata)
print("Trapézio: t=",t,
      " erro_rel=",erro_t)

# Chamada da regra simples de Simpson
x = np.array([a, (a+b)/2, b])
y = f(x)
s = integrate.simpson(y, x)
erro_s = abs(exata-s)/abs(exata)
print("Simpson: s=",s,
      " erro_rel=",erro_s)

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

print("----------------------------------------------------------------")

# Questão 2.a

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

def f(x):
    return x/np.sqrt(x**2+1)

def integral_exata(x):
    return np.sqrt(x**2+1)

print("Questão 2.a\n-----------")

# Intervalo de integração
a = 0
b = 10

# Valor exato
exata = integral_exata(b)-integral_exata(a)
print("Integral=",exata)

# Chamada da regra composta do trapézio, nós homogêneos
x = np.linspace(a,b,8)
y = f(x)
tc = integrate.trapezoid(y, x)
erro_tc = abs(exata-tc)/abs(exata)
print("Trapézio composta homogênea: tc=",tc,
      " erro_rel=",erro_tc)

# Chamada da regra composta de Simpson, nós homogêneos
x = np.linspace(a,b,8)
y = f(x)
sc = integrate.simpson(y, x)
erro_sc = abs(exata-sc)/abs(exata)
print("Simpson composta homogênea: sc=",sc,
      " erro_rel=",erro_sc)

# Chamada da regra composta do trapézio, nós de Chebyshev
x = nos_chebyshev(a,b,8)
y = f(x)
tc = integrate.trapezoid(y, x)
erro_tc = abs(exata-tc)/abs(exata)
print("Trapézio composta, nós de Chebyshev: tc=",tc,
      " erro_rel=",erro_tc)

# Chamada da regra composta de Simpson, nós de Chebyshev
x = nos_chebyshev(a,b,8)
y = f(x)
sc = integrate.simpson(y, x)
erro_sc = abs(exata-sc)/abs(exata)
print("Simpson composta, nós de Chebyshev: sc=",sc,
      " erro_rel=",erro_sc)

print("----------------------------------------------------------------")


# Questão 2.b

def f(x):
    return x*np.exp(-x/2)

def integral_exata(x):
    return np.exp(-x/2)*(-2*x-4)

print("Questão 2.b\n-----------")

# Intervalo de integração
a = 0
b = 20

# Valor exato
exata = integral_exata(b)-integral_exata(a)
print("Integral=",exata)

# Chamada da regra composta do trapézio, nós homogêneos
x = np.linspace(a,b,8)
y = f(x)
tc = integrate.trapezoid(y, x)
erro_tc = abs(exata-tc)/abs(exata)
print("Trapézio composta homogênea: tc=",tc,
      " erro_rel=",erro_tc)

# Chamada da regra composta de Simpson, nós homogêneos
x = np.linspace(a,b,8)
y = f(x)
sc = integrate.simpson(y, x)
erro_sc = abs(exata-sc)/abs(exata)
print("Simpson composta homogênea: sc=",sc,
      " erro_rel=",erro_sc)

# Chamada da regra composta do trapézio, nós de Chebyshev
x = nos_chebyshev(a,b,8)
y = f(x)
tc = integrate.trapezoid(y, x)
erro_tc = abs(exata-tc)/abs(exata)
print("Trapézio composta, nós de Chebyshev: tc=",tc,
      " erro_rel=",erro_tc)

# Chamada da regra composta de Simpson, nós de Chebyshev
x = nos_chebyshev(a,b,8)
y = f(x)
sc = integrate.simpson(y, x)
erro_sc = abs(exata-sc)/abs(exata)
print("Simpson composta, nós de Chebyshev: sc=",sc,
      " erro_rel=",erro_sc)

print("----------------------------------------------------------------")

# Questão 2.c

def f(t):
    return 1000/((t-30)**2+100)+40/((t-60)**2+20)

def integral_exata(t):
    return 40*((np.atan((t - 60)/(2*np.sqrt(5))))/(2*np.sqrt(5)) + 5/2*np.atan((t - 30)/10))

print("Questão 2.c\n-----------")

# Intervalo de integração
a = 0
b = 100

# Valor exato
exata = integral_exata(b)-integral_exata(a)
print("Integral=",exata)

# Chamada da regra composta do trapézio, nós homogêneos
x = np.linspace(a,b,32)
y = f(x)
tc = integrate.trapezoid(y, x)
erro_tc = abs(exata-tc)/abs(exata)
print("Trapézio composta homogênea: tc=",tc,
      " erro_rel=",erro_tc)

# Chamada da regra composta de Simpson, nós homogêneos
x = np.linspace(a,b,32)
y = f(x)
sc = integrate.simpson(y, x)
erro_sc = abs(exata-sc)/abs(exata)
print("Simpson composta homogênea: sc=",sc,
      " erro_rel=",erro_sc)

# Chamada da regra composta do trapézio, nós de Chebyshev
x = nos_chebyshev(a,b,32)
y = f(x)
tc = integrate.trapezoid(y, x)
erro_tc = abs(exata-tc)/abs(exata)
print("Trapézio composta, nós de Chebyshev: tc=",tc,
      " erro_rel=",erro_tc)

# Chamada da regra composta de Simpson, nós de Chebyshev
x = nos_chebyshev(a,b,32)
y = f(x)
sc = integrate.simpson(y, x)
erro_sc = abs(exata-sc)/abs(exata)
print("Simpson composta, nós de Chebyshev: sc=",sc,
      " erro_rel=",erro_sc)

print("----------------------------------------------------------------")

# Questão 4

def f(t):
    return 0.001*t**4-0.280*t**2+25

def integral_exata(t):
    return t**5/5000-7*t**3/75+25*t

print("Questão 4\n-----------")

# Intervalo de integração
a = -12
b = 12

# Valor exato
exata = integral_exata(b)-integral_exata(a)
print("Integral=",exata)
print("Temperatura média exata=",1/(b-a)*exata)

# Chamada da regra simples do trapézio
x = np.array([a, b])
y = f(x)
t = integrate.trapezoid(y, x)
erro_t = abs(exata-t)/abs(exata)
print("Trapézio: t=",t,
      " erro_rel=",erro_t)
print("Temperatura média por trapézio=",1/(b-a)*t)

# Chamada da regra simples de Simpson
x = np.array([a, (a+b)/2, b])
y = f(x)
s = integrate.simpson(y, x)
erro_s = abs(exata-s)/abs(exata)
print("Simpson: s=",s,
      " erro_rel=",erro_s)
print("Temperatura média por Simpson=",1/(b-a)*s)

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
print("Temperatura média por Romberg=",1/(b-a)*r)

# Chamada da Quadratura Gaussiana, com N=4
q = integrate.fixed_quad(f, a, b, n=4)
Q4 = q[0]
erro_Q4 = abs(exata-Q4)/abs(exata)
print("Quadratura Gaussiana (N=4)= ",Q4,
      " erro_rel=",erro_Q4)
print("Temperatura média por Quadratura Gaussiana=",1/(b-a)*Q4)

# Chamada da Quadratura Gaussiana, com N=16
q = integrate.fixed_quad(f, a, b, n=16)
Q16 = q[0]
erro_Q16 = abs(exata-Q16)/abs(exata)
print("Quadratura Gaussiana (N=16)= ",Q16,
      " erro_rel=",erro_Q16)
print("Temperatura média por Quadratura Gaussiana=",1/(b-a)*Q16)

# Chamada da Quadratura Gaussiana, com N=32
q = integrate.fixed_quad(f, a, b, n=32)
Q32 = q[0]
erro_Q32 = abs(exata-Q32)/abs(exata)
print("Quadratura Gaussiana (N=32)= ",Q32,
      " erro_rel=",erro_Q32)
print("Temperatura média por Quadratura Gaussiana=",1/(b-a)*Q32)

print("----------------------------------------------------------------")

# Questão 5

# A função integranda requer a derivada de y = f(x) em relação a x.
# Como y = 1.35*sin(0.589*x), então dy/dx = 1.35*cos(0.589*x)*0.589

def f(x):
    return np.sqrt(1+(1.35*np.cos(0.589*x)*0.589)**2)

print("Questão 5\n-----------")

# Intervalo de integração
a = 0
b = 10.67

# Valor exato
exata = 12.19597227
print("Integral=",exata)

# Chamada da regra simples do trapézio
x = np.array([a, b])
y = f(x)
t = integrate.trapezoid(y, x)
erro_t = abs(exata-t)/abs(exata)
print("Trapézio: t=",t,
      " erro_rel=",erro_t)

# Chamada da regra composta do trapézio, nós homogêneos
x = np.linspace(a,b,32)
y = f(x)
tc = integrate.trapezoid(y, x)
erro_tc = abs(exata-tc)/abs(exata)
print("Trapézio composta homogênea: tc=",tc,
      " erro_rel=",erro_tc)

# Chamada da regra simples de Simpson
x = np.array([a, (a+b)/2, b])
y = f(x)
s = integrate.simpson(y, x)
erro_s = abs(exata-s)/abs(exata)
print("Simpson: s=",s,
      " erro_rel=",erro_s)

# Chamada da regra composta de Simpson, nós homogêneos
x = np.linspace(a,b,32)
y = f(x)
sc = integrate.simpson(y, x)
erro_sc = abs(exata-sc)/abs(exata)
print("Simpson composta homogênea: sc=",sc,
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

print("----------------------------------------------------------------")