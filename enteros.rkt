#lang racket

; Booleanos
(define true (lambda (x y) x))

(define false (lambda (x y) y))

(define neg (lambda (x) (x false true)))
                         
(define and (lambda (x y) (x y false)))

(define or (lambda (x y) (x true y)))

; Pares ordenados
              
(define par (lambda (x)
              (lambda (y)
                (lambda (f) (f x y)))))

(define primero (lambda (p) (p true)))

(define segundo (lambda (p) (p false)))

;;;;; Combinador de punto fijo

(define Y
  (lambda (f)
    ((lambda (x) (f (lambda (v) ((x x) v))))
     (lambda (x) (f (lambda (v) ((x x) v)))))))

;;;;;; Orden en naturales y test de nulidad

(define esmenoroigualnat (lambda (n)
                             (lambda (m)
                                (escero ((restanat n) m)))))
                         
(define esmayoroigualnat (lambda (n)
                            (lambda (m)
                               (escero ((restanat m) n)))))
                         
(define esmenornat (lambda (n)
                     (lambda (m)
                       (and ((esmenoroigualnat n) m) (noescero ((restanat m) n))))))

(define esmayornat (lambda (n)
                     (lambda (m)
                       (and ((esmayoroigualnat n) m) (noescero ((restanat n) m))))))

(define esigualnat (lambda (n)
                     (lambda (m)
                       (and ((esmayoroigualnat n) m) ((esmenoroigualnat n) m)))))

(define escero (lambda (n)
                 ((n (lambda (x) false)) true)))

(define noescero (lambda (n)
                    (neg (escero n))))

; Aritmética natural. Se define también comprobar para verificar que la cosa va bien. Defino algunos naturales para hacer comprobaciones. Los escribo en francés para distinguirlos de los enteros 
; que escribiré en español.

(define zero (lambda (f)
               (lambda (x) x)))

(define sucesor (lambda (n)
                  (lambda (f)
                    (lambda (x)
                     (f((n f) x))))))

(define un (sucesor zero))

(define deux (sucesor un))

(define trois (sucesor deux))

(define quatre (sucesor trois))

(define cinq (sucesor quatre))

(define six (sucesor cinq))

(define sept (sucesor six))

(define huit (sucesor sept))

(define neuf (sucesor huit))

(define dix (sucesor neuf))

(define onze (sucesor dix))

(define douze (sucesor onze))

(define treize (sucesor douze))

(define quatorze (sucesor treize))

(define quinze (sucesor quatorze))

(define seize (sucesor quinze))

(define dix-sept (sucesor seize))

(define dix-huit (sucesor dix-sept))

(define dix-neuf (sucesor dix-huit))

(define vingt (sucesor dix-neuf))

(define comprobar (lambda (n)
                    ((n (lambda (x) (+ 1 x))) 0)))

(define sumnat (lambda (n)
                 (lambda (m)
                   ((n (lambda (x) (sucesor x))) m))))

(define prodnat (lambda (n)
                   (lambda (m)
                     (lambda (f)
                       (lambda (x) ((m (n f)) x))))))
                     
(define prefn (lambda (f)
                (lambda (p)
                  ((par (f (primero p))) (primero p)))))

(define predecesor (lambda (n)
                     (lambda (f)
                       (lambda (x)
                            (segundo ((n ((lambda (g)
                                             (lambda (p) ((prefn g) p))) f)) ((par x) x)))))))
                         
(define restanat (lambda (n)
                     (lambda (m)
                        ((m (lambda (x) (predecesor x))) n))))                                                 

