#lang plai
(require (file "./grammars.rkt"))
(require (file "./parser.rkt"))
;(require (file "./desugar.rkt"))
;(require (file "./interp.rkt"))

;; (define (prueba x)
;;   (interp (desugar (parse x)) (mtSub)))

#| Pruebas de parse|#
(printf "___________________________________________________________________________________________________________________________\nInician pruebas de la función parse\n")

(test (parse '{with {{x 1} {y x} {z 3}} x})
      (with (list (binding 'x (num 1)) (binding 'y (id 'x)) (binding 'z (num 3)))
            (id 'x)))

(test (parse '{with {{x 1}
                     {y 2}}
                    {with* {{z 3}
                           {w z}}
                          {with {{a 2}}
                                {(list 'apple "y" true #\a 2)}}}})
      
      (with (list (binding 'x (num 1)) (binding 'y (num 2)))
             (with* (list (binding 'z (num 3)) (binding 'w (id 'z)))
                    (with (list (binding 'a (num 2)))
                           (lst (list (id 'apple) (strinG "y") (bool true) (chaR #\a) (num 2)))))))

(test (parse '{with* {{x 1} {y x} {z 3}}
                     {(+ x y (and true 2))}})
      (with* (list (binding 'x (num 1)) (binding 'y (id 'x)) (binding 'z (num 3)))
             (op + (list (id 'x) (id 'y) (anD (list (bool true) (num 2)))))))

(test (parse '{with* {{x a 1} {y x} {z 3}}
                     {(+ x y (and true 2))}})
      "Binding [x a 1] mal formado")

#|

(printf "___________________________________________________________________________________________________________________________\nInician pruebas de la función desugar\n")
#| Pruebas de desugar|#

(test (desugar (parse '{cond {#t 1} {#f 2} {else 3}}))
      (iF (bool #t) (num 1) (iF (bool #f) (num 2) (num 3))))

(test (desugar (parse '{cond {(= 2 4) 5} {#t 6} {(<= 3 3) 7} {#f 8} {else 9}}))
      (iF (op = (list (num 2) (num 4))) (num 5) (iF (bool #t) (num 6) (iF (op <= (list (num 3) (num 3))) (num 7) (iF (bool #f) (num 8) (num 9))))))

(test
 (desugar
  (parse
   '{with {{x 1}
           {y 2}}
          {with* {{z 3}
                  {w z}}
                 {with {{f {fun {x} x}}}
                       {f {w}}}}}))
 (app (fun '(x y)
           (app (fun '(z)
                     (app (fun '(w)
                               (app (fun '(f)
                                         (app (id 'f)
                                              (list (id 'w))))
                                    (list (fun '(x) (id 'x)))))
                          (list (id 'z))))
                (list (num 3))))
      (list (num 1) (num 2))))

(printf "___________________________________________________________________________________________________________________________\nInician pruebas de la función interp\n")
#| Pruebas de interp|#

(test (prueba '3) (numV 3))

(test (prueba #t) (boolV #t))

(test/exn (prueba 'x) "lookup: Variable libre: x")

(test (prueba '{if {< 1 1} 5 6}) (numV 6))

(test (prueba '{if {< 1 2} 5 6}) (numV 5)) 

(test/exn (prueba '{if {fun {x} {+ x 1}} 5 6}) "interp: Símbolo no esperado. La condicional de if, no es un booleano")


(test (prueba'{cond {(= 2 2) 5} {#t 6} {(<= 3 3) 7} {#f 8} {else 9}}) (numV 5))

(test (prueba'{cond {(= 2 4) 5} {#t 6} {(<= 3 3) 7} {#f 8} {else 9}}) (numV 6))

(test (prueba'{cond {(= 2 4) 5} {#f 6} {(<= 3 3) 7} {#f 8} {else 9}}) (numV 7))

(test (prueba'{cond {(= 2 4) 5} {#f 6} {(< 3 3) 7} {#t 8} {else 9}}) (numV 8))

(test (prueba'{cond {(= 2 4) 5} {#f 6} {(< 3 3) 7} {#f 8} {else 9}}) (numV 9))


(test (prueba '{with {{x 5} {y 1}} {+ x y}}) (numV 6))

(test/exn (prueba '{with {{x 5} {y {+ x 1}}} {+ x y}}) "lookup: Hay un identificador libre: x")

(test (prueba '{with {{f {fun {x} {+ x x}}}} {f {3}}}) (numV 6)) 

(test/exn (prueba '{with {{x 3} {f {fun {a} {+ x a}}}}
                      {f {0}}}) "lookup: Hay un identificador libre: x")


(test (prueba '{with* {{x 5} {y 1}} {+ x y}}) (numV 6)) 

(test (prueba '{with* {{x 5} {y {+ x 1}}} {+ x y}}) (numV 11))

(test (prueba '{with* {{x 3}}
                      {with* {{f {fun {y} {+ x y}}}}
                             {with* {{x 4}}
                                    {f {1}}}}}) (numV 4)) 
(test (prueba '{with* {{x 1} {y 2} {z 3}}
                      {fun {x y z} {+ x {+ y z}}}})
      (closure '(x y z) (op + (list (id 'x) (op + (list (id 'y) (id 'z))))) (aSub 'z (numV 3) (aSub 'y (numV 2) (aSub 'x (numV 1) (mtSub))))))

(test (prueba '{with* {{x 3}
                       {f {fun {a} {+ x a}}}}
                      {f {0}}}) (numV 3))

(test (prueba '{{fun {x y} {+ x y}} {10 3}}) (numV 13)) 


(test (prueba '{with {{x 1}
                {y 2}}
               {with* {{z 3}
                       {w z}}
                      {with {{f {fun {x} x}}}
                            {f {w}}}}})
      (numV 3))

(test (prueba '{with* {{x 5}
                       {w {+ x 1}}
                       {z {with {{x 10}
                                 {f {fun {a} {+ x a}}}}
                                {f {10}}}}}
                      {+ x z}}) (numV 20))




(display "PRUEBAS TYPEOF\n______________________________________________________________________________________________________________________________\n\n")

(test (prueba '#t) (booleanT))

(test (prueba '2) (numberT))

(test (prueba '{+ 1 2}) (numberT))

(test/exn (prueba '{+ 1 #f}) "typeof: Error in parameter (boolS #f)\nExpected type: (numberT)\nGiven type: (booleanT)")

(test/exn (prueba '{and 1 #f}) "typeof: Error in parameter (numS 1)\nExpected type: (booleanT)\nGiven type: (numberT)")
                  
(test (prueba '{if #t 2 3}) (numberT))

(test (prueba '{with {{x : number 2} {y : boolean #t} {z : number 1}} {if y x z}}) (numberT))

(test/exn (prueba '{if #t 2 #t}) "typeof: Type error\nconditionals must have same type in then-expr and else-expr")

(test/exn (prueba '{cond {#t 2} {#f 3} {else #t}}) "typeof: Type error\nconditionals must have same type in then-expr and else-expr")

(test/exn (prueba '{if 3 2 #t}) "if: Type error\nConditional's test-expr type must be a boolean\nGiven: (numberT)")

(test (prueba '{fun {{x : number} {y : boolean}} : (number boolean -> number) {if y x 0}}) (funT (list (numberT) (booleanT) (numberT))))

(test/exn (prueba '{fun {{x : number} {y : number}} : (number number -> number) {if y x 0}}) "if: Type error\nConditional's test-expr type must be a boolean\nGiven: (numberT)")

(test (prueba '{{fun {{x : number} {y : boolean}} : (number boolean -> number) {if y x 0}} {2 #t}}) (numberT))

(test/exn (prueba '{{fun {{x : number} {y : boolean}} : (number boolean -> number) {if y x 0}} {2 3}})
          "app: Type error:\nParameter's type doesn't match expected types\nGiven: (numberT)\nExpected: (booleanT)")

|#