from typefile import HashRatingNode

M = 35437 
M2 = 179999 

def RatingHashValue(userId):
  return userId % M2

#return 0 if the movie was successfully inserted, returns 1 if not
def InsertRatinginRatingHash(hashtable, rating):
  hash = RatingHashValue(rating.userId)

  for hashnode in hashtable[hash]:
    if(hashnode.userId == rating.userId):
      hashnode.ratings.append(rating)
      return 0
  
  newnode = HashRatingNode(rating)
  newnode.ratings.append(rating)
  hashtable[hash].append(newnode)

  return 0

def SearchinRatingHash(hashtable, userId):
  hash = RatingHashValue(userId)

  for hashnode in hashtable[hash]:
    if(hashnode.userId == userId):
      return hashnode

  return None
