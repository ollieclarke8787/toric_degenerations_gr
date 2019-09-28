from GrMonomialMaps import *

def form_point(n, k, true_ordering, homogeneous = True):
  #given a true ordering of a subset of [n], form a vector
  # if homogeneous then add 1 at the beginning of the vector
  
  if homogeneous:
    output = [1]
  else:
    output = []
  
  for i in true_ordering:
    #form the next part of the vector
    
    next_part = [0]*n
    next_part[i-1] = 1
    
    output += next_part
  
  return output
  
def form_polytope(n,k,true_orders,homogeneous=True):
  #given a set of true orderings form the polytope out of all the points
  
  output = []
  
  for t in true_orders:
    p = form_point(n,k,t,homogeneous)
    output.append(p)
  
  return output
    
  




if __name__ == "__main__":
  
  k = 4
  n = 9
  
  for l in range(n):
    B = [l, n-l]
    m = Block_Matrix(B)
    
    print "$p" + str(l) + " = new Polytope(POINTS=>["
    for x in form_polytope(n,k,m.list_true_orders(k)):
      print str(x) + "," 
    print "]);"
    #print 'print "' + str(l) + ': ";'
    print "print $p" + str(l) + " -> F_VECTOR;"
    #print 'print ", ";'
    print ""
  
  
  





