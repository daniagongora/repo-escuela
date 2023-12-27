#lang plai

;; Definición de los tipos de datos pilas y colas. Para esto, utilizamos un solo ADT mediante el cual modelaremos
;; el comportamiento de cada una de las instancias correspondientes.

;; Definición de tipo de dato Nodo, necesario para definir pilas-y-colas
(define-type Nodo
  [Void] ;; Nodo vacío
  [nodo (elem number?) (siguiente Nodo?)]) ;; Nodo con un elemento y referencia al siguiente nodo en la estructura

;;Definiendo pilas y colas
(define-type pilas-y-colas
  [pila (nodos Nodo?)]  ;; Definiendo pila
  [cola (nodos Nodo?)]) ;; Definiendo cola

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Definición del tipo de dato abstracto "arboles binarios de busqueda"
;; podemos insertar elementos en el arbol de manera "ordenada" de tal forma que yo pueda
;; acceder a ellos en tiempo del orden de O(log n), donde n es el numero de elementos en el arbol

; Definicion del tipo de dato abstracto 
(define-type binary-search-tree
  [VoidTree] ;; Arbol vacío
  [BST (elem number?) (lst binary-search-tree?) (rst binary-search-tree?)]) ;;Arbol-nodo no vacío, y subárboles izquierdo y derecho 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; CODIGO PARA PRACTICA 2: definición de List -nuestra representación de listas-.
;; Para realizar este ejercicio, descomenta las siguientes líneas de código. 
;;(define-type List
;; AQUI VA TU CÓDIGO
;;  )