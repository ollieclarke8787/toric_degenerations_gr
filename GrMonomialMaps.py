from itertools import chain, combinations


class Block_Matrix:
  #class for "block diagonal" weight matrix
  # initialises matrix given a list of block sizes
  # 
  
  def __init__(self, a = [2,2]):
    
    #list of block sizes
    self.block_sizes = a
    
    #value of n
    self.n = sum(self.block_sizes)
    
    #generate the blocks 
    self.blocks = []
    next_number = 1
    for block_size in self.block_sizes:
      new_block = range(next_number, next_number + block_size)
      self.blocks.append(new_block)
      next_number += block_size
    
    #index the blocks for lookup
    self.get_block ={b:i+1 for i in range(len(self.blocks)) for b in self.blocks[i]}
    
    #create the matrix:
    # start with the diagonal matrix
    # replace the 2nd row with
    #  the blocks reversed with 1 subtracted
    #
    
    self.matrix = diagonal_matrix(self.n)
    new_second_row = []
    for b in self.blocks:
      new_second_row += map(lambda x: x-1, b[::-1])
    
    self.matrix[1] = new_second_row
  
  def __call__(self, I):
    # I subset of [n] - list or tuple, not empty or [n] itself
    #  return the weight of P_I
    #
    #  note that the least weight's location is immediate from the tableau
    #  which is explicitly given by the id or (12) permutation depending on
    #  the values of i1 and i2 from I
    #
    
    if len(I) == 1:
      return self.matrix[0][I[0]-1]
    
    i1 = I[0]
    i2 = I[1]
    
    b1 = self.get_block[i1]
    b2 = self.get_block[i2]
    
    #if i1 and i2 belong to the same block then
    # I is mapped to id
    # otherwise I is mapped to (12)
    # in either case we calculate the weight
    
    if b1 == b2:
      entries = [(i, I[i]-1) for i in range(len(I))]
    else:
      entries = [(0,I[1]-1), (1,I[0]-1)] + [(i, I[i]-1) for i in range(2,len(I))]
    
    weight = sum(map(lambda x: self.matrix[x[0]][x[1]],entries))
    return weight
    
  
  def __repr__(self):
    return "<Block Matrix of type " + str(self.block_sizes) + " for n = "+ str(self.n) + ">"
  
  def weight_vector(self, single = False, negate = False):
    #returns the weight vector associated to the matrix
    # the subsets of [n] are given in relex order
    # E.g. for n=4 the order of the weights will be
    # [1, 2, 3, 4, 12, 13, 14, 23, 24, 34, 123, 124, 134, 234]
    #
    # single - if False then returns a list
    #        - if True then returns a printable string of weights
    #
    # negate - controls whether the vector is negated
    #        - if negated then subtract all values from a large value
    #        - large value is given by max value of weights
    
    
    s = range(1,self.n + 1)
    subsets = list(chain.from_iterable(combinations(s,i) for i in range(1,self.n)))
    weights = map(lambda s: self(s), subsets)
    
    if negate:
      large_value = max(weights)
      weights = map(lambda x: large_value - x, weights)
    
    if single:
      return_string = ""
      for w in weights:
	return_string += str(w) + ", "
      return return_string[:-2]
    
    else:
      return weights 
  
  def list_true_orders(self, k):
    #returns the list of true orders of subsets of [n] of size k
    #
    
    n = self.n
    s = range(1,n + 1)
    subsets = combinations(s,k)
    return_list = []
    
    for I in subsets:
      if len(I) == 1:
	return_list.append([I[0]])
      
      else:
	i1 = I[0]
	i2 = I[1]
	
	b1 = self.get_block[i1]
	b2 = self.get_block[i2]
	
	#if i1 and i2 belong to the same block then
	# I is mapped to id
	# otherwise I is mapped to (12)
	# in either case we calculate the weight
	
	if b1 == b2:
	  entries = [I[i] for i in range(len(I))]
	else:
	  entries = [I[1], I[0]] + [I[i] for i in range(2,len(I))]
	
	return_list.append(entries)
  
    return return_list
  
  def monomial_map_vector(self, single = False, k = 3):
    #returns the list of monomials for the map: R -> S
    # for the monomial map
    #
    
    n = self.n
    s = range(1,n + 1)
    subsets = combinations(s,k)
    map_list = []
    
    for I in subsets:
      if len(I) == 1:
	map_list.append("x_(1," + str(I[0]) + ")")
      
      else:
	i1 = I[0]
	i2 = I[1]
	
	b1 = self.get_block[i1]
	b2 = self.get_block[i2]
	
	#if i1 and i2 belong to the same block then
	# I is mapped to id
	# otherwise I is mapped to (12)
	# in either case we calculate the weight
	
	if b1 == b2:
	  entries = [(i+1, I[i]) for i in range(len(I))]
	  sign = 0
	else:
	  entries = [(1,I[1]), (2,I[0])] + [(i+1, I[i]) for i in range(2,len(I))]
	  sign = 1
	
	if sign == 1:
	  monomial_str = "-"
	else:
	  monomial_str = ""
	
	for x in entries:
	  monomial_str += "x_(" + str(x[0]) + "," + str(x[1]) + ")*"
	monomial_str = monomial_str[:-1]
	
	map_list.append(monomial_str)
    
    if single:
      return_string = ""
      for l in map_list:
	return_string += l + ", "
      return return_string[:-2]
    else:
      return map_list
  
  
def diagonal_matrix(n):
  #returns the matrix for the diagonal term order
  # of size n-1 by n
  #
  
  result_matrix = []
  
  for row in xrange(n-1):
    #for each row, take the list [n-1, n-2, .. 2,1,0]
    # multiply it by the row index
    # append the result to result matrix
    #
    
    l = range(n-1, -1, -1)
    result_matrix.append(map(lambda x: x*row, l))
    
  return result_matrix

def variables(n, single = False, k = 3):
  #returns a list of variable names: "p_(1), p_(2), ..."
  # for indexed by all subsets of [n] except [] and [n] itself
  #
  # single - if True then returns as a single string the names
  #        - if False then returns a list of strings
  #
  
  s = range(1,n + 1)
  subsets = combinations(s,k)
  var_list = []
  for I in subsets:
    v = "p_("
    for i in I:
      v += str(i) + ", "
    v = v[:-2] + ")"
    var_list.append(v)
  
  if single:
    return_string = ""
    for v in var_list:
      return_string += v + ", "
    return return_string[:-2]
    
  else:
    return var_list

def plucker_map_vector(n, single = False):
  #returns the list of "P(I)"'s for the map:R -> S
  # for the plucker map
  #
  
  s = range(1,n + 1)
  subsets = chain.from_iterable(combinations(s,i) for i in range(1,n))
  map_list = []
  
  for I in subsets:
    l = "P(["
    for i in I:
      l += str(i) + ", "
    map_list.append(l[:-2] + "])")
  
  if single:
    return_string = ""
    for l in map_list:
      return_string += l + ", "
    return return_string[:-2]
    
  else:
    return map_list


	
if __name__ == "__main__":
  

  n = 4
  k = 2

  print "-------------------------------------"
  print "--------- Macaulay2 Code ------------"
  print "-------------------------------------"

  print "R = QQ[" + variables(n, True, k) + "];"

  print "monomialMapList = {"
  for i in range(n):
    a = [i, n-i]
    m = Block_Matrix(a)
    if i == n-1:
      print "map(S,R, {" + m.monomial_map_vector(True, k) +"})"
    else:
      print "map(S,R, {" + m.monomial_map_vector(True, k) +"}),"
  print "};"
