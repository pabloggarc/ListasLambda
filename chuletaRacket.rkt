#lang racket
;Comentarios
#| Comentario
multilinea
|#

(define valor 42) ;definiciones constantes
(define nombreFuncion valor)
nombreFuncion

; media : a,b -> (a+b)/2
;() es una lista con varios elementos separados con espacios
(define (media a b)
  (/ (+ a b) 2))
(media 3 5)

#f ; booleano false -> false devuelve #false
#t ;booleano true -> true devueve #t

(define (sumar a b c)
  (+ a b c))
(sumar 3 4 5)

(or #f #t)
(and #f #t)

(if #t "A" "B") ; -> Devuelve "A"
(if #f "A" "B") ; -> Devuelve "B"

(exact? 5) ; Devuelve true si el número es exacto -> exact? 5.5 devuelve #false
(inexact? 2.5+3.0i) ; True si no es exacto
;+inf.0 -> más infinito
;-inf.0 -> menos infinito
; 2.5+3.0i -> Numeros complejos
;5.25e8 -> Exponenciales

(number? 5); True si es un número

#\a ; el caracter a -> Se puede también escribir un caracter en unicode
(char? #\a) ; Devuelve true si es un char

"Cadena unica"
(display "Mi cadena") ; Se imprime sin las comillas
(display "Él me dijo \"si\"\n"); Formato de siempre, Caracter de escape: \ -> Se puede \n salto de linea

;Estructuras de datos esenciales: Pares y listas
; Construir un par:
(cons 1 2)
'(1 . 2) ; La comilla simple es para que no se crea que es una funcion

(define par (cons 1 2))
(car par) ; Primer elemento
(cdr par) ;Segundo elemento

(define par2 (cons "primero" "segundo"))
(car par2) ; (car (cons ("primero" "segundo")))
(cdr par2)
(cons (cons 1 2) (cons 3 4)) ; par de pares

;Lista -> Como ArrayList -> No sbs cuantos elementos va a haber en total

(define lista (cons 1 (cons 2 (cons 3 (cons 4 null))))) ;-> Una forma muy mala de crear listas 
lista
; Se puede ir recorriendo así:
(car lista)
(cdr lista)
(car(cdr lista))
(cdr (cdr lista))
(car (cdr (cdr lista)))
(cdr (cdr (cdr lista)))


(list 1 2 3 4 5 6) ; Crear lista -> También se puede '(1 2 3 4 5 6)
(pair? '(1.2)) ;Es un par? (pair? '(1 2 3)) Una lista es un par -> #t
(list? '(1 2 3)); Es una lista? (list? '(1 . 2)) Un par no es una lista -> #f