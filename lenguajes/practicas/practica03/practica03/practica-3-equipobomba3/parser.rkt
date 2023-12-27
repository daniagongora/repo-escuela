#lang plai
;; Importando el archivo donde se declara la gramática de WBAE
(require "grammars.rkt")

;; Integrantes:
;; Clemente Herrera Karla
;; Salgado Tirado Diana Laura
;; Góngora Ranírez Dania Paula
;; Peña Nuñez Axel Yael

(define (anD)
  void)

(define (oR)
  void)
;; Parse :: s-expression -> WBAE
;;(define (parse sexp)
  ;; Aquí va su código.
;;  )

;; Es altamente recomendable definir múltiplies funciones auxiliares para  (al menos)
;; 1) parsear y rectificar la sintaxis de los bindings
;; 2) verificar la aridad de los operadores

;; Definiendo PARSER
(define (parse sexp)
  (cond
    [(eq? sexp 'true) (bool true)] ;;caso especial
    [(eq? sexp 'false) (bool false)];;caso especial
    [(symbol? sexp) (id sexp)]
    [(number? sexp) (num sexp)]
    [(or(eq? true sexp)(eq? false sexp))(bool sexp)]
    [(char? sexp) (chaR sexp)]
    [(string? sexp)(strinG sexp)]
    [(list? sexp)
     (if(empty? sexp)
        (error "Lista vacía")
        [case (car sexp) ;; Ahora nos fijamos en el primer elemento de la lista (sexp) 
          [(+) (verifica-aridad > 1 (cdr sexp))
               (op + (map (lambda (x) (parse x)) (cdr sexp)))] 
          [(-) (verifica-aridad > 1 (cdr sexp))
               (op - (map (lambda (x) (parse x)) (cdr sexp)))]
          [(*) (verifica-aridad > 1 (cdr sexp))
               (op * (map (lambda (x) (parse x)) (cdr sexp)))]
          [(/) (verifica-aridad > 1 (cdr sexp))
               (op / (map (lambda (x) (parse x)) (cdr sexp)))]
          [(<) (verifica-aridad > 1 (cdr sexp))
               (op < (map (lambda (x) (parse x)) (cdr sexp)))]
          [(<=) (verifica-aridad > 1 (cdr sexp))
               (op <= (map (lambda (x) (parse x)) (cdr sexp)))]
          [(=) (verifica-aridad > 1 (cdr sexp))
               (op = (map (lambda (x) (parse x)) (cdr sexp)))]
          [(>) (verifica-aridad > 1 (cdr sexp))
               (op > (map (lambda (x) (parse x)) (cdr sexp)))]
          [(>=) (verifica-aridad > 1 (cdr sexp))
               (op >= (map (lambda (x) (parse x)) (cdr sexp)))]

          [(char?) (verifica-aridad > 1 (cdr sexp))
                   (op char? (map (lambda (x) (parse x)) (cdr sexp)))]
          [(zero?) (verifica-aridad > 1 (cdr sexp))
                   (op zero? (map (lambda (x) (parse x)) (cdr sexp)))]
          [(num?) (verifica-aridad > 1 (cdr sexp))
                   (op num? (map (lambda (x) (parse x)) (cdr sexp)))]
          [(bool?) (verifica-aridad > 1 (cdr sexp))
                   (op bool? (map (lambda (x) (parse x)) (cdr sexp)))]
          [(string?) (verifica-aridad > 1 (cdr sexp))
                   (op string? (map (lambda (x) (parse x)) (cdr sexp)))]
          [(empty?) (verifica-aridad > 1 (cdr sexp))
                   (op empty? (map (lambda (x) (parse x)) (cdr sexp)))]
          [(list?) (verifica-aridad > 1 (cdr sexp))
                   (op list? (map (lambda (x) (parse x)) (cdr sexp)))]

          [(modulo) (verifica-aridad = 2 (cdr sexp))
                    (op modulo (map (lambda (x) (parse x)) (cdr sexp)))]
          [(min) (verifica-aridad > 1 (cdr sexp))
                 (op min (map (lambda (x) (parse x)) (cdr sexp)))]
          [(max) (verifica-aridad > 1 (cdr sexp))
                 (op max (map (lambda (x) (parse x)) (cdr sexp)))]
          [(expt) (verifica-aridad = 2 (cdr sexp))
                  (op expt (map (lambda (x) (parse x)) (cdr sexp)))]
          [(sqrt) (verifica-aridad > 1 (cdr sexp))
                  (op sqrt (map (lambda (x) (parse x)) (cdr sexp)))]
          [(sub1) (verifica-aridad = 1 (cdr sexp))
                  (op sub1 (map (lambda (x) (parse x)) (cdr sexp)))] ;;ejemplo (parse (sub1 1))
          [(add1) (verifica-aridad = 1 (cdr sexp))
                  (op add1 (map (lambda (x) (parse x)) (cdr sexp)))] ;;(parse (add1 1))
          
          [(not) (verifica-aridad = 1 (cdr sexp))
                  (op not (map (lambda (x) (parse x)) (cdr sexp)))]

          [(length) (verifica-aridad = 1 (cdr sexp))
                  (op length (map (lambda (x) (parse x)) (cdr sexp)))]

          [(string-length) (verifica-aridad = 1 (cdr sexp))
                  (op string-length (map (lambda (x) (parse x)) (cdr sexp)))]

          [(car) (verifica-aridad = 1 (cdr sexp))
                  (op car (map (lambda (x) (parse x)) (cdr sexp)))]

          [(cdr) (verifica-aridad = 1 (cdr sexp))
                  (op cdr (map (lambda (x) (parse x)) (cdr sexp)))]

          [(and) (verifica-aridad > 1 (cdr sexp))
                 (op anD (map (lambda (x) (parse x)) (cdr sexp)))] ;;(parse (and true false true))

          [(or) (verifica-aridad > 1 (cdr sexp))
                (op oR (map (lambda (x) (parse x)) (cdr sexp)))] 

          ;; Aquí van los demás casos para los otros operadores
          [(with) (with (map verifica-binding (second sexp)) (parse (third sexp)))]
          [(with*) (with* (map verifica-binding (second sexp)) (parse (third sexp)))]
          [else (lst (map (lambda (x) (parse x)) sexp))]
          
       ])]))


;; Función auxiliar que verifica la aridad
(define (verifica-aridad op n lst)
  (if (op (length lst) n)
      #t
      (if (= 1 n)
          (if(equal? = op)
            (error (string-append "Operador unitario: necesita únicamente un argumentos, se recibio " (number->string (length lst)) " argumentos."))
            (error (string-append "Operador binario: necesita al menos dos argumentos, se recibio " (number->string (length lst)) " argumentos.")))
          (error (string-append "Operador binario, se recibio " (number->string (length lst)) " argumentos.")))))

;; Funcion auxiliar para verificar si una lista es de bindig
(define (verifica-binding lst)
  (if (= (length lst) 2)
      (if (symbol? (car lst))
           (binding (car lst) (parse (second lst)))
           (error (format "Binding ~a malformado." lst)))
      (error (format "Binding ~a malformado." lst) )
  ))

;;
