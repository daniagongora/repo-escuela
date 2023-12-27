#lang plai

;; Integrantes:
;; Clemente Herrera Karla
;; Salgado Tirado Diana Laura
;; Góngora Ranírez Dania Paula
;; Peña Nuñez Axel Yael

;; Definición del lenguaje WAE
 
;; Definición tipo Binding
(define-type Binding
  [binding (id symbol?) (value WBAE?)])

;; Tipo WAE
;;(define-type WAE
;;  [id (i symbol?)]
;;  [num (n number?)]
;;  [op (f procedure?) (args (listof WAE?))]
;;  [with (bindings (listof binding?)) (body WAE?)]
;;  [with* (bindings (listof binding?)) (body WAE?)])

;; En este archivo se deberán realizar los cambios correspondientes para que se extienda la gramática
;; del lenguaje WAE a la del lenguaje WBAE
;; Tipo WBAE
(define-type WBAE
  [id (i symbol?)]
  [num (n number?)]
  [bool (b boolean?)]
  [chaR (c char?)]
  [strinG (s string?)]
  [lst (l (listof WBAE?))]
  [op (f procedure?) (args (listof WBAE?))]
  [with (bindings (listof binding?)) (body WBAE?)]
  [with* (bindings (listof binding?)) (body WBAE?)])