(define restonataux
    (lambda (n)
        (lambda (m)
            ((Y (lambda (f)
                 (lambda (x)
                    ((((esmayoroigualnat x) m)  
                        (lambda (no_use)
                            (f ((restanat x) m))
                        )
                        (lambda (no_use)
                            x
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                )
            ))
                n)  ; Pasa n como el valor inicial de x.
        )
))

(define restonat (lambda (n)
                      (lambda (m)
                        (((escero m) (lambda (no_use) false) (lambda (no_use) ((restonataux n) m))) zero))))


(define cocientenataux
    (lambda (n)
        (lambda (m)
            ((Y (lambda (f)
                (lambda (x)
                    ((((esmayoroigualnat x) m)  
                        (lambda (no_use)
                            (sucesor (f ((restanat x) m)))  
                        )
                        (lambda (no_use)
                            zero
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                )
            ))
                n)  ; Pasa n como el valor inicial de x.
        )
    )
)

(define cocientenat (lambda (n)
                      (lambda (m)
                        (((escero m) (lambda (no_use) false) (lambda (no_use) ((cocientenataux n) m))) zero))))


(define mcdnat
    (lambda (n)
        (lambda (m)
            (((Y (lambda (f)
                   (lambda (x)
                     (lambda(y)
                      (((escero y)  
                       (lambda (no_use)
                            x
                        ) 
                       (lambda (no_use)
                            ((f y)((restonat x) y)) 
                        )
                        
                    )
                        zero)    ; Pasa zero como argumento de no_use
                ))
            ))
                n) ; Pasa n como el valor inicial de x.
          m)       ; Pasa m como el valor inicial de y.
    )
))

;;;;;; Definición de algunos enteros

(define cero ((par zero) zero))

(define -uno ((par zero) un))

(define -dos ((par zero) deux))

(define -tres ((par zero) trois))

(define -cuatro ((par zero) quatre))

(define -cinco ((par zero) cinq))

(define -seis ((par zero) six))

(define -siete ((par zero) sept))

(define -ocho ((par zero) huit))

(define -nueve ((par zero) neuf))

(define -diez ((par zero) dix))

(define -once ((par zero) onze))

(define -doce ((par zero) douze))

(define -trece ((par zero) treize))

(define -catorce ((par zero) quatorze))

(define -quince ((par zero) quinze))

(define -dieciseis ((par zero) seize))

(define -diecisiete ((par zero) dix-sept))

(define -dieciocho ((par zero) dix-huit))

(define -diecinueve ((par zero) dix-neuf))

(define -veinte ((par zero) vingt))

(define uno ((par un) zero))

(define dos ((par deux) zero))

(define tres ((par trois) zero))

(define cuatro ((par quatre) zero))

(define cinco ((par cinq) zero))

(define seis ((par six) zero))

(define siete ((par sept) zero))

(define ocho ((par huit) zero))

(define nueve ((par neuf) zero))

(define diez ((par dix) zero))

(define once ((par onze) zero))

(define doce ((par douze) zero))

(define trece ((par treize) zero))

(define catorce ((par quatorze) zero))

(define quince ((par quinze) zero))

(define dieciseis ((par seize) zero))

(define diecisiete ((par dix-sept) zero))

(define dieciocho ((par dix-huit) zero))

(define diecinueve ((par dix-neuf) zero))

(define veinte ((par vingt) zero))

;;;;; Orden, valor absoluto y tests de nulidad, positividad y negatividad. 
;;;
;;; m-n > m'-n' si y solo si m+n' > m'+n e igual con el resto

(define esmayoroigualent (lambda (r)
                           (lambda (s)
                             ((esmayoroigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r)))))) 

(define esmenoroigualent (lambda (r)
                           (lambda (s)
                             ((esmenoroigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esmayorent (lambda (r)
                           (lambda (s)
                             ((esmayornat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esmenorent (lambda (r)
                           (lambda (s)
                             ((esmenornat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esigualent (lambda (r)
                           (lambda (s)
                             ((esigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define absoluto (lambda (r)
                    (((esmayoroigualnat (primero r)) (segundo r)) ((par ((restanat (primero r)) (segundo r))) zero) ((par ((restanat (segundo r)) (primero r))) zero))))

(define negativo (lambda (r)
                   ((esmenorent r) cero)))

(define positivo (lambda (r)
                   ((esmayorent r) cero)))

(define esceroent (lambda (r)
                     ((esigualnat (primero r)) (segundo r))))
                      
(define noesceroent (lambda (r)
                       (neg (esceroent r))))

;;;;; Reducción a representante canónico de la clase de equivalencia.

(define reducir (lambda (r)
                  (((esmayoroigualnat (primero r)) (segundo r)) 
                        ((par ((restanat (primero r)) (segundo r))) zero)
                        ((par zero) ((restanat (segundo r)) (primero r))))))

;;;;; Aritmética entera. La respuesta está siempre dada por el representante canónico de la clase de equivalencia. 

(define testenteros (lambda (r)
                      (- (comprobar (primero r)) (comprobar (segundo r)))))

(define sument (lambda (r)
                  (lambda (s)
                    (reducir ((par ((sumnat (primero r)) (primero s))) ((sumnat (segundo r)) (segundo s)))))))

(define prodent (lambda (r)
                  (lambda (s)
                    (reducir ((par ((sumnat ((prodnat (primero r)) (primero s))) ((prodnat (segundo r)) (segundo s))))
                          ((sumnat ((prodnat (primero r)) (segundo s))) ((prodnat (segundo r)) (primero s))))))))                       

(define restaent (lambda (r)
                   (lambda (s)
                     (reducir ((par ((sumnat (primero r)) (segundo s))) ((sumnat (segundo r)) (primero s)))))))

;; Lo siguiente reduce la división de enteros a división de naturales. Si m \ge 0 y n> 0, y si q y r son cociente y resto de la división de m entre n, se tiene
;;  m  = q       * n        + r
;;  m  = (-q)    * (-n)     + r
;; -m  = (-(q+1))* n        + (n-r)
;; -m  = (q+1)   * (-n)     + (n-r),
;; siempre y cuando el resto no sea cero. Cuando el divisor es cero, la función cocienteent devuelve false.

(define cocienteent_aux (lambda (r)
                          (lambda (s)
                            ((cocientenat (primero (absoluto r))) (primero (absoluto s))))))

; Caso1: resto cero. Si m= q*n, entonces -m= (-q)*n, -m = q* (-n) y m= (-q)*(-n).

(define cocienteentaux-caso1 (lambda (r)
                               (lambda (s)
                                  ((or (and ((esmayoroigualent r) cero) (positivo s)) (and (negativo r) (negativo s))) ((par ((cocientenat (primero (absoluto r))) (primero (absoluto s)))) zero)
                                                                                                                       ((par zero) ((cocientenat (primero (absoluto r))) (primero (absoluto s))))))))
                              
; Caso 2: resto no nulo

(define cocienteentaux-caso2 (lambda (r)
                                (lambda (s)
                                    (((esmayoroigualent r) cero) ((positivo s) ((par ((cocienteent_aux r) s)) zero) ((par zero) ((cocienteent_aux r) s)))
                                                                 ((positivo s) ((par zero) (sucesor ((cocienteent_aux r) s))) ((par (sucesor ((cocienteent_aux r) s))) zero))))))
; Cociente cuando no hay división por cero

(define cocienteentaux (lambda (r)
                         (lambda (s)
                           ((escero ((restonat (primero (absoluto r))) (primero (absoluto s)))) ((cocienteentaux-caso1 r) s) ((cocienteentaux-caso2 r) s)))))

; Cociente considerando la división por cero

(define cocienteent (lambda (r)
                      (lambda (s)
                        (((esceroent s) (lambda (no_use) false) (lambda (no_use) ((cocienteentaux r) s))) zero))))

; Resto. Si se divide por cero, devuelve false

(define restoentaux1 (lambda (r)
                        (lambda (s)
                          ((or (and ((esmayoroigualent r) cero) (positivo s)) (and ((esmayoroigualent r) cero) (negativo s))) ((par ((restonat (primero (absoluto r))) (primero (absoluto s)))) zero)
                                                                                                           ((par ((restanat (primero (absoluto s)))((restonat (primero (absoluto r))) (primero (absoluto s))))) zero)))))

(define restoentaux (lambda (r)
                       (lambda (s)
                          ((escero ((restonat (primero (absoluto r))) (primero (absoluto s)))) cero ((restoentaux1 r) s)))))

(define restoent (lambda (r)
                      (lambda (s)
                        (((esceroent s) (lambda (no_use) false) (lambda (no_use) ((restoentaux r) s))) zero))))

;; Como mcd (r,s)=mcd(|r|,|s|), se tiene

(define mcdent (lambda (r)
                 (lambda (s)
                   ((par ((mcdnat (primero (absoluto r))) (primero (absoluto s)))) zero))))

;; Codificación de Church a decimal

(define church2N (lambda (n)
                      ((n add1) 0)))
(define (church2Z i)
  ((positivo i)
      (((primero i) add1) 0)
      (((segundo i) sub1) 0)
  ))

;; Listas

(define nil (lambda (z) z))

(define cons (lambda (x)
              (lambda (y)
                ((par false) ((par x) y)))))

(define null primero)

(define hd (lambda (z)
             (primero (segundo z))))

(define tl (lambda (z)
             (segundo (segundo z))))

(define printZ
  (lambda (l) (display "[")
    ((Y (lambda (f)
      (lambda (x)
        (((null x) ; lista vacía?
          (lambda (no_use) ;Sí? -> Fin de lista
            (display "nil]\n")
          )
          (lambda (no_use) ;No? -> Muestra la cabeza, muestra la cola
            (begin
              (display (church2Z (hd x)))
              (display ", ")
              (f (tl x))
            )
          )
        )
        zero)  ; no_use <- x
      )
    ))
    l) ; x <- l
  )
)


(define long
  (lambda (l)
      ((Y (lambda (f)
         (lambda (x)
          (((null x)
            (lambda (no_use)
              zero
            )
            (lambda (no_use)
              (sucesor (f (tl x)))
            )
          )
            zero)  ; no_use <- x
        )
      ))
        l) ; x <- l
    )
)

(define in
  (lambda (l)
    (lambda (y)
      ((Y (lambda (f)
         (lambda (x)
          (((null x) ; <- Nada pertence a nil
            (lambda (no_use)
              false
            )
            (lambda (no_use)  ; <- Cabeza == y?
              (((esigualent y) (hd x))
                true
                (f (tl x))  ; si no, y pertenece a cola?
              )
            )
          )
            zero)  ; no_use <- x
        )
      ))
        l) ; x <- l
    )
  )
)

(define sumaL
  (lambda (l)
      ((Y (lambda (f)
         (lambda (x)
          (((null x) ; Suponemos que suma([]) = 0
            (lambda (no_use)
              zero
            )
            (lambda (no_use)
              ((sument (hd x))(f (tl x))) ; cabeza + suma(cola)
            )
          )
            zero)  ; no_use <- x
        )
      ))
        l) ; x <- l
    )
)

(define concatNumList ;Concatena un número por la izquierda a una lista -> ((concatNumList L3) cinco)
  (lambda (l)
    (lambda (n)
      ((cons n )l))))



(define reverse
  (lambda (l) ;Le mando la lista
    (((Y (lambda (f)
          (lambda (lista) ;La lista 
            (lambda (resultado) ;Donde voy a ir guardando el resultado
              (((null lista) ;Si la lista es vacía devuelvo el resultado
                (lambda (no_use)
                  resultado
                  )
                (lambda (no_use) ;Si no es vacía
                  ;((f (tl lista))((concatNumList resultado)(hd lista)))
                  ((f (tl lista))((cons (hd lista))resultado)) ;LLamo recursivamente con la cola de la lista y al resultado le concateno por la izquierda la cabeza de la lista
                  
                  )
                )
               cero) ;Inicializo la variable no_use que no voy a usar
              )
            )
          ))
      l) ;Inicializo la lista con la lista pasada
    nil) ;Inicializo el resultado a nil porque todavía no hay nada
    )
  )



(define append ;concatena la segunda lista al final de la primera
  (lambda (lista1) 
    (lambda (lista2)
      (((Y (lambda (f)
             (lambda (l1) 
               (lambda (l2)
                 (((null l1) ;Si la segunda está vacía
                   (lambda (no_use)
                     l2 ;Devuelvo la primera
                     )
                   (lambda (no_use) ;sino
                    
                     ((cons (hd l1))((f (tl l1))l2)) ;pongo la cabeza de la segunda a lo que quede de llamar recurisvamente -> lista1 
                     
                     )
                   )
                  cero) ;Inicializo variable no_use a cero  -> NO la voy a usar
                 ))
             ))
        lista1) ;Inicializo el valor de l1 por lista1
       lista2) ;Inicializo el valor de l2 por lista2
      )
    ))

#|
La estructura:
lambda (l)
 lambda (x)
  lambda (...) Para que coja el número de parametros, l , x son 2 parametros que necesita la funcion

((Y (lambda (f) ;Funcion anonima
     (lambda (parametro1) ;parametros que se le pasan
        (lambda (parametro2)
          (condicion1)
            (lambda (no_use)
            (codigoCondicion1)
             )
            (lambda (no_use)
            (codigoCondicion2) ;Codigo si no se cumple la condicion1
             )
      )Codigo que llama a ejecutar la función anónima -> Hay que mandarle el número de parámetros correspondientes
)
)

Avisos:
(((Y (lambda (f) -> Delante de Y hay tantos parentesis como parámetros en la función anónima más 1 (el de englobar todo)
Delante de la condición de dentro hay tantos paréntesis como condiciones más 1 (el de englobar todo)
Las variables anónimas en la función hay que inicializarlas aunque no se vayan a usar
|#





;; Listas de prueba
(define L1 ((cons un) nil))
(define L2 ((cons un)((cons zero)((cons deux)nil))))
(define L3 ((cons uno)((cons cero)((cons dos)nil))))
(define L4 ((cons uno)((cons dos)((cons tres)((cons cuatro)nil)))))
