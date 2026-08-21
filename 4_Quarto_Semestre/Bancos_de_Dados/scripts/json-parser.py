import os
import json
# pyrefly: ignore [missing-import]
import ijson
from datetime import datetime


# Determina o diretório base do script (pasta scripts)
diretorio_script = os.path.dirname(os.path.abspath(__file__))

# Define o caminho do arquivo de entrada de forma absoluta
caminho_arquivo = os.path.join(diretorio_script, "data", "raw", "games.json")

# Abre o arquivo JSON em modo leitura ("r") especificando a codificação UTF-8
with open(caminho_arquivo, "r", encoding="utf-8") as file:

    # ijson.kvitems lê o dicionário principal par por par (chave, valor)
    jogos = ijson.kvitems(file, "")
    
    # Lista para armazenar apenas os jogos que passaram em todos os filtros
    jogos_filtrados = []

    for app_id, jogo in jogos:

        # 1. Extração de todos os campos necessários
        price = jogo.get("price")
        name = jogo.get("name")
        release_date = jogo.get("release_date")
        short_description = jogo.get("short_description")
        genres_list = jogo.get("genres", [])
        screenshots_list = jogo.get("screenshots", [])
        negative = jogo.get("negative")
        positive = jogo.get("positive")
        average_playtime_forever = jogo.get("average_playtime_forever")
        estimated_owners = jogo.get("estimated_owners")
        developers_list = jogo.get("developers", [])

        # 2. Validações (Fail Fast)
        if price is None or price < 9.99:
            continue

        if not name:
            continue

        if positive == 0:
            continue

        if negative == 0:
            continue
            
        # Verifica se o nome está em letra ocidental
        try:
            name.encode('cp1252')
        except UnicodeEncodeError:
            continue

        # Verifica quantidade de screenshots e gêneros``
        if len(screenshots_list) < 3:
            continue
            
        if len(genres_list) < 2:
            continue

        # Em Python, usamos "not lista" para verificar se está vazia (listas não possuem o atributo .empty)
        if not developers_list:
            continue

        # Formatação e validação da data de lançamento (PostgreSQL espera YYYY-MM-DD)
        if not release_date:
            continue
        try:
            # Converte de "Nov 8, 2021" (formato da Steam) para objeto datetime
            data_obj = datetime.strptime(release_date, "%b %d, %Y")
            # Converte o objeto de volta para string no formato correto do DB
            release_date = data_obj.strftime("%Y-%m-%d")
        except ValueError:
            # Se a data vier num formato estranho ou vazio, falha rápido
            continue

        # Verifica se há descrição curta (short_description não deve ser vazio ou nulo)
        if not short_description:
            continue

        # 3. Construção do Objeto
        jogo_valido = {
            "app_id": app_id,
            "name": name,
            "price": price,
            "release_date": release_date,
            "short_description": short_description,
            "tags": genres_list,
            "screenshots": screenshots_list[:3],  # Pega exatamente os primeiros 3 URLs
            "negative": negative,
            "positive": positive,
            "average_playtime": average_playtime_forever,
            "estimated_owners": estimated_owners,
            "developers": developers_list,
        }
        
        # Adiciona o objeto estruturado à lista de jogos válidos
        jogos_filtrados.append(jogo_valido)

# Ao final do laço, a lista conterá todos os jogos prontos para inserção
print(f"Leitura concluída! Total de jogos válidos para o DB: {len(jogos_filtrados)}")

# Define o caminho de saída de forma absoluta
pasta_saida = os.path.join(diretorio_script, "data", "processed")
os.makedirs(pasta_saida, exist_ok=True)  # Garante que a pasta existe
caminho_saida = os.path.join(pasta_saida, "jogos_filtrados.json")

with open(caminho_saida, "w", encoding="utf-8") as file_out:
    # default=float garante que números do tipo Decimal sejam convertidos para float
    json.dump(jogos_filtrados, file_out, ensure_ascii=False, indent=4, default=float)

print(f"Salvo com sucesso em {caminho_saida}!")
