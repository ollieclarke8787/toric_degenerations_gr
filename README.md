# toric_degenerations_gr
Toric Degenerations of Grassmannians and Schubert Varieties

## List of files
* Macaulay2 files: *gsi24.m2*, *gsi26.m2*, *gsi46.m2*
* Map generator: *GrMonomialMaps.py*
* Polytope Generator: *GrPolytope.py*

## Macaulay2 files

Run any of the Macaulay2 files to calculate the pairs (l, w) for a given k, n for which 
G_{k,n,l,w} is a toric / non-toric / zero ideal. The value for k and n appears in the file name so for example *gsi24.m2* calculates the pairs for Gr(2,4). The differences inside each of these files is:
* Values: k, n
* Map: monomialMapList
* File names: X, Y
  * f = "Degenerated Opposite Schubert Ideals Gr(X,Y) MAIN Output";
  * f = "Degenerated Opposite Schubert Ideals Gr(X,Y) Indices Output";

### Creating new Macualay2 files

The procudure to create code which calculates the pairs (l, w) as above for a different k and n is to change the following lines of code.

1. Change k, n to the new desired values in the Macualay2 file
2. Change k, n to the desired values GrMonomialMaps.py and run it
3. Take the output of GrMonomialMaps.py and paste it into the Macualay2 file overriding previous definitions
4. Change the file names in the Macaulay2 code:
  * f = "Degenerated Opposite Schubert Ideals Gr([Correct values k, n]) MAIN Output";
  * f = "Degenerated Opposite Schubert Ideals Gr([Correct values k, n]) Indices Output";

### Output format

Running the Macaulay2 creates two files: One called "... MAIN Output" and one called "... Indices Output".
The former output file has the following format:
* Three sections: Toric ideal, Non-toric ideal, Zero ideals
* Each line is (\ell, w, minimal generators of G_{k,n,l,w})


## Polytope file
The file *GrPolytope.py* generates Polymake code which gives the toric polytope of the ideals G_{k,n,l}



