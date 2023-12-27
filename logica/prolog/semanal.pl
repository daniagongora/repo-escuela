bisiesto(X) :- D4 is X mod 4, D100 is X mod 100, D400 is X mod 400, ((D4 = 0, D100 \= 0); D400 = 0).





