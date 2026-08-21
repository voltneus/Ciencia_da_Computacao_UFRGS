def ctes_ponto_fixo(E, D):
    """
    Calcula as constantes de um sistema de representação em ponto-fixo.
    
    Parâmetros:
    E (int): Número de bits da parte inteira (|E|)
    D (int): Número de bits da parte fracionária (|D|)
    """
    
    # Precisão (p)
    p = E + D
    
    # Menor número representável positivo (MINR)
    minr = 2 ** -D
    
    # Maior número representável (MAXR)
    maxr = (2 ** E - 1) + (1 - 2 ** -D)
    
    # Separação entre dois números representáveis consecutivos (ULP)
    ulp = 2 ** -D
    
    # Em ponto fixo, o epsilon é igual ao ULP
    epsilon = ulp
    
    return p, minr, maxr, ulp, epsilon

bits_E = int(input("Digite o número de bits da parte inteira (|E|): "))
bits_D = int(input("Digite o número de bits da parte fracionária (|D|): "))

p, minr, maxr, ulp, epsilon = ctes_ponto_fixo(bits_E, bits_D)

print("\n--- Constantes de Ponto-Fixo ---")
print(f"Precisão (p): {p}")
print(f"MINR: {minr}")
print(f"MAXR: {maxr}")
print(f"ULP:  {ulp}")
print(f"Épsilon (ε): {epsilon}")