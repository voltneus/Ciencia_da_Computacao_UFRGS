from readfile import load_movie_csv, load_ratings_csv, load_tags_csv
from hashfile import *
from triefile import Trie
from ratinghashfile import *
from tagshashfile import *

import time

import os

current_dir = os.path.dirname(os.path.abspath(__file__))

# GLOBAL VARIABLES
moviefilename = os.path.join(current_dir, "..", "dados-trabalho", "movies.csv")
miniratingsfilename = os.path.join(current_dir, "..", "dados-trabalho", "miniratings.csv")
ratingsfilename = os.path.join(current_dir, "..", "dados-trabalho", "ratings.csv")
tagsfilename = os.path.join(current_dir, "..", "dados-trabalho", "tags.csv")
M = 35437 
moviehashtable = [[] for _ in range(M)]

trie = Trie()

M2 = 179999 
ratingshashtable = [[] for _ in range(M2)]

tagshashtable = [[] for _ in range(M)]

movielist = []
miniratingslist = []
ratingslist = []
tagslist = []


def nada():
   return None

# --- FILE READING FUNCTIONS ---
#extracting each file information

def FileReadigs():

  global movielist, ratingslist, tagslist

  start_time = time.time()

  movielist = load_movie_csv(moviefilename)

  #print(len(movielist))

  ratingslist = load_ratings_csv(ratingsfilename)

  #print(len(miniratingslist))

  tagslist = load_tags_csv(tagsfilename)

  #print(len(tagslist))

  end_time = time.time()

  total_time = end_time - start_time
  
  return total_time



# --- MOVIE HASH TABLE ---
#initialising the hashtable and storing movies and ratings in it


def MovieHashBuild():

  start_time = time.time()

  for movie in movielist:
    if(InsertMovieinHash(moviehashtable, movie) == 1):
      print("there was an error in inserting the movies")

  #miniratings list used for testing
  for rating in ratingslist:
    InsertRatinginHash(moviehashtable, rating) == 1

  CalculateAllAverageRatings(moviehashtable)
      

  end_time = time.time()

  total_time = end_time - start_time
  
  return total_time


# --- MOVIE TRIE ---
# initializing the trie

def MovieTrieBuild():

  start_time = time.time()

  for movie in movielist:
    trie.insertTrie(movie)

  end_time = time.time()

  total_time = end_time - start_time
  
  return total_time

# --- RATING HASH TABLE ---
# initializing the hash

def RatingHashBuild():

  start_time = time.time()

  for rating in ratingslist:
    InsertRatinginRatingHash(ratingshashtable, rating)

  end_time = time.time()

  total_time = end_time - start_time
  
  return total_time

# --- TAGS HASH TABLE ---
# initializing the hash

def TagsHashBuild():

  start_time = time.time()

  for tag in tagslist:
    InsertinTagsHash(tagshashtable, tag)

  end_time = time.time()

  total_time = end_time - start_time
  
  return total_time


# -- FUNÇÃO QUE PROCURA DE UM FILME POR MEIO DO id -- 

def PrintMoviewithid(id):
  movie, movieratings = SearchinHash(moviehashtable, id)

  if (movie == None):
    print("movie not found")
  else:
    print(movie)

  return movie, movieratings

def Moviewithid(id):
  return SearchinHash(moviehashtable, id)


# -- FUNÇÃO QUE PROCURA DE UM FILME POR MEIO DE PREFIXO -- 

def PrintMovieswithPrefix(string):

  movieids = Trie.searchTrie(trie, string)

  movie_list = []
  ratings_list = []

  for id in movieids:
    movie, ratings = Moviewithid(id)
    movie_list.append(movie)
    ratings_list.append(ratings)


  if(len(movie_list) < 1):
    print("sem filmes com esse prefixo")

  for movie in movie_list:
    print(movie)

  return movie_list, ratings_list

def MovieswithPrefix(string):

  movieids = Trie.searchTrie(trie, string)

  movie_list = []
  ratings_list = []

  for id in movieids:
    movie, ratings = Moviewithid(id)
    movie_list.append(movie)
    ratings_list.append(ratings)

  return movie_list, ratings_list

def Ratingwithid(userid):
  return SearchinRatingHash(ratingshashtable, userid)

def TagswithTag(string):
  return SearchinTagHash(tagshashtable, string)

def MoviewithTag(string):
  hashnode = SearchinTagHash(tagshashtable, string)

  movies = []

  for tag in hashnode.tags:
    movie, rating = Moviewithid(tag.movieId)
    if(movie not in movies):
      movies.append(movie)

  return movies

def ExtractTerms(query_str):

    if "'" not in query_str:
        return []

    #split (corta em "'")
    partes_raw = query_str.split("'")

    #remove espaços vazios criados por split
    termos_limpos = [p.strip() for p in partes_raw if p.strip()]

    return termos_limpos

def GetMovieHashNode(id_filme):

    idx = id_filme % M
    # Acesso direto à lista do bucket
    if idx < len(moviehashtable):
        bucket = moviehashtable[idx]
        for node in bucket:
            if node.id == id_filme:
                return node
    return None


def Pesquisa1(prefixo):

    if not prefixo: return []

    movie_ids = Trie.searchTrie(trie, prefixo)

    resultado = []
    for mid in movie_ids:
        node = GetMovieHashNode(mid)
        if node:
            resultado.append((
                node.id,
                node.Movie.title,
                node.Movie.genres,
                node.Movie.year,
                f"{node.aveRating:.6f}",
                node.numberRatings
            ))

    #sort decrescente
    resultado = merge_sort(resultado, key=lambda x: float(x[4]), reverse=True)
    return resultado


def Pesquisa2(user_id_str):

    try:
        uid = int(user_id_str)
    except ValueError:
        return []

    # 1. Busca o nó do usuário
    user_node = Ratingwithid(uid)  # Retorna HashRatingNode
    if not user_node: return []

    resultado = []
    # user_node.ratings é uma lista de objetos Ratings (tem userId, movieId, rating, date)

    # [cite_start]Limite de 20 filmes
    for avaliacao in user_node.ratings:
        node = GetMovieHashNode(avaliacao.movieId)
        if node:
            resultado.append((
                node.id,
                node.Movie.title,
                node.Movie.genres,
                node.Movie.year,
                f"{node.aveRating:.6f}",
                node.numberRatings,
                f"{avaliacao.rating:.1f}"  # Nota do usuário
            ))

    # Ordenação: 1º Nota do Usuário (desc), 2º Nota Global (desc)
    # x[6] é a nota do usuário, x[4] é a nota global
    resultado = merge_sort(resultado, key=lambda x: (float(x[6]), float(x[4])), reverse=True)

    return resultado[:20]  # Retorna no máximo 20


def Pesquisa3(query_str):
    #ACEITA APENAS formato: 20 'Nome Genero' (com aspas).

    partes = ExtractTerms(query_str)

    #deve sobrar apenas numero e genero
    if len(partes) < 2:
        return []

    try:
        str_n = partes[0]
        genero_raw = partes[1]
        n = int(str_n)
        genero = genero_raw.lower()
    except ValueError:
        return []

    candidatos = []
    minimo_avaliacoes = 1000

    for bucket in moviehashtable:
        for node in bucket:
            if node.Movie.genres:
                if (genero in node.Movie.genres.lower()) and (node.numberRatings >= minimo_avaliacoes):
                    candidatos.append(node)

    candidatos = merge_sort(candidatos, key=lambda x: x.aveRating, reverse=True)

    top_n = candidatos[:n]

    resultado = []
    for node in top_n:
        resultado.append((
            node.id,
            node.Movie.title,
            node.Movie.genres,
            node.Movie.year,
            f"{node.aveRating:.6f}",
            node.numberRatings
        ))

    return resultado


def Pesquisa4(query_str):

    #ACEITA APENAS formato: 'tag1' 'tag2' (com aspas).
    tags = ExtractTerms(query_str)

    if len(tags) < 2:
        return []

    tag1, tag2 = tags[0], tags[1]

    node1 = SearchinTagHash(tagshashtable, tag1)
    node2 = SearchinTagHash(tagshashtable, tag2)

    if not node1 or not node2: return []

    ids1 = {t.movieId for t in node1.tags}
    ids2 = {t.movieId for t in node2.tags}
    interseccao = ids1.intersection(ids2)

    filmes = []
    for mid in interseccao:
        node = GetMovieHashNode(mid)
        if node:
            filmes.append(node)

    filmes = merge_sort(filmes, key=lambda x: x.aveRating, reverse=True)

    resultado = []
    for node in filmes:
        resultado.append((
            node.id,
            node.Movie.title,
            node.Movie.genres,
            node.Movie.year,
            f"{node.aveRating:.6f}",
            node.numberRatings
        ))

    return resultado

def merge_sort(lista, key=lambda x: x, reverse=False):

    #retorna lista nova ordenada, mantendo estabilidade

    if len(lista) <= 1:
        return lista

    mid = len(lista) // 2

    left = merge_sort(lista[:mid], key=key, reverse=reverse)
    right = merge_sort(lista[mid:], key=key, reverse=reverse)

    sorted_list = []
    i = 0
    j = 0
    len_left = len(left)
    len_right = len(right)

    while i < len_left and j < len_right:
        val_left = key(left[i])
        val_right = key(right[j])

        if reverse:
            #decrescente
            condition = val_left >= val_right
        else:
            #crescente
            condition = val_left <= val_right

        if condition:
            sorted_list.append(left[i])
            i += 1
        else:
            sorted_list.append(right[j])
            j += 1

    sorted_list.extend(left[i:])
    sorted_list.extend(right[j:])

    return sorted_list