def ctes_ponto_flutuante(E, M):
    """
    Calcula as constantes de um sistema de representação em ponto-flutuante.
    Assumindo base 2 por padrão.
    """
    
    # Precisão (p)
    p = M + 1
    
    # Maior e Menor Expoentes (MAXE e MINE)
    maxe = (2 ** E) - 1
    mine = -maxe
    
    # Menor número representável positivo (MINR)
    minr = 0.5 * (2 ** mine)
    
    # Maior número representável (MAXR)
    maxr = (1 - (2 ** -p)) * (2 ** maxe)
    
    # Épsilon da máquina (ε)
    epsilon_corte = 2 ** (-p + 1)
    epsilon_adicao = 2 ** -p

    # ULP (Unidade de Menor Precisão)
    ulp = 2 ** -p * 2 ** E
    
    return p, mine, maxe, minr, maxr, epsilon_corte, epsilon_adicao, ulp

def ctes_ieee754(E, M):
    """
    Calcula as constantes do padrão IEEE 754 (números normalizados).
    """
    p = M + 1
    bias = (2 ** (E - 1)) - 1
    mine = 1 - bias
    maxe = bias
    minr = 1.0 * (2 ** mine)
    maxr = (2 - (2 ** -M)) * (2 ** maxe)
    
    # No IEEE 754, o epsilon clássico é 2^-M
    epsilon = 2 ** -M
    
    return p, mine, maxe, minr, maxr, epsilon, bias


# F(base, mantissa, expoente), faz o cálculo considerando que o expoente não inclui o bit de sinal.

print("--- Calculadora de Ponto-Flutuante ---")
print("1 - Formato Personalizado (Sinal-e-magnitude)")
print("2 - Formato IEEE 754")
menu = input("Escolha o formato desejado (1 ou 2): ")

if menu == '1':
    print("\n--- Formato Personalizado ---")
    bits_E = int(input("Digite a quantidade de bits no expoente (|E|): "))
    bits_M = int(input("Digite a quantidade de bits na mantissa (|M|): "))

    p, mine, maxe, minr, maxr, eps_corte, eps_adicao, ulp = ctes_ponto_flutuante(bits_E, bits_M)

    print("\n--- Constantes de Ponto-Flutuante ---")
    print(f"Precisão (p): {p}")
    print(f"MINE: {mine}")
    print(f"MAXE: {maxe}")
    print(f"MINR: {minr}")
    print(f"MAXR: {maxr}")
    print(f"Épsilon (ε) por corte: {eps_corte}")
    print(f"Épsilon (ε) por adição: {eps_adicao}")
    print(f"ULP: {ulp}")

elif menu == '2':
    print("\n--- Formato IEEE 754 ---")
    bits_E = int(input("Digite a quantidade de bits no expoente (E): "))
    bits_M = int(input("Digite a quantidade de bits na mantissa/fração (M): "))
    
    p, mine, maxe, minr, maxr, epsilon, bias = ctes_ieee754(bits_E, bits_M)
    
    print("\n--- Constantes IEEE 754 ---")
    print(f"Viés (Bias): {bias}")
    print(f"Precisão (p): {p}")
    print(f"MINE: {mine}")
    print(f"MAXE: {maxe}")
    print(f"MINR (Normalizado): {minr:.10e}")
    print(f"MAXR: {maxr:.10e}")
    print(f"Épsilon da Máquina: {epsilon:.10e}")

else:
    print("\nOpção inválida. Por favor, reinicie o programa e digite 1 ou 2.")