import unicodedata

#arquivo com os tipos usados no projeto
class Movie:
#movieId,title,genres,year
  __slots__ = ['movieId', 'title', 'genres', 'year']
  def __init__(self, movieId, title, genres, year):
    self.movieId = movieId
    self.title = title
    self.genres = genres
    self.year = year


  def __repr__(self):
    return f"Movie({self.movieId}, '{self.title}', '{self.genres}', {self.year})"

class Ratings:
#userId,movieId,rating,date
  __slots__ = ['userId', 'movieId', 'rating', 'date']
  def __init__(self, userId, movieId, rating, date):
    self.userId = userId
    self.movieId = movieId
    self.rating = rating
    self.date = date

  def __repr__(self):
    return f"Rating({self.userId}, '{self.movieId}', '{self.rating}', {self.date})"

class Tags:
#userId,movieId,tag,timestamp
  __slots__ = ['userId', 'movieId', 'tag', 'timestamp']
  def __init__(self, userId, movieId, tag, timestamp):
    self.userId = userId
    self.movieId = movieId
    self.tag = tag
    self.timestamp = timestamp

  def __repr__(self):
    return f"Tags({self.userId}, '{self.movieId}', '{self.tag}', {self.timestamp})"

class HashNode:

  def __init__(self, Movie):
    self.id = Movie.movieId
    self.Movie = Movie
    self.ratings = []
    self.numberRatings = 0
    self.aveRating = 0

  def __repr__(self):
    return f"MovieHashNode({self.Movie} / ave:'{self.aveRating}')"
  
class TrieNode:

  def __init__(self, char = ' '):
    self.caracter = char
    self.ids = [] #for films with the same title
    self.children = {}

  def __repr__(self):
    return f"TrieNode(char:'{self.char}', is_word:{self.is_word}, children:{list(self.children.keys())})"
  

class HashRatingNode:

  def __init__(self, rating):
    self.userId = rating.userId
    self.ratings = []

  def __repr__(self):
    return f"HashratingNode({self.userId} / number of reviews:'{len(self.ratings)}')"


class HashTagsNode:

  def __init__(self, Tag):
    self.tag = NormalizeText(Tag.tag)
    self.tags = []

  def __repr__(self):
    return f"HashTagsNode({self.tag} / number of movies with this tag:'{len(self.tags)}')"


def NormalizeText(text):
  #Remove accents 
  nfkd_form = unicodedata.normalize('NFD', text)
  text = nfkd_form.encode('ascii', 'ignore').decode('utf-8')
  
  #Converts to Uppercase 
  text = text.upper() 

  return text
