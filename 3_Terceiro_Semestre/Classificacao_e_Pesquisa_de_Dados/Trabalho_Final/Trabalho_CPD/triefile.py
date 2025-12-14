import unicodedata
from typefile import TrieNode, Movie

def NormalizeText(text):
  #Remove accents 
  nfkd_form = unicodedata.normalize('NFD', text)
  text = nfkd_form.encode('ascii', 'ignore').decode('utf-8')
  
  #Converts to Uppercase 
  text = text.upper() 

  return text

class Trie:

  def __init__(self):
    # empty root node
    self.root = TrieNode()

  def searchTrieRecursiveStep(self, node, movieids):

    # if the list is not empty
    if(len(node.ids) > 0):
      movieids.extend(node.ids)

    for child_node in node.children.values():
      self.searchTrieRecursiveStep(child_node, movieids)

    return movieids


  # searchs for any titles that start with the string and return the movie ids in a list
  def searchTrie(self, string):
    movieids = []
    node = self.root

    #cleaning the string
    string = NormalizeText(string)

    # goes through every letter in the string
    for char in string:
      # if he character isn't there, return an empty list
      if char not in node.children:
        return []
      
      # else, goes futher
      node = node.children[char]

    # now the node is in the last character on the string 

    # this step is recursive, so i will use another function(uses depth first approach)
    self.searchTrieRecursiveStep(node, movieids)

    return movieids
  
  # Insert a movie in Trie tree
  def insertTrie(self, movie):
    node = self.root

    title = movie.title
    movieId = movie.movieId

    #cleaning the title
    title = NormalizeText(title)
      
    # loop through every letter in the title
    for letter in title:
      # if the letter path doesn't exist yet, create it
      if letter not in node.children:
        node.children[letter] = TrieNode(letter)
        
      # go to the next node
      node = node.children[letter]
    
    # puts the movieId in the node
    node.ids.append(movieId)

