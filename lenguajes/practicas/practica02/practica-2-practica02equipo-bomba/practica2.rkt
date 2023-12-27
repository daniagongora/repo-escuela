#lang plai
;; Importando las definiciones de los tipos de datos
(require "datatypes.rkt")
(require "03-07-23.rkt")

;; ----- P R A C T I C A   2 -----

;;INTEGRANTES;;
;;DIANA LAURA SALGADO TIRADO
;;DANIA PAULA GÓNGORA RAMÍREZ

;;Ejercicio 1

;; Funcion filter:
;; se utiliza para seleccionar elementos de una lista
;; que cumplen una determinada condición.
;; FIRMA: filter :: (condicion, list)-> list

;; EJEMPLO 1 FILTER - Regresa los elementos pares de la lista
(define (ej1-filter-pares lst)
  (filter even? lst))
;; EJEMPLO 2 FILTER - Regresa los elementos distintos de cero de la lista
(define (ej2-filter-quita0 lst)
  (filter (lambda (x) (not (zero? x))) lst))

;; Funcion foldr:
;; se utiliza para aplicar una función de acumulador (función que toma dos args y devuelve un valor que se utiliza en la siguiente aplicación de la misma función.) 
;; a los elementos de una lista, de derecha a izquierda(incia desde el ultimo elemento hacia el primero).
;; FIRMA: foldr :: (funcion-acumulador , valor-inicial-acumulador , list)-> resultado

;; EJEMPLO 1 FOLDR - suma los elementos de la lista.
(define (ej1-foldr-suma lst)
  (foldr + 0 lst))
;; EJEMPLO 2 FOLDR - Regresa la longitud de la lista.
(define (ej2-foldr-length lst)
  (foldr (lambda (x cont)(+ cont 1)) 0 lst))

;; Funcion foldl:
;; se utiliza para aplicar una función de acumulador 
;; a los elementos de una lista, de izquierda a derecha(incia desde el primer elemento hacia el ultimo).
;; FIRMA: foldl :: (funcion-acumulador , valor-inicial-acumulador , list)-> resultado

;; EJEMPLO 1 FOLDL - resta los elementos de la lista.
(define (ej1-foldl-resta lst)
  (foldl - 0 lst))
;; EJEMPLO 2 FOLDL - multiplica los elementos de la lista.
(define (ej2-foldl-multp lst)
  (foldl * 1 lst))

;; Ejercicio 1
;;Define la el predicado (contains? struct elem) que recibe una estructura de datos y un elemento cual-
;;quiera, determina si dicho elemento se encuentra almacenado en la estructura pasada como parámetro.

;; Funcion contains?
;; recibe una estructura de datos y un elemento cualquiera,
;; y determina si dicho elemento se encuentra almacenado en la estructura pasada como parámetro.
(define (contains? struct elem)
  (type-case pilas-y-colas struct
    [pila (nodos) (contains?-aux nodos elem)]
    [cola (nodos) (contains?-aux nodos elem)]))

;; Funcion auxiliar de contains?
;; dada una "lista" de Nodos y un elemento
;; Compara cada elemento de la lista con el buscado
;; si lo encuentra regresa true, en otro caso false.
(define (contains?-aux nodos elem-buscado)
  (type-case Nodo nodos
    ;Si el nodo es vacio entonces no tiene el elem que buscamos
    [Void () false]
    ;En otro caso
    [nodo (elem siguiente)
      ;; Comparamos el elemento del nod actual con el que buscamos
      (if (equal? elem elem-buscado)
          true ; si son iguales, quiere decir que encontramos al elemento buscado.
          (contains?-aux siguiente elem-buscado))]));si no coinciden seguimos buscando en el siguiente nodo
      


;; Funcion mira
;; recibe una estructura (struct) y regresa el elemento 
;; que se encuentra en el tope de la estructura.
(define (mira struct)
  (type-case pilas-y-colas struct
    [pila (nodos) (regresa-final nodos )]
    [cola (nodos) (regresa-inicio nodos )]))

;; Funcion auxiliar para mira que regresa 
;; al primer elemento  de una lista de nodos
(define (regresa-inicio nodos)
  (type-case Nodo nodos
    [Void () (Void)]
    [nodo (e s) e]))

;; Funcion auxiliar para mira que regresa 
;; al ultimo elemento  de una lista de nodos
(define (regresa-final nodos)
  (type-case Nodo nodos
    [Void () (Void)]
    [nodo (e s)
          (cond
            [(equal? s (Void)) e]
            [else (regresa-final s)])]))

;; Funcion size
;; determina la cantidad de elementos en la estructura.
;; Si la estructura es vacía, el número de elemento es igual a cero.
(define (size struct)
  (type-case pilas-y-colas struct
    [pila (nodos) (size-aux nodos)]
    [cola (nodos) (size-aux nodos)]))

;; Funcion auxiliar de  size
;; dado un nodo mientras no sea void suma 1 
(define (size-aux nodos)
  (type-case Nodo nodos
    [Void () 0]
    [nodo (elem siguiente)
      (+ 1 (size-aux siguiente))]))


;; Ejercicio 3: Funciones sobre arboles

;;Define la función (delete-bst bst elem) que dado un BST y un elemento,
;;lo elimina del BST y entrega como resultado el BST producto de realizar
;;dicha operación

(define (delete-bst bst elem)
  (type-case binary-search-tree bst
    ;; Caso base: el árbol es vacío, devolvemos el mismo árbol
    [VoidTree () (VoidTree)]
    
    [BST (e l r)
         (cond
          [(and (equal? e elem)(equal? l (VoidTree))(equal? r (VoidTree))) (VoidTree)]
          [(equal? e elem) (BST(bst-min l) (delete-bst l (bst-min l)) r)]
          [(< elem e) (BST e (delete-bst l elem) r)]
          [else (BST e l(delete-bst r elem))])]))

;;Función auxiliar que saca el elemento
;;minimo del árbol, este servira para mantener
;;al árbol conectado
(define (bst-min bst)
  (type-case binary-search-tree bst
   [VoidTree () VoidTree]
    [BST (e l r)
         (cond
           [(equal? l (VoidTree)) e]
           [(not(equal? l (VoidTree)))(bst-min l)])]))

;;Definir la función que dado un BST
;;devuelve el número de hojas de éste.
(define(count-leaves-bst bst)
  (type-case binary-search-tree bst
   [VoidTree () 0]
    [BST (e l r)
         (cond
           [(and (equal? l (VoidTree)) (equal? r (VoidTree))) 1]
           [else(+(count-leaves-bst l)(count-leaves-bst r))])]))

;; definiendo map sobre BST
;; map-bst :: binary-search-tree -> binary-search-tree
(define (map-bst f bst)
  (type-case binary-search-tree bst
    [VoidTree () (VoidTree)]
    [BST (e l r) (BST (f e) (map-bst f l) (map-bst f r))]))



