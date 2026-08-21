# -*- coding: utf-8 -*-
"""
Created on Fri Nov  8 07:58:20 2024

@author: Rudnei
"""

# Exemplo de uso de ajuste de curva e de interpolador baricêntrico

import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
from scipy.interpolate import BarycentricInterpolator
from scipy.linalg import solve

# Funções para calcular e avaliar o polinômio interpolador de Newton
def interp_Newton(x,y):
    # x e y devem ser arranjos np.array
    # retorna os coeficientes c[0], c[1], ..., c[n]
    m = np.size(x) # supõe que x e y têm o mesmo tamanho
    A = np.zeros((m,m))
    A[:,0] = np.ones(m)
    # Monta a matriz de coeficientes do sistema triangular inferior
    for j in range(1,m):
        for i in range(j,m):
            A[i,j] = A[i,j-1]*(x[i]-x[j-1])
    # Resolve o sistema
    c = solve(A,y,lower=True)
    return c


def avalia_interp_Newton(c,x,z):
    # avalia o polinômio interpolador de Newton com coeficientes c e nós x
    # nos pontos z
    m = np.size(z)
    n = np.size(x)
    y = np.zeros(m)
    for k in range(m):
        for i in range(n):
            p = 1
            for j in range(i):
                p = p*(z[k]-x[j])
            y[k] = y[k]+c[i]*p
    return y

# Tabulação dos pontos e gráfico dos mesmos
dados_x = np.array([-3.0, 0.0, 2.0, 4.0])
dados_y = np.array([3.0, 1.0, 1.0, 3.0])

plt.plot(dados_x, dados_y, 'ro', label='dados')

# 1. Calcula a curva de ajuste quadrática

def quadratica(x, a, b, c):
    # Ajusta uma função quadrática y(x)=a*x**2+b*x+c
    return a*x**2+b*x+c

params2, cov2 = curve_fit(quadratica, dados_x, dados_y)
print("a, b, c=",params2)

# Calcula os erros verticais nos pontos tabulados
erros_y_quad = abs(dados_y - quadratica(dados_x, *params2))
print("Erros verticais no ajuste quadrático:",erros_y_quad)

# 2. Calcula a curva de ajuste cúbica

def cubica(x, a, b, c, d):
    # Ajusta uma função quadrática y(x)=a*x**3+b*x**2+c*x+d
    return a*x**3+b*x**2+c*x+d

params3, cov3 = curve_fit(cubica, dados_x, dados_y)
print("a, b, c, d=",params3)

# Calcula os erros verticais nos pontos tabulados
erros_y_cub = abs(dados_y - cubica(dados_x, *params3))
print("Erros verticais no ajuste cúbico:",erros_y_cub)

# 3. Calcula o polinômio interpolador de Lagrange na forma baricêntrica

p = BarycentricInterpolator(dados_x, dados_y)
print("Polinômio de Lagrange: y=p(x)=",p(dados_x))
print("  erros verticais: abs(y-p(x))=",abs(dados_y-p(dados_x)))

# 4. Calcula os coeficientes do polinômio interpolador de Newton

c = interp_Newton(dados_x,dados_y)
print("Coeficientes do polinômio de Newton:",c)

# Compara as três funções de forma gráfica

x = np.linspace(-3.0,4.0,30)

plt.plot(x, quadratica(x, *params2), 'b-', 
         label='quadrática: a=%5.3f, b=%5.3f, c=%5.3f' % tuple(params2))

plt.plot(x, cubica(x, *params3), 'm*', 
         label='cúbica: a=%5.3f, b=%5.3f, c=%5.3f, d=%5.3f' % tuple(params3))

plt.plot(x, p(x), 'g--', label='Lagrange')

plt.plot(x, avalia_interp_Newton(c,dados_x,x), 'c.', label='Newton')

plt.grid()
plt.xlabel('x')
plt.ylabel('y')
plt.legend()
plt.show()


