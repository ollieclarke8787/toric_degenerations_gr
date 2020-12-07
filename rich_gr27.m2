loadPackage "Binomials";

n = 7;
k = 2;

subOne = L -> return for i from 0 to (#L - 1) list (L#i - 1);
addOne = L -> for l in L list l+1;

Perms = for p in (permutations n) list addOne(p);
Subsets = subsets(1 .. n, k);

IsSetNotMore = (A, B) -> (result := false,
for i from 0 to (#A - 1) do if A#i < B#i then return true,
return result);

getSubsets = (v,w) -> (result := {},
for S in Subsets do if (IsSetNotMore(S,v) or IsSetNotMore(w,S)) then result = append(result,S),
return result);

setToSeq = S -> if #S == 1 then return S#0 else return toSequence(S);
getSeqs = (v,w) -> (result := {}, 
a := 1,
for s in getSubsets(v,w) do (a = setToSeq s, result = append(result, a)),
return result);

allSubsetsSeq = for s in subsets(1 .. n, k) list setToSeq s;
allVars = for a in allSubsetsSeq list p_a;

R = QQ[p_(1, 2), p_(1, 3), p_(1, 4), p_(1, 5), p_(1, 6), p_(1, 7), p_(2, 3), p_(2, 4), p_(2, 5), p_(2, 6), p_(2, 7), p_(3, 4), p_(3, 5), p_(3, 6), p_(3, 7), p_(4, 5), p_(4, 6), p_(4, 7), p_(5, 6), p_(5, 7), p_(6, 7)];

S = QQ[x_(1,1) .. x_(k, n)];
X = matrix for r from 1 to k list for c from 1 to n list x_(r,c);

getVars = (v,w) -> for s in getSeqs(v,w) list p_s;

permList = {}
for v in Subsets do for w in Subsets do if IsSetNotMore(v,w) then permList = append(permList, (setToSeq(v),setToSeq(w)));

varIdealGenList = {};
tempvarlist = {};
for S in permList do (tempvarlist = getVars(S#0, S#1), varIdealGenList = append(varIdealGenList, tempvarlist));
varIdealList = for G in varIdealGenList list ideal(G);

monomialMapList = {
map(S,R, {x_(1,1)*x_(2,2), x_(1,1)*x_(2,3), x_(1,1)*x_(2,4), x_(1,1)*x_(2,5), x_(1,1)*x_(2,6), x_(1,1)*x_(2,7), x_(1,2)*x_(2,3), x_(1,2)*x_(2,4), x_(1,2)*x_(2,5), x_(1,2)*x_(2,6), x_(1,2)*x_(2,7), x_(1,3)*x_(2,4), x_(1,3)*x_(2,5), x_(1,3)*x_(2,6), x_(1,3)*x_(2,7), x_(1,4)*x_(2,5), x_(1,4)*x_(2,6), x_(1,4)*x_(2,7), x_(1,5)*x_(2,6), x_(1,5)*x_(2,7), x_(1,6)*x_(2,7)}),
map(S,R, {-x_(1,2)*x_(2,1), -x_(1,3)*x_(2,1), -x_(1,4)*x_(2,1), -x_(1,5)*x_(2,1), -x_(1,6)*x_(2,1), -x_(1,7)*x_(2,1), x_(1,2)*x_(2,3), x_(1,2)*x_(2,4), x_(1,2)*x_(2,5), x_(1,2)*x_(2,6), x_(1,2)*x_(2,7), x_(1,3)*x_(2,4), x_(1,3)*x_(2,5), x_(1,3)*x_(2,6), x_(1,3)*x_(2,7), x_(1,4)*x_(2,5), x_(1,4)*x_(2,6), x_(1,4)*x_(2,7), x_(1,5)*x_(2,6), x_(1,5)*x_(2,7), x_(1,6)*x_(2,7)}),
map(S,R, {x_(1,1)*x_(2,2), -x_(1,3)*x_(2,1), -x_(1,4)*x_(2,1), -x_(1,5)*x_(2,1), -x_(1,6)*x_(2,1), -x_(1,7)*x_(2,1), -x_(1,3)*x_(2,2), -x_(1,4)*x_(2,2), -x_(1,5)*x_(2,2), -x_(1,6)*x_(2,2), -x_(1,7)*x_(2,2), x_(1,3)*x_(2,4), x_(1,3)*x_(2,5), x_(1,3)*x_(2,6), x_(1,3)*x_(2,7), x_(1,4)*x_(2,5), x_(1,4)*x_(2,6), x_(1,4)*x_(2,7), x_(1,5)*x_(2,6), x_(1,5)*x_(2,7), x_(1,6)*x_(2,7)}),
map(S,R, {x_(1,1)*x_(2,2), x_(1,1)*x_(2,3), -x_(1,4)*x_(2,1), -x_(1,5)*x_(2,1), -x_(1,6)*x_(2,1), -x_(1,7)*x_(2,1), x_(1,2)*x_(2,3), -x_(1,4)*x_(2,2), -x_(1,5)*x_(2,2), -x_(1,6)*x_(2,2), -x_(1,7)*x_(2,2), -x_(1,4)*x_(2,3), -x_(1,5)*x_(2,3), -x_(1,6)*x_(2,3), -x_(1,7)*x_(2,3), x_(1,4)*x_(2,5), x_(1,4)*x_(2,6), x_(1,4)*x_(2,7), x_(1,5)*x_(2,6), x_(1,5)*x_(2,7), x_(1,6)*x_(2,7)}),
map(S,R, {x_(1,1)*x_(2,2), x_(1,1)*x_(2,3), x_(1,1)*x_(2,4), -x_(1,5)*x_(2,1), -x_(1,6)*x_(2,1), -x_(1,7)*x_(2,1), x_(1,2)*x_(2,3), x_(1,2)*x_(2,4), -x_(1,5)*x_(2,2), -x_(1,6)*x_(2,2), -x_(1,7)*x_(2,2), x_(1,3)*x_(2,4), -x_(1,5)*x_(2,3), -x_(1,6)*x_(2,3), -x_(1,7)*x_(2,3), -x_(1,5)*x_(2,4), -x_(1,6)*x_(2,4), -x_(1,7)*x_(2,4), x_(1,5)*x_(2,6), x_(1,5)*x_(2,7), x_(1,6)*x_(2,7)}),
map(S,R, {x_(1,1)*x_(2,2), x_(1,1)*x_(2,3), x_(1,1)*x_(2,4), x_(1,1)*x_(2,5), -x_(1,6)*x_(2,1), -x_(1,7)*x_(2,1), x_(1,2)*x_(2,3), x_(1,2)*x_(2,4), x_(1,2)*x_(2,5), -x_(1,6)*x_(2,2), -x_(1,7)*x_(2,2), x_(1,3)*x_(2,4), x_(1,3)*x_(2,5), -x_(1,6)*x_(2,3), -x_(1,7)*x_(2,3), x_(1,4)*x_(2,5), -x_(1,6)*x_(2,4), -x_(1,7)*x_(2,4), -x_(1,6)*x_(2,5), -x_(1,7)*x_(2,5), x_(1,6)*x_(2,7)}),
map(S,R, {x_(1,1)*x_(2,2), x_(1,1)*x_(2,3), x_(1,1)*x_(2,4), x_(1,1)*x_(2,5), x_(1,1)*x_(2,6), -x_(1,7)*x_(2,1), x_(1,2)*x_(2,3), x_(1,2)*x_(2,4), x_(1,2)*x_(2,5), x_(1,2)*x_(2,6), -x_(1,7)*x_(2,2), x_(1,3)*x_(2,4), x_(1,3)*x_(2,5), x_(1,3)*x_(2,6), -x_(1,7)*x_(2,3), x_(1,4)*x_(2,5), x_(1,4)*x_(2,6), -x_(1,7)*x_(2,4), x_(1,5)*x_(2,6), -x_(1,7)*x_(2,5), -x_(1,7)*x_(2,6)})
};



JIdealList = for M in monomialMapList list kernel M;
zeroIdeal = R*ideal()
SumIdealList = flatten for j from 0 to (#JIdealList - 1) list for i from 0 to (#permList - 1) list (j, permList#i, eliminate(JIdealList#j + varIdealList#i, varIdealGenList#i));


SumIdealNonZeroList = {};
SumIdealZeroList = {};

for L in SumIdealList do (if not L#2 == zeroIdeal then SumIdealNonZeroList = append(SumIdealNonZeroList, L) else SumIdealZeroList = append(SumIdealZeroList, L));


SumIdealPrimeList = {};
SumIdealNonPrimeList = {};

for L in SumIdealNonZeroList do (if binomialIsPrime(L#2) then SumIdealPrimeList = append(SumIdealPrimeList, L) else SumIdealNonPrimeList = append(SumIdealNonPrimeList, L));


f = "Degenerated Richardson Ideals Gr(2,7) MAIN Output";
f << "----Toric Ideals----" << endl;

for L in SumIdealPrimeList do (f << (L#0, L#1, toString mingens L#2) << endl << endl);

f << "----Non-Toric Ideals----" << endl;

for L in SumIdealNonPrimeList do (f << (L#0, L#1, toString mingens L#2) << endl << endl);

f << "----Zero Ideals----" << endl;
for L in SumIdealZeroList do (f << (L#0, L#1, toString mingens L#2) << endl << endl);

f << close;



f = "Degenerated Richardson Ideals Gr(2,7) Indices Output";
f << "----Toric Ideals----" << endl;

for L in SumIdealPrimeList do (f << (L#0, L#1) << endl << endl);

f << "----Non-Toric Ideals----" << endl;

for L in SumIdealNonPrimeList do (f << (L#0, L#1) << endl << endl);

f << "----Zero Ideals----" << endl;
for L in SumIdealZeroList do (f << (L#0, L#1) << endl << endl);

f << close;



