import numpy as np
from scipy.optimize import curve_fit

# ====================================================================
# PASSO 1: DADOS DA QUESTÃO
# ====================================================================
# [Exemplo configurado: Questão de 2019 da Exxon]
X = np.array([1980, 2000, 2020, 2040])
Y = np.array([0.000, 0.475, 0.950, 1.495])
#X = np.array([-70, -60, -50, -40, -30, -20, -10, 0, 10, 20, 30, 100]) 
#Y = np.array([289.0999, 295.0, 300.8999, 306.7999, 312.6999, 318.5999, 
#              324.5, 330.3999, 336.2999, 342.1999, 348.0999, 383.3999])

# Ponto final que a questão pede para prever/estimar
x_prever = 2050

# Configurações de Erro e Validação
y_exato_tabelado = None  # Use apenas se souber o valor exato no ponto 'x_prever'

# Dados de um ponto intermediário de validação (ex: o ano de 2019 onde y = 0.9)
# Deixe como 'None' se a questão NÃO pedir para avaliar por um ponto específico
x_valida = 2019
y_valida_real = 0.9

# ====================================================================
# PASSO 2: CONFIGURAÇÃO DE CRITÉRIO E ARREDONDAMENTO
# ====================================================================
# Critério de escolha do modelo. Opções:
#   'rmq'       -> Escolhe o modelo com menor Resíduo Médio Quadrático global
#   'validacao' -> Escolhe o modelo com menor Erro Relativo no ponto 'x_valida'
criterio_selecao = 'validacao' 

# Tipo de arredondamento final. Opções:
#   'corte'   -> Truncamento puro (ignora as próximas casas)
#   'adicao'  -> Arredondamento matemático padrão (round)
tipo_arredondamento = 'adicao'

# Quantidade de casas decimais exigida na resposta
casas_decimais = 4

# ====================================================================
# PASSO 3: FUNÇÕES MATEMÁTICAS (Não precisa mexer)
# ====================================================================
def linear(x, a0, a1): return a0 + a1*x
def quadratica(x, a0, a1, a2): return a0 + a1*x + a2*x**2
def cubica(x, a0, a1, a2, a3): return a0 + a1*x + a2*x**2 + a3*x**3
def quartica(x, a0, a1, a2, a3, a4): return a0 + a1*x + a2*x**2 + a3*x**3 + a4*x**4

def calcular_rmq(y_real, y_previsto):
    return np.sqrt(np.mean((y_real - y_previsto)**2))

# ====================================================================
# PASSO 4: PROCESSAMENTO AUTOMÁTICO DE TODOS OS MODELOS
# ====================================================================
resultados = {}

# Lista de modelos polinomiais a testar (grau depende do número de pontos disponíveis)
graus_disponiveis = [('linear', linear, 2), ('quadratica', quadratica, 3), 
                     ('cubica', cubica, 4), ('quartica', quartica, 5)]

for nome, func, coef_req in graus_disponiveis:
    if len(X) >= coef_req:  # Só testa se houver pontos suficientes na tabela
        try:
            p, _ = curve_fit(func, X, Y)
            y_ajustado = func(X, *p)
            rmq = calcular_rmq(Y, y_ajustado)
            
            # Predições
            pred_valida = func(x_valida, *p) if x_valida is not None else None
            pred_final = func(x_prever, *p)
            
            # Erro no ponto de validação intermediário (se configurado)
            erro_val = abs(y_valida_real - pred_valida) / abs(y_valida_real) if x_valida is not None else np.inf
            
            resultados[nome] = {'rmq': rmq, 'erro_valida': erro_val, 'pred_2050': pred_final}
        except: pass

# ====================================================================
# PASSO 5: SELEÇÃO E EXIBIÇÃO DE RESULTADOS
# ====================================================================
# Define qual modelo venceu de acordo com o critério escolhido
if criterio_selecao == 'rmq':
    modelo_vencedor = min(resultados, key=lambda m: resultados[m]['rmq'])
else:
    modelo_vencedor = min(resultados, key=lambda m: resultados[m]['erro_valida'])

print(f"--- RELATÓRIO DE MODELOS TESTADOS ---")
for m in resultados:
    print(f"Mod. {m.upper()}: RMQ Global = {resultados[m]['rmq']:.6f} | Erro no ponto de validação = {resultados[m]['erro_valida']:.6f}")

print(f"\n--> MODELO ESCOLHIDO: {modelo_vencedor.upper()}")
resultado_bruto = resultados[modelo_vencedor]['pred_2050']
print(f"Valor bruto previsto para x = {x_prever}: {resultado_bruto}")

# Aplicação do arredondamento configurado
if tipo_arredondamento == 'corte':
    fator = 10**casas_decimais
    resultado_final = int(resultado_bruto * fator) / fator
else:
    resultado_final = round(resultado_bruto, casas_decimais)

print(f"Resposta final para o Moodle ({casas_decimais} casas por {tipo_arredondamento}): {resultado_final:.{casas_decimais}f}")

# Erro relativo final (se houver valor de gabarito para o ponto projetado)
if y_exato_tabelado is not None:
    err_rel = abs(y_exato_tabelado - resultado_bruto) / abs(y_exato_tabelado)
    if tipo_arredondamento == 'corte':
        err_rel_final = int(err_rel * (10**casas_decimais)) / (10**casas_decimais)
    else:
        err_rel_final = round(err_rel, casas_decimais)
    print(f"Erro relativo da previsão: {err_rel_final:.{casas_decimais}f}")