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

# Tabulação dos pontos e gráfico dos mesmos
dados_x = np.array([-3.0, 0.0, 2.0, 4.0])
dados_y = np.array([3.0, 1.0, 1.0, 3.0])

plt.plot(dados_x, dados_y, 'ro', label='dados')

# Calcula o polinômio interpolador de Lagrange na forma baricêntrica

p = BarycentricInterpolator(dados_x, dados_y)
print("Polinômio de Lagrange: y=p(x)=",p(dados_x))
print("  erros: abs(y-p(x))=",abs(dados_y-p(dados_x)))

# Faz o gráfico

x = np.linspace(-3,4,30)

plt.plot(x, p(x), 'g--', label='Lagrange')

plt.grid()
plt.xlabel('x')
plt.ylabel('y')
plt.legend()
plt.show()


