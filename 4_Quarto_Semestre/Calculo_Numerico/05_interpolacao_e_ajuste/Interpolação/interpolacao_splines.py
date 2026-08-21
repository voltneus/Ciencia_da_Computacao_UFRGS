import numpy as np
from scipy.interpolate import CubicSpline

# ====================================================================
# PASSO 1: CONFIGURAÇÃO DOS DADOS DA QUESTÃO
# ====================================================================
a = 0.0
b = np.pi / 2

dados_entradas = np.linspace(a, b, 5)
dados_saidas   = np.cos(dados_entradas)

# Ponto que você deseja estimar/descobrir
ponto_desejado = np.pi / 3

# Valor exato fornecido pelo enunciado para o cálculo do erro
valor_exato = np.cos(ponto_desejado)  

# Quantidade de casas decimais para o arredondamento por corte
casas_decimais = 6

# ====================================================================
# PASSO 2: CONDIÇÃO DE CONTORNO (O segredo da questão!)
# ====================================================================
# Opções: 
#   'natural'  -> Segundas derivadas nulas nas pontas.
#   'clampada' -> Primeiras derivadas especificadas à mão nas pontas. -----> TEM QUE CALCULAR A DERIVADA NA MÃO
tipo_spline = 'clampada'

if tipo_spline == 'natural':
    condicao_contorno = 'natural'
else:
    # Derivada de cos(x) é -sin(x). 
    # Calculamos o valor exato da derivada em 'a' e em 'b' -----------> TROCAR AQUI
    dy_da = -np.sin(a)  # -sin(0) = 0.0
    dy_db = -np.sin(b)  # -sin(pi/2) = -1.0
    
    # Formato do SciPy: ( (ordem_da_derivada, valor_em_a), (ordem_da_derivada, valor_em_b) )
    condicao_contorno = ((1, dy_da), (1, dy_db))

# ====================================================================
# PASSO 3: EXECUÇÃO E EXIBIÇÃO (Não precisa mexer)
# ====================================================================
cs = CubicSpline(dados_entradas, dados_saidas, bc_type=condicao_contorno)
resultado_aproximado = float(cs(ponto_desejado))

print(f"--- RESULTADOS DA INTERPOLAÇÃO POR SPLINE ({tipo_spline.upper()}) ---")
print(f"Valor aproximado no ponto desejado: {resultado_aproximado:.10f}")

if valor_exato is not None:
    erro_relativo = abs(valor_exato - resultado_aproximado) / abs(valor_exato)
    
    # Aplica o truncamento por corte puro
    fator = 10**casas_decimais
    erro_cortado = int(erro_relativo * fator) / fator
    
    print(f"\n--- CÁLCULO DE ERRO ---")
    print(f"Valor Exato de Referência: {valor_exato:.10f}")
    print(f"Erro relativo bruto: {erro_relativo}")
    print(f"Erro relativo final (corte {casas_decimais} casas): {erro_cortado:.{casas_decimais}f}")