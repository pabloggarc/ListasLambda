; ejemplos básicos de elementos en racket
; documentación de referencia en https://docs.racket-lang.org/index.html

; cadenas de caracteres, e impresión por e/s estándar
"hello world"

; definición de variables y funciones
(define dos 2)
(define (doble num)
  (* 2 num))

; definición de listas
(define lst '(a b c d))
(list 1 2 3)
(define lista (list 5 6 7 8))

; listas: primer elemento y resto, con e/s
lst
(car lst)
(cdr lst)
(car (cdr lst))

; funciones recursivas y e/s
(define (longitud lista)
  (if (equal? lista '())
      0
      (+ 1 (longitud (cdr lista)))))

(longitud lst)

(define (perimetro a b)
  (+ (* a 2) (* b 2)))

(define (dame-perimetros aes bees)
  (map perimetro aes bees))

(dame-perimetros (list 3 4 5) (list 4 5 6))

; funciones anónimas o lambda (lambda lista-par cuerpo)
((lambda (x) x) 5)
((lambda (x y) (+ x y)) 5 4)

(define (dame-perimetros as bs)
  (map (lambda (x y) (+ (* x 2) (* y 2))) as bs))

; funciones que devuelven funciones con lambda
; versión normal
(define (saludo el-saludo nombre)
  (string-append el-saludo "," nombre))
(saludo "hola" "juan")
; versión con lambda devolviendo puntero a procedimiento/función
(define (construir-saludo saludo)
  (lambda (nom)
    (string-append saludo ", " nom)))
(construir-saludo "hola")
((construir-saludo "hola") "amigos")