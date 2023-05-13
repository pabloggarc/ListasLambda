#lang racket
(require "enteros.rkt")

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

(define printLista ;Imprime una lista de enteros
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

(define printNumZ ;Imprime un numero entero
  (lambda (num)
    (display (church2Z num))
    )
  )

(define printNum
  (lambda (num)
    (display (church2N num))
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


(define maximum
  (lambda (lista)
    (((Y (lambda (f) ;Función recursiva 
           (lambda (l) 
             (lambda (maxActual)
               (((null l) ;Si la lista es vacía
                 (lambda (no_use)
                   maxActual ;El maximo es el maximo que lleve guardado
                   )
                 (lambda (no_use) ;Si no es vacía
                   ((f (tl l)) ((mayor (hd l)) maxActual)) ;El maximo es el mayor entre la cabeza y el maximo actual, y llamar a la función con el resto de la lista
                   )
                 )
                cero);Inicializo la variable que no usamos con un cero
               ))
           )
         )
      lista) ;Inicializo la variable l
     (hd lista)) ;Inicializo el maxActual con el valor más pequeño existente definido
    ))

(define minimum
  (lambda (lista)
    (((Y (lambda (f) ;Función recursiva 
           (lambda (l) 
             (lambda (minActual)
               (((null l) ;Si la lista es vacía
                 (lambda (no_use)
                   minActual ;El minimo es el maximo que lleve guardado
                   )
                 (lambda (no_use) ;Si no es vacía
                   ((f (tl l)) ((menor (hd l)) minActual)) ;El minimo es el menor entre la cabeza y el menor actual, y llamar a la función con el resto de la lista
                   )
                 )
                cero) ;Inicializo la variable que no usamos con un cero
               ))
           )
         )
      lista) ;Inicializo la variable l
     (hd lista)) ;Inicializo el minActual con el valor más alto existente definido
    ))


(define mayor
    (lambda (num1)
      (lambda (num2)
        (((esmayorent num1)num2) ;Si el num1 es mayor que el num2
         num1 ;Devuelvo el num1
         num2) ;Sino, devuelvo el num2
        )
      )
  )

(define menor
  (lambda (num1)
    (lambda (num2)
      (((esmenorent num1)num2)
       num1
       num2)
      )
    )
  )

(define apariciones
  (lambda (l)  ;lista
    (lambda (y)  ;elemento
      ((Y (lambda (f)
         (lambda (x)
          (((null x) ;si la lista esta vacia no habra ninguna aparicion
            (lambda (no_use)
              zero
            )
            (lambda (no_use) ;sino
              (((esigualent y) (hd x)) ;si la cabeza de la lista es el elemento que se esta buscando se suma 1 y se llama recursivamente
                (sucesor (f (tl x)))
                (f (tl x)) ;en caso contrario se devuelve el resultado de la funcion recursiva aplicada a la cola de la lista
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

(define sumaVectores
  (lambda (lista1) ;lista1
    (lambda (lista2) ;lista2
      (((Y (lambda (f)
         (lambda (l1)
           (lambda (l2)
          (((null l1)  ;si la lista 1 es vacía habrá que devolver la lista 2
            (lambda (no_use)
              l2
            )
            (lambda (no_use)
              ((null l2)  ;si la lista 2 es vacía habrá que devolver la lista 1
                l1
                ((cons ((sument (hd l1))(hd l2)))((f (tl l1))(tl l2)))  ;en caso de que haya elementos en las dos listas, habrá que devolver una nueva lista con la suma de las cabezas de ambas y la suma de las colas
              )
            )
          )
            zero)
        ))
      ))
        lista1) ;lista1 <- l1
       lista2); ;lista2 <- l2
    )
  )
 )

(define restaVectores
  (lambda (lista1) ;lista1
    (lambda (lista2) ;lista2
      (((Y (lambda (f)
         (lambda (l1)
           (lambda (l2)
          (((null l1)  ;si la lista 1 es vacía habrá que devolver la lista 2
            (lambda (no_use)
              l2
            )
            (lambda (no_use)
              ((null l2)  ;si la lista 2 es vacía habrá que devolver la lista 1
                l1
                ((cons ((restaent (hd l1))(hd l2)))((f (tl l1))(tl l2)))  ;en caso de que haya elementos en las dos listas, habrá que devolver una nueva lista con la suma de las cabezas de ambas y la suma de las colas
              )
            )
          )
            zero)
        ))
      ))
        lista1) ;lista1 <- l1
       lista2); ;lista2 <- l2
    )
  )
 )

(define multVectores
  (lambda (lista1) ;lista1
    (lambda (lista2) ;lista2
      (((Y (lambda (f)
         (lambda (l1)
           (lambda (l2)
          (((null l1)  ;si la lista 1 es vacía habrá que devolver la lista 2
            (lambda (no_use)
              l2
            )
            (lambda (no_use)
              ((null l2)  ;si la lista 2 es vacía habrá que devolver la lista 1
                l1
                ((cons ((prodent (hd l1))(hd l2)))((f (tl l1))(tl l2)))  ;en caso de que haya elementos en las dos listas, habrá que devolver una nueva lista con la suma de las cabezas de ambas y la suma de las colas
              )
            )
          )
            zero)
        ))
      ))
        lista1) ;lista1 <- l1
       lista2); ;lista2 <- l2
    )
  )
 )



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

El codigo recursivo sería:
((f nuevoParametro1)nuevoParametro2)

Avisos:
(((Y (lambda (f) -> Delante de Y hay tantos parentesis como parámetros en la función anónima más 1 (el de englobar todo)
Delante de la condición de dentro hay tantos paréntesis como condiciones más 1 (el de englobar todo)
Las variables anónimas en la función hay que inicializarlas aunque no se vayan a usar
|#





;; Listas de prueba
(define L1 ((cons uno) nil))
(define L2 ((cons uno)((cons cero)((cons dos)nil))))
(define L3 ((cons uno)((cons cero)((cons dos)nil))))
(define L4 ((cons uno)((cons dos)((cons tres)((cons cuatro)nil)))))
(define L5 ((cons dos)((cons dos)((cons uno)nil))))


;Ejecución del programa:
(define ejecutar 
  (begin ;A partir de aquí podemos poner todas las funciones del programa para que ejecuten directamente
   ;Podemos ponerle nosotros los valores que queremos predeterminados para cada función

     ;(display (format "Suma de los valores de la lista: ~a \n"  L3)) El formato este sirve para incluir el valor L3 como texto puro (como una lista es un procedimiento no se puede pero con numeros se podría
    (display "Suma de los valores de la lista L3: ")
    (printLista L3)
    (printNumZ (sumaL L3)) 
    (display "\nSuma de los vectores L3 y L4: \n")
    
    (printLista L3) (printLista L4)
    (display "Resultado: ")
    (printLista ((sumaVectores L3)L4))
    (display "\n")

    ;Aquí podemos poner todas las operaciones que queramos directamente
    ;Gracias al begin se ejecuta solo directamente

    
    )
  )