#lang plai
;; Importando las definiciones de los tipos de datos
(require "datatypes.rkt")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; DEFINICIONES PARA PILAS Y COLAS ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Definiendo mete
(define (mete poc elem)
  (type-case pilas-y-colas poc 
    [pila (nodos) (pila (agrega-al-final nodos elem))]
    [cola (nodos) (cola (agrega-al-final nodos elem))]))

(define (agrega-al-final nodos elem)
  (type-case Nodo nodos
    [Void () (nodo elem (Void))]
    [nodo (e s) (nodo e (agrega-al-final s elem))] ;; en este caso, ambas estructuras estan agregando del mismo "lado"
    ))

;;Definiendo saca
(define (saca poc)
  (type-case pilas-y-colas poc
    [pila (nodos) (pila (saca-al-final nodos))]  ;; comportamiento para pila
    [cola (nodos) (cola (saca-al-inicio nodos))] ;; comportamiento para cola
    ))

;; saca-al-final y saca-al-inicio definen diferentes comportamientos
(define (saca-al-final nodos)
  (type-case Nodo nodos
    [Void () (Void)]
    [nodo (e s)
          (cond
            [(equal? s (Void)) (Void)]
            [else (nodo e (saca-al-final s))])]))

(define (saca-al-inicio nodos)
  (type-case Nodo nodos
    [Void () (Void)]
    [nodo (e s)
          (cond
            [(equal? s (Void)) (Void)]
            [else s])]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; DEFINICIONES PARA ARBOLES (BST) ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Recorriendo arboles (pre, in post)
;; preorden :: binary-search-tree -> list
(define (preorden bst)
  (type-case binary-search-tree bst
    [VoidTree () empty]
    [BST (e l r) (append (list e) (preorden l) (preorden r))]))

;; inorden :: binary-search-tree -> list
(define (inorden bst)
  (type-case binary-search-tree bst
    [VoidTree () empty]
    [BST (e l r) (append (inorden l) (list e) (inorden r))]))

;; postorden :: binary-search-tree -> list
(define (postorden bst)
  (type-case binary-search-tree bst
    [VoidTree () empty]
    [BST (e l r) (append (postorden l) (postorden r) (list e))]))

;; definiendo map sobre BST
;; map-bst :: binary-search-tree -> binary-search-tree
(define (map-bst f bst)
  (type-case binary-search-tree bst
    [VoidTree () (VoidTree)]
    [BST (e l r) (BST (f e) (map-bst f l) (map-bst f r))]))

;; busqueda :: binary-saearch-tree -> boolean
;; complejidad en tiempo: O(log n)
(define (search-in-bst bst elem)
  (type-case binary-search-tree bst
    [VoidTree () #f]
    [BST (e l r)
         (cond
           [(equal? e elem) #t]                ;; si ya encontré a mi elemento, entonces true
           [(< elem e) (search-in-bst l elem)] ;; si el elemento a buscar es menor, entonces hago recursión en mi subarbol izquierdo 
           [else (search-in-bst r elem)])]))   ;; recursión sobre mi subarbol derecho

;; inserta :: binary-search-tree -> binary-search-tree
(define (insert-in-bst bst elem)
  (type-case binary-search-tree bst
    [VoidTree () (BST elem (VoidTree) (VoidTree))]        ;; caso base: creamos un nodo a partir de un elemento
    [BST (e l r)
         (cond
           [(<= elem e) (BST e (insert-in-bst l elem) r)] ;; si el elemento a agregar es menor o igual, hacemos recursión sobre el subarol izquierdo
           [else (BST e l (insert-in-bst r elem))])]))    ;; en otro caso, recursión sobre el subárbol derecho
                                                          ;;
                                                          ;; recuerda que para estamos regresando la estructura, entonces debemos conservarla en las
                                                          ;; llamadas recursivas


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; ALGUNAS DEFINICIONES UTILES PARA PROBAR CÓDIGO ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; algunas definiciones de pilas y colas
(define pila1
  (pila (nodo 1 (nodo 2 (nodo 3 (nodo 4 (nodo 5 (Void))))))))
(define pila2
  (pila (nodo 423 (nodo 32 (Void)))))
(define pila3
  (mete pila2 77))
(define cola1
  (cola (nodo 1 (nodo 2 (nodo 3 (nodo 4 (nodo 5 (Void))))))))
(define cola2
  (cola (nodo 323 (nodo 2342 (nodo 32112 (Void))))))

(define pila-void
  (pila (Void)))
(define cola-void
  (cola (Void)))

(define cola3
  (cola (nodo 232 (Void))))
(define pila4
  (pila (nodo 232 (Void))))

(define cola4
  (cola (nodo 232 (nodo 45 (Void)))))
(define pila5
  (pila (nodo 232 (nodo 45 (Void)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;definiendo funcion para ejemplo de map
(define (suma10 x)
  (+ x 10))

;; Definiendo algunos árboles para probar nuestras definciones anteriores
(define tree1
  (BST 6
       (VoidTree)
       (VoidTree)))

(define tree2
  (BST 6
       (BST 2
            (BST 1
                 (VoidTree)
                 (VoidTree))
            (BST 3
                 (VoidTree)
                 (VoidTree)))
       (BST 10
            (BST 8
                 (VoidTree)
                 (VoidTree))
            (BST 11
                 (VoidTree)
                 (VoidTree)))))

(define tree3
  (insert-in-bst tree2 1))