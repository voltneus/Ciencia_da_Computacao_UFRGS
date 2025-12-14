from typefile import HashTagsNode
from triefile import NormalizeText

'''
class HashTagsNode:

  def __init__(self, Tag):
    self.tag = NormalizeText(Tag.tag)
    self.tags = []

  def __repr__(self):
    return f"HashTagsNode({self.tag} / number of reviews:'{len(self.tags)}')"


'''

M = 35437 

def HashValueString(string):
  hashvalue = 0
  prime_multiplier = 31 # Moves the position to the left
   
  for char in string:
    charvalue = ord(char)
    hashvalue = (hashvalue * prime_multiplier + charvalue) % M

  return hashvalue

#return 0 if the movie was successfully inserted, returns 1 if not
def InsertinTagsHash(hashtable, Tag):
  tag = NormalizeText(Tag.tag)

  hash = HashValueString(tag)

  for hashnode in hashtable[hash]:
    if(hashnode.tag == tag):
      hashnode.tags.append(Tag)
      return 0
  
  newnode = HashTagsNode(Tag)
  newnode.tags.append(Tag)
  hashtable[hash].append(newnode)

  return 0

def SearchinTagHash(hashtable, string):
  string = NormalizeText(string)
  hash = HashValueString(string)

  for hashnode in hashtable[hash]:
    if(hashnode.tag == string):
      return hashnode

  return None