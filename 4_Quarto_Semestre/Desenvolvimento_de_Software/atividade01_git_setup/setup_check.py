import sys
import platform

def verificar_ambiente():
    # TODO: Preencha seu nome completo na variável abaixo
    nome_aluno = "Vítor Santana Feijó"
    
    # TODO: Use a biblioteca 'platform' ou 'sys' para capturar a versão do Python
    versao_python = platform.python_version() 

    print(f"Relatório de: {nome_aluno}")
    print(f"Sistema Operacional: {platform.system()}")
    print(f"Versão do Python: {versao_python}")

    if nome_aluno == "":
        print("ERRO: Você esqueceu de preencher seu nome!")
        sys.exit(1)  # Isso faz o GitHub Actions mostrar o X vermelho
    else:
        print("Sucesso!")
        sys.exit(0)  # Isso faz o GitHub Actions mostrar o check verde

if __name__ == "__main__":
    verificar_ambiente()
