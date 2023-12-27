% --------------------------------------------------%
%          Practica 4 - Introdución a Prolog        %
% --------------------------------------------------%

% --------------------------------------------------%
%      Sintáxis básica y bases de conocimiento      %
% --------------------------------------------------%


% A continuación tenemos algunos hechos sobre animales

es_perro(blacky).  %blacky es un perro
es_perro(rizzo).
es_perro(rufus).
es_gato(masapan).  
es_gato(waffle).
es_gato(curie).
es_gato(crepita).
es_raton(boris).
es_raton(matilda).



mas_grande(elefante, caballo).
mas_grande(caballo, perro).
mas_grande(perro, raton).
mas_grande(raton, hormiga).

% Aquí hay un ejemplo de función recursiva en prolog
% El caso base 
mucho_mas_grande(X,Y) :- mas_grande(X, Y).
mucho_mas_grande(X,Y) :- mas_grande(X, Z), mucho_mas_grande(Z, Y).

% --------------------------------------------------%
%          1-Parentesco, árbol sld y grafos         %
% --------------------------------------------------%
progenitorde(martin,luis).
progenitorde(luis,jose).
progenitorde(luis, pedro).
progenitorde(ursula, aureliano).
progenitorde(arcadio, aureliano).
progenitorde(ursula, remedios).
progenitorde(arcadio,remedios).
progenitorde(ursula, amaranta).
progenitorde(arcadio,amaranta).
progenitorde(aureliano, mauricio).
progenitorde(fernanda, mauricio).
progenitorde(aureliano, renata).
progenitorde(fernanda, renata).


padrede(A,B):-progenitorde(A,B).
hijode(A,B) :- padrede(B, A).
abuelode(A,B) :- padrede(A,Z);padrede(B,Z).
hermanode(A,B) :- espadre(Z),padrede(Z,A),padrede(Z,B).
familiarde(A,B) :- hijode(A,B);padrede(A,B);abuelode(A,B);hermanode(A,B).

%Conexiones de un grafo

conexion(d,h,4).
conexion(h,f,9).
conexion(i,f,11).
conexion(f,a,8).
conexion(a,b,7).
conexion(f,g,10).
conexion(g,c,10).


%atravesar(X,Y,Z,Costo) :- conexion(X,Y,C1),conexion(Y,Z,C2),Costo is C1+C2.

atravesar(X, Z, Costo) :- conexion(X,Z,Costo). 
%atravesar(X,Z,Costo) :- conexion(X,Y,C1),conexion(Y,Z,C2),Costo is C1+C2.
atravesar(X,Z,Costo) :- conexion(X,Y,C1),atravesar(Y,Z,C2),Costo is C1 + C2.

%Recursividad en el grafo

camino(X,Y) :- conexion(X,Y,_).
camino(X,Y) :- conexion(X,Z,_),camino(Z,Y).






%Serie de Gauss Recursiva
suma(0,0).
suma(X,Res) :- Y is X - 1 ,suma(Y,S),  Res is X + S.






% --------------------------------------------------%
%                2-Números naturales                %
% --------------------------------------------------%

%%Naturales a enteros


es_natural(c).
es_natural(s(X)) :- es_natural(X).


to_int(c, 0).
to_int(s(N), R) :- to_int(N, R1), R is R1 + 1.


suma(c,Y,Y) :- es_natural(Y). 
suma(s(X),Y,s(Z)) :- suma(X,Y,Z).


% --------------------------------------------------%
%                      3-Listas                     %
% --------------------------------------------------%


cabeza1([C|_],Cabeza) :- Cabeza is C.


progenitor(pedro, [ana, ramon]).
progenitor(ana, [ramon, pepe, juan]).
progenitor(pedro, [ana, ramon, pedro, javier, josh, vilma, nicolas]).
progenitor(juan, [ben, pepe, josue, jesica, pavel, keith, kyle]).

cabeza([C|_], C).

primerHijo(P,Hijo) :- progenitor(P,[Hijo|_]).



esPadre(P, H) :- progenitor(P, Hijos), buscar(H, Hijos).


buscar(_, []) :- !, fail. 	
buscar(Hijo, [C|_]) :- Hijo == C.
%buscar(Hijo, [Hijo |L]) :- !, true.
buscar(Hijo, [_|L]) :- buscar(Hijo,L).



%operador member
%esPadre(P, H) :- progenitor(P, Hijos), buscar(H, Hijos).

%Hay diversas formas de pasarle argumentos a un operador
% modos de uso de las funciones

%member(X, [2,3,4,5,5]) nos va devolviendo 

%member(2, X). asigna el 2 a la cabeza de una lista anonima
%mem

listar(L) :- Xs = [2,3,4,5], H = 1, L = [H|Xs].

