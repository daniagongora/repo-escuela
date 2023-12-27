#lang plai
;;Integrantes
;;Dania Paula Gongora Ramirez
;;Karla Clemente Herrera
;;Salgado Tirado Diana Laura
;;Peña Nuñez Axel Yael

(require (file "./grammars.rkt"))
(require (file "./parser.rkt"))

;; Función correspondiente al algoritmo de sustitución
(define (subst expr sub-id value)
  (match expr
    [(id i) (if (symbol=? i sub-id) value expr)]
    [(num n) expr]
    [(op fun args) (op fun (map (lambda (exp)
                                  (subst exp sub-id value))
                                args))]
    [(with bindings body-with)
     (let ((id-list (map binding-nombre bindings)))
       (if (member sub-id id-list)
           (with (reemplaza sub-id value bindings)
                 (subst body-with sub-id value))
           (with (reemplaza sub-id value bindings)
                 (subst body-with sub-id value))))]
    
    [(with* bindings body-with)
     (let ((id-list (map binding-nombre bindings)))
       (if (member sub-id id-list)
           (with* (reemplaza sub-id value bindings)
                  (subst body-with sub-id value))
           (with* (reemplaza sub-id value bindings)
                  (subst body-with sub-id value))))]))

;;Función auxiliar que reemplaza todas las apariciones
;;del identificador sub-id por cierto valor
(define (reemplaza sub-id val bindings)
  (map (lambda (b)
         (match b
           [(binding name value)
            (binding name (subst value sub-id val))]))
       bindings))

;; Función auxiliar obtiene el nombre de un binding
(define (binding-nombre b)
  (match b
    [(binding n v) n]))
; (interp (anD (list (bool true) (bool false))))
;(interp (oR (list (bool false) (bool false))))
;; Toma un árbol de sintáxis abstraca del lenguaje WBAE.
;; interp: CFWBAE DefrdSub-> CFWBAE-Value
(define (interp expr)
  (type-case WBAE expr
    [id (i) (error 'interp "Variable libre D:!")]
    [num (n) expr] ;; cambie esto , no estoy segura , si se evalua un num n deberia regresar n no? Evalua a n, en la practica pone que (interp (parse 12345)) evalua (num 12345)
    [bool (b) expr]
    [chaR (c) expr]
    [strinG (s) expr]
    [lst (l) (lst (map (lambda (x) (interp x)) l))]
    [op (f args) (interp (parse(apply f (map (lambda (x) (get-racket-value x)) args))))]
    [with (bindings body)
          (if (empty? bindings)
              (interp body)
              (interp (with (cdr bindings) (subst body (binding-id (car bindings))(binding-value (car bindings)))))) 
              ]
    [with* (bindings body)
           (if (empty? bindings)
               (interp body)
               (interp (with* (map (lambda (x) (subst-binding x (binding-id (car bindings)) (binding-value (car bindings)))) (cdr bindings)) (subst body (binding-id (car bindings))(binding-value (car bindings))))))]
     ;;creo que para el with seria algo asi; (interp (foldl (lambda (bin expr)
    ;;foldl se utiliza para recorrer y aplicar una operación en cada elemento acumulando el resultado en un valor.
                                        ;; (subst expr
                                          ;;(binding-name bin)
                                           ;; (num (interp (binding-value bin)))))
                                      ;; body-with
                                      ;; bindings))]
    )
  )
;;A partir de una expresión de tipo WBAE se obtiene el valor que tiene en racket
(define (get-racket-value expr)
  (cond
    ;;Solo se utilizan los casos de num y lst, ya que son los únicos tipos que se utilizan en las operaciones
    [(num? expr) (num-n expr)]
    [(bool? expr) (bool-b expr)]
    [(chaR? expr) (chaR-c expr)]
    [(strinG? expr) (strinG-s expr)]
    [(lst? expr)] (map get-racket-value (lst-l expr))))

;;Sustituye en el cuerpo de un binding el valor de un id
(define (subst-binding bind id value)
  (binding (binding-id bind) (subst (binding-value bind) id value)))
