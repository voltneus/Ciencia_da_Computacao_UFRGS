
from typefile import Movie, Ratings, Tags, HashNode


M = 35437

# This funtion receives an id and a the hash constant(M) and returns the hash value
def HashValue(id): 
  return id % M


#This funtion recieves an hashtable, an movieId(to consult), and the hash constant(M)
# and returns the number of values in the hash node(if its zero the hash node is empty)
def HashNodeSize(hashtable, id):
  hash = HashValue(id)

  return len(hashtable[hash])

def HashNodeSizewithHash(hashtable, id, hash):
  return len(hashtable[hash])


#This funtion recieves an hashtable, an movieId(to consult), and the hash constant(M)
# and returns 0 if there's and movie with the id given and 1 if not
def ConsultinHash(hashtable, id):
  hash = HashValue(id)
  #if the node is empty, there is no chance of the movie being there
  if (HashNodeSizewithHash(hashtable, id, hash) == 0):
    return 1
  
  for movie in hashtable[hash]:
    if(movie.id == id):
      return 0
    
  return 1


def ConsultinHashwithHash(hashtable, id, hash):
  #if the node is empty, there is no chance of the movie being there
  if (HashNodeSizewithHash(hashtable, id, hash) == 0):
    return 1

  for movie in hashtable[hash]:
    if(movie.id == id):
      return 0
    
  return 1


def SearchinHash(hashtable, id):
  hash = HashValue(id)

  for movie in hashtable[hash]:
    if(movie.id == id):
      return movie.Movie, movie.ratings

  return None, None



#return 0 if the movie was successfully inserted, returns 1 if not
def InsertMovieinHash(hashtable, movie):
  hash = HashValue(movie.movieId)

  #if the movie is already there, the function don't insert
  if(ConsultinHashwithHash(hashtable, movie.movieId, hash) == 0):
    print("problem with the insertion of the hash")
    return 1
  
  hashtemp = HashNode(movie)

  hashtable[hash].append(hashtemp)

  return 0



def RemoveMovieinHash(hashtable, movie):
  hash = HashValue(movie.movieId)

  #if the movie isn't there, the function don't remove
  if(ConsultinHashwithHash(hashtable, movie.movieId, hash) == 1):
    return 1
  
  table = hashtable[hash]
  
  for item in table:

    if item.id == movie.movieId:
      table.remove(item)

      return 0

  return 1


def InsertRatinginHash(hashtable, rating):
  hash = HashValue(rating.movieId)

  #if the movie isn't there, the function can't insert rating information
  if(ConsultinHashwithHash(hashtable, rating.movieId, hash) == 1):
    return 1
  
  table = hashtable[hash]
  
  for item in table:

    if item.id == rating.movieId:
      item.ratings.append(rating.rating)
      item.numberRatings += 1

      return 0

  return 1


def CalculateAllAverageRatings(hashtable):
    # it's a list, but it's a reserved word so i used bucket
    for bucket in hashtable:
        for item in bucket:
            # If there is any ratings, calculate the average rating
            if item.numberRatings > 0:
                item.aveRating = sum(item.ratings) / item.numberRatings

