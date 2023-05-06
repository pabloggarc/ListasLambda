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

(or #f #t) ; Se pueden pasar más parametros/ Tenemos nor 
(and #f #t);Se pueden pasar más parámetros/ Tenemos nand
(xor #f #t); Solo se le pueden pasar 2 parámetros

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
(display "Mi cadena\n") ; Se imprime sin las comillas
(display "Él me dijo \"si\"\n"); Formato de siempre, Caracter de escape: \ -> Se puede \n salto de linea

;Estructuras de datos esenciales: Pares y listas
; Construir un par:
(cons 1 2)
'(1 . 2) ; La comilla simple es para que no se crea que es una funcion

(define par (cons 1 2))
(car par) ; Primer elemento -> first , second, third... tenth
(cdr par) ;Segundo elemento -> rest (El resto de elementos) , last (El ultimo)



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

;Operaciones de listas
(list 1 2 3 4 5 6) ; Crear lista -> También se puede '(1 2 3 4 5 6)
(pair? '(1.2)) ;Es un par? (pair? '(1 2 3)) Una lista es un par -> #t
(list? '(1 2 3)); Es una lista? (list? '(1 . 2)) Un par no es una lista -> #f

(define miLista (list 1 2 3 4 5 6 7 8 9 10 11)) ; cadr (second) caddr (third) sirve para acortar  hay hasta caddddr lista
(display "miLista: ")
(display miLista)
(display "\n")
(list-ref lista 0) ; Posicion a la que quieres aceder -> es como nth
(length lista)
(define lista2 (list 1 2))
(define lista3 (list 1 2 3))
(append lista2 lista3)
(reverse lista2)
(member 5 miLista) ;Si está en la lista devuelve la lista a partir de ese elemento, sino -> devuelve false
(member 5 lista2)
(not (boolean? (member 5 lista2))) ;Con esto puedo saber si un elemento está o no en la lista
(not (boolean? (member 5 miLista)))
;Como member no devuelve true sino la lista, cuando devuelve un booelano será false
;Entonces si devuelve booleano es true -> not booleano será false -> No está en la lista
;Si devuelve una lista -> No es booleano -> not no booleano será true -> Si está en la lista

;(map func miLista) ;Devuelve una lista ha aplicado func a cada elemento
(add1 2) ; El sucesor de un número
(map add1 lista2)

(map + lista2 (list 3 4)) ;suma el primer elemento de lista2 con el primero de list y el segundo con el segundo
;(andmap funcBOOOL lista lista) -> Si todas las funciones que devuelve son verdaderas devuelve true
; ormap funcionamiento igual que el or con el map

(define (menor-cuatro n) (< n 4))
(ormap menor-cuatro miLista)

;filter devuelve elementos que cumplen una condicion
;(filter funcBOOL lista)
(filter menor-cuatro miLista)

;Ejemplo de recurisividad
(define (factorial x)
  (if (= x 0) 1
      (* x (factorial (- x 1))))) ;No tiene en cuenta negativos ni nada
(factorial 5)

;Recurisividad con lisas:
#| sumarlista l = 0 si '()
                  (car l) + sumarlista(cdr l)) si no vacia
|#
(define (sumarlista l)
  (if (empty? l) 0
  (+ (first l) (sumarlista(rest l))))) ;first = car ;rest=cdr
(sumarlista lista3)

(define (que-soy x)
  (cond ;Para quitar los ifs anidados
    [(string? x) "String"]
    [(number? x) "numero"]
    [(boolean? x) "booleano"]
    [(char? x) "caracter"]
    [else "no se lo que soy"]))

(que-soy miLista)

;(apply FUNC lista)
(apply + miLista) ; Le applica la funcion a todos los elementos de la lista -> Para no tener que usar el sumarlista

;Aridad multiple en funciones (funciones con un número desconocido de parametros
(define (media2 lista)
  (/ (sumarlista lista) (length lista)))
(define (media3 lista) ;Se tendrá que llamar (media3 (list 1 2 3 4 5))
  (/ (apply + lista) (length lista)))

;(define (funcion . lista) lista) ;el identificador(funcion) los parametros(lista)
(define (media4 . lista) ;Ya se puede llamar directamente: (media4 1 2 3 4 5)
  (/ (apply + lista) (length lista)))

;Funciones anonimas -> Funciones lambda

(define (perimetro a b) ;Identificador inutil solo lo uso en una funcion
  (+ (* a 2) (* b 2)))

(define (dame-perimetros aes bees)
  (map perimetro aes bees))

(define (dame-perimetros2 as bs)
  (map (lambda (x y) ;Se usa la funcion lambda para quitarse la funcion inutil que se usa una vez
         (+ (* x 2) (* y 2)))))
;(lambda lista-par cuerpo)
((lambda (x) x) 5)


