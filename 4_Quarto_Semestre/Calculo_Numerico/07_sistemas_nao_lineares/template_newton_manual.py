import numpy as np

# ====================================================================
# PASSO 1: DEFINIÇÃO DA FUNÇÃO ORIGINAL E SUAS DERIVADAS MANUAIS
# ====================================================================
# Função: f(x,y) = 3*x**4 + 2*x*y - 2*y**4 + x - y

def f_num(x, y):
    return 3*x**4 + 2*x*y - 2*y**4 + x - y

# O Gradiente (vetor com as derivadas parciais de 1ª ordem)
# df/dx = 12*x^3 + 2*y + 1
# df/dy = 2*x - 8*y^3 - 1
def grad_num(x, y):
    df_dx = 12 * x**3 + 2 * y + 1
    df_dy = 2 * x - 8 * y**3 - 1
    return np.array([df_dx, df_dy])

# A Matriz Hessiana (matriz com as derivadas parciais de 2ª ordem)
# d²f/dx²  = 36*x^2
# d²f/dxdy = 2
# d²f/dydx = 2
# d²f/dy²  = -24*y^2
def hess_num(x, y):
    d2f_dx2 = 36 * x**2
    d2f_dxdy = 2
    d2f_dydx = 2
    d2f_dy2 = -24 * y**2
    return np.array([
        [d2f_dx2, d2f_dxdy],
        [d2f_dydx,  d2f_dy2]
    ])

# ====================================================================
# PASSO 2: PARÂMETROS INICIAIS DA QUESTÃO
# ====================================================================
x0 = -1.0
y0 = 1.0
tolerancia = 1e-8
max_iteracoes = 100

# ====================================================================
# PASSO 3: ALGORITMO DO MÉTODO DE NEWTON 
# ====================================================================
def newton_minimo(x_val, y_val, tol, max_iter):
    for k in range(max_iter):
        g = grad_num(x_val, y_val)
        H = hess_num(x_val, y_val)
        
        # Resolve o sistema H * delta = gradiente
        # Obs: Usamos o linalg.solve por ser mais eficiente e seguro que inverter a matriz,
        # mas tem o mesmo efeito de: delta = np.linalg.inv(H).dot(g)
        delta = np.linalg.solve(H, g)
        
        # Atualiza os pontos
        x_val = x_val - delta[0]
        y_val = y_val - delta[1]
        
        # Critério de parada
        if np.linalg.norm(delta) < tol:
            return x_val, y_val, k + 1
            
    print("Não convergiu!")
    return x_val, y_val, max_iter

# ====================================================================
# PASSO 4: EXECUÇÃO
# ====================================================================
x_min, y_min, iteracoes = newton_minimo(x0, y0, tolerancia, max_iteracoes)
f_min = f_num(x_min, y_min) 

print("\n--- RESULTADO FINAL ---")
print(f"Ponto de mínimo aproximado: x = {x_min:.10f}, y = {y_min:.10f}")
print(f"Valor da função no mínimo:  f(x,y) = {f_min:.10f}")
print(f"Iterações necessárias:      {iteracoes}")