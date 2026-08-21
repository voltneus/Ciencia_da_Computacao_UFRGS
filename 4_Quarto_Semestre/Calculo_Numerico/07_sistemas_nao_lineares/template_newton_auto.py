import numpy as np
import sympy as sp

# ====================================================================
# PASSO 1: DEFINIÇÃO DA FUNÇÃO ORIGINAL (Única coisa que você muda!)
# ====================================================================
# Declaramos que x e y são variáveis matemáticas (símbolos)
x, y = sp.symbols('x y')

# Escreva a sua função aqui usando x e y
f_simbolica = 3*x**4 + 2*x*y - 2*y**4 + x - y

# ====================================================================
# PASSO 2: PARÂMETROS INICIAIS DA QUESTÃO
# ====================================================================
x0 = -1.0
y0 = 1.0
tolerancia = 1e-8
max_iteracoes = 100

# ====================================================================
# PASSO 3: O CÉREBRO MATEMÁTICO (Calcula derivadas sozinho)
# ====================================================================
print("Calculando derivadas automaticamente com SymPy...")

# Calcula o Gradiente (Derivadas de 1ª ordem)
grad_simbolico = [sp.diff(f_simbolica, var) for var in (x, y)]

# Calcula a Hessiana (Derivadas de 2ª ordem)
hess_simbolica = [[sp.diff(grad_simbolico[i], var) for var in (x, y)] for i in range(2)]

# Converte as expressões matemáticas em funções rápidas que o NumPy consegue usar
f_num = sp.lambdify((x, y), f_simbolica, 'numpy')
grad_num = sp.lambdify((x, y), grad_simbolico, 'numpy')
hess_num = sp.lambdify((x, y), hess_simbolica, 'numpy')

# ====================================================================
# PASSO 4: ALGORITMO DO MÉTODO DE NEWTON 
# ====================================================================
def newton_minimo(x_val, y_val, tol, max_iter):
    for k in range(max_iter):
        g = np.array(grad_num(x_val, y_val))
        H = np.array(hess_num(x_val, y_val))
        
        # Resolve o sistema H * delta = gradiente
        delta = np.linalg.inv(H).dot(g)
        
        # Atualiza os pontos
        x_val = x_val - delta[0]
        y_val = y_val - delta[1]
        
        # Critério de parada
        if np.linalg.norm(delta) < tol:
            return x_val, y_val, k + 1
            
    print("Aviso: Não convergiu!")
    return x_val, y_val, max_iter

# ====================================================================
# PASSO 5: EXECUÇÃO
# ====================================================================
x_min, y_min, iteracoes = newton_minimo(x0, y0, tolerancia, max_iteracoes)
f_min = f_num(x_min, y_min) 

print("\n--- RESULTADO FINAL ---")
print(f"Ponto de mínimo aproximado: x = {x_min:.10f}, y = {y_min:.10f}")
print(f"Valor da função no mínimo:  f(x,y) = {f_min:.10f}")
print(f"Iterações necessárias:      {iteracoes}")