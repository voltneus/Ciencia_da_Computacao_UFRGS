import numpy as np
import scipy.integrate as integrate
import matplotlib.pyplot as plt

# ====================================================================
# PASSO 1: DEFINIÇÃO DA FUNÇÃO E INTERVALO
# ====================================================================
# Edite a função f(x) conforme a questão.
def f(x):
    return np.exp(-2*x) + 4

# Edite a integral exata se a questão fornecer (usado para calcular o erro).
# Se não tiver, comentar a função integral_exata e erro relativo.
def integral_exata(x):
    return 4*x - np.exp(-2*x)/2

a = 0
b = 5

# ====================================================================
# PASSO 2: CÁLCULO DO VALOR EXATO (Referência)
# ====================================================================
exata = integral_exata(b) - integral_exata(a)
print(f"--- VALOR REFERÊNCIA ---")
print(f"Integral Exata = {exata}\n")

# ====================================================================
# PASSO 3: TESTE DE TOLERÂNCIA (Achar o menor 'n' para um erro)
# ====================================================================
print("--- BUSCA DE 'N' PARA TOLERÂNCIA ESPECÍFICA (Simpson) ---")
n_teste = 4 
tolerancia = 1e-8

while True:
    x_teste = np.linspace(a, b, n_teste)
    y_teste = f(x_teste)
    
    sc_teste = integrate.simpson(y_teste, x_teste)
    erro_teste = abs(exata - sc_teste) / abs(exata)
    
    # 1. SE O ERRO JÁ FOR MENOR, PARA IMEDIATAMENTE E MOSTRA O 'N' ATUAL
    if erro_teste < tolerancia:
        print(f"SUCESSO! O menor número de nós é: {n_teste} (Erro: {erro_teste:.10e})\n")
        break
        
    # 2. TRAVA DE SEGURANÇA
    if n_teste > 100000:
        print("Limite de tentativas excedido.")
        break
        
    # 3. SÓ MULTIPLICA DEPOIS QUE O 'N' ATUAL FALHOU NO TESTE DO IF
    n_teste = n_teste * 2

# ====================================================================
# PASSO 4: CÁLCULO DIRETO COM TODOS OS MÉTODOS (Para outras questões)
# ====================================================================
print("--- RESULTADOS COM MÉTODOS TRADICIONAIS ---")

# 1. TRAPÉZIO (Simples)
x_ts = np.array([a, b])
t_simples = integrate.trapezoid(f(x_ts), x_ts)
print(f"Trapézio Simples:   {t_simples} | Erro rel: {abs(exata-t_simples)/abs(exata):.4e}")

# 2. TRAPÉZIO (Composto - Exemplo com 4 nós)
n_nos = 4
x_tc = np.linspace(a, b, n_nos)
t_comp = integrate.trapezoid(f(x_tc), x_tc)
print(f"Trapézio Composto:  {t_comp} | Erro rel: {abs(exata-t_comp)/abs(exata):.4e}")

# 3. SIMPSON (Simples)
x_ss = np.array([a, (a+b)/2, b])
s_simples = integrate.simpson(f(x_ss), x_ss)
print(f"Simpson Simples:    {s_simples} | Erro rel: {abs(exata-s_simples)/abs(exata):.4e}")

# 4. SIMPSON (Composto - Onde você escolhe o número de nós)
# ATENÇÃO: Para a regra de Simpson, o número de nós DEVE ser ÍMPAR (ex: 3, 5, 7, 9, 21...)
n_nos_s = 5  # <--- Altere aqui o número de nós que a questão pedir!
x_sc = np.linspace(a, b, n_nos_s)
y_sc = f(x_sc)
s_composto = integrate.simpson(y_sc, x_sc)
print(f"Simpson Composto ({n_nos_s} nós): {s_composto}")

# 4. ROMBERG
# Romberg precisa que o número de intervalos seja 2^k. Para nós = 2^k + 1
k = 4
m = (2**k) + 1
h = (b-a)/(m-1)
x_romb = np.linspace(a, b, m)
r = integrate.romb(f(x_romb), dx=h)
print(f"Romberg (k={k}):      {r} | Erro rel: {abs(exata-r)/abs(exata):.4e}")

# 5. QUADRATURA GAUSSIANA (N=4, N=16)
q4, _ = integrate.fixed_quad(f, a, b, n=4)
print(f"Quad. Gauss (N=4):  {q4} | Erro rel: {abs(exata-q4)/abs(exata):.4e}")

q16, _ = integrate.fixed_quad(f, a, b, n=16)
print(f"Quad. Gauss (N=16): {q16} | Erro rel: {abs(exata-q16)/abs(exata):.4e}")


# ====================================================================
# PASSO 5: GRÁFICO (Opcional - Descomente se quiser visualizar)
# ====================================================================
# x_plot = np.linspace(a, b, 100)
# plt.plot(x_plot, f(x_plot), 'b-', label='f(x)')
# plt.fill_between(x_plot, f(x_plot), alpha=0.2, color='blue', label='Área da Integral')
# plt.grid()
# plt.legend()
# plt.show()