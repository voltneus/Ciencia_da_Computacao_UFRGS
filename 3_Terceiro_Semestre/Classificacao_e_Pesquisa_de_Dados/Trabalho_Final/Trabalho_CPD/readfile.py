import pandas as pd
from typefile import Movie, Ratings, Tags

def load_movie_csv(nome_arquivo: str):
  # Reads the csv file and moves it to a dataframe
  df = pd.read_csv(nome_arquivo, encoding='utf-8')
    
  # creates list with zip(faster than iterows)
  return [
    Movie(mid, title, genres, year) 
    for mid, title, genres, year 
    in zip(df['movieId'], df['title'], df['genres'], df['year'])
  ]

def load_ratings_csv(nome_arquivo: str):
  df = pd.read_csv(nome_arquivo, encoding='utf-8')

  # creates list with zip(faster than iterows)
  return [
    Ratings(uid, mid, rating, date)
    for uid, mid, rating, date
    in zip(df['userId'], df['movieId'], df['rating'], df['date'])
  ]

def load_tags_csv(nome_arquivo: str):
  df = pd.read_csv(nome_arquivo, encoding='utf-8')

  # creates list with zip(faster than iterows)
  return [
    Tags(uid, mid, tag, timestamp)
    for uid, mid, tag, timestamp
    in zip(df['userId'], df['movieId'], df['tag'], df['timestamp'])
  ]