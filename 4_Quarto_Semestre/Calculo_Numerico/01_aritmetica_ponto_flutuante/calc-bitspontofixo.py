import math

def bits_parte_inteira(valor):

    """
    Calcula o número de bits necessários para representar a parte inteira de um número.
    """

    inteiro = math.ceil(math.log2(valor))

    return inteiro

def bits_parte_fracionaria(valor):

    """
    Calcula o número de bits necessários para representar a parte fracionária de um número.
    """

    fracionaria = math.ceil(abs(math.log2(valor)))

    return fracionaria

inteiro = int(input("Digite a parte inteira do número: "))
fracionaria = float(input("Digite a parte fracionária do número: "))

bits_inteiro = bits_parte_inteira(inteiro)
bits_fracionaria = bits_parte_fracionaria(fracionaria)

print(f"Bits necessários para a parte inteira: {bits_inteiro}")
print(f"Bits necessários para a parte fracionária: {bits_fracionaria}")