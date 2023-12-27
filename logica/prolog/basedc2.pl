% --------------------------------------------------%
%          Practica 5- Introdución a Prolog        %
% --------------------------------------------------%


pura_a([]).
pura_a([a|T]):- pura_a(T).

reemplaza_a_b_c([],[]).
reemplaza_a_b_c([b],[c]).
reemplaza_a_b_c([c],[a]).
reemplaza_a_b_c([a],[b]).
reemplaza_a_b_c([a|XS],[b|YS]) :- reemplaza_a_b_c(XS,YS).
reemplaza_a_b_c([b|XS],[c|YS]) :- reemplaza_a_b_c(XS,YS).
reemplaza_a_b_c([c|XS],[a|YS]) :- reemplaza_a_b_c(XS,YS).
reemplaza_a_b_c([X|XS],[X|YS]) :- X \= a, X \= b, X \= c, reemplaza_a_b_c(XS,YS).

longitud([],0).
longitud([X|XS],Y) :- longitud(XS,K), Y is 1+K.

suma_uno([],[]).
suma_uno([X|XS],[Y|YS]) :- Y is X+1, suma_uno(XS,YS).

contiene_0([0]).
contiene_0([X|YS]) :- X is 0;contiene_0(YS).

mult_escalar(X,[],[]).
mult_escalar(Y,[X|XS],[R|RS]) :- R is Y*X, mult_escalar(Y,XS,RS).

prodPunto([],[],0).
prodPunto([X|XS],[Y|YS],R) :- prodPunto(XS,YS,K), R is X*Y + K.

max([X],X).
