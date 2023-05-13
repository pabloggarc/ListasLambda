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


<<<<<<< Updated upstream
(define long ;(printNum (long L3))
  (lambda (l)
=======
;;Funcionalidades de las listas

;longitud de la lista l
(define long
  (lambda (l) ;lista
>>>>>>> Stashed changes
      ((Y (lambda (f)
         (lambda (x)
          (((null x) ;si es una lista vacía devolvemos longitud 0
            (lambda (no_use)
              zero
            )
            (lambda (no_use)  ;si no es vacía añadimos 1 a la longitud de la cola
              (sucesor (f (tl x)))
            )
          )
            zero)
        )
      ))
        l) ; x <- l
    )
)

<<<<<<< Updated upstream
(define in ; (display ((in L3)dos)) ó ((in L3)dos)
  (lambda (l)
    (lambda (y)
=======
;test de pertenencia de un elemento y en la lista l
(define in
  (lambda (l) ;lista
    (lambda (y) ;elemento
>>>>>>> Stashed changes
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

;Suma de los elementos de una lista l
(define sumaL
  (lambda (l) ;lista
      ((Y (lambda (f)
         (lambda (x)
          (((null x) ; Suponemos que suma([]) = 0
            (lambda (no_use)
              zero
            )
            (lambda (no_use) ;sino
              ((sument (hd x))(f (tl x))) ; cabeza + suma(cola)
            )
          )
            zero)
        )
      ))
        l) ; x <- l
    )
)

;Concatenacion de un elemento n por la izquierda de una lista l
(define concatNumList 
  (lambda (l) ;lista
    (lambda (n) ;elemento
      ((cons n )l))))

;Inversión de una lista l
(define reverse
  (lambda (l) ;Lista
    (((Y (lambda (f)
          (lambda (lista)
            (lambda (resultado) ;Donde se va a ir guardando la inversión
              (((null lista) ;Si la lista es vacía se devuelve el resultado
                (lambda (no_use)
                  resultado
                  )
                (lambda (no_use) ;Si no es vacía
                  ((f (tl lista))((cons (hd lista))resultado)) ;Sino se llama recursivamente con la cola y la variable resultado que llevamos hasta ahora con la cabeza de la lista delante
                  
                  )
                )
               cero) 
              )
            )
          ))
      l) ; lista <- l
    nil) ; resultado <- nil
    )
  )

;Concatenar una lista l2 a la derecha de otra lista l1
(define append ;concatena la segunda lista al final de la primera
  (lambda (lista1) 
    (lambda (lista2)
      (((Y (lambda (f)
             (lambda (l1) 
               (lambda (l2)
                 (((null l1) ;Si l1 está vacía
                   (lambda (no_use)
                     l2 ;Se devuelve l2
                     )
                   (lambda (no_use) ;sino
                    
                     ((cons (hd l1))((f (tl l1))l2)) ;se pone la cabeza de l1 a lo que quede de llamar recurisvamente 
                     
                     )
                   )
                  cero)
                 ))
             ))
        lista1) ; l1 <- lista1
       lista2) ; l2 <- lista2
      )
    ))

;Elemento maximo de una lista
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
                cero)
               ))
           )
         )
      lista) ;l <- lista
     (hd lista)) ;Inicializo el maxActual con el valor más pequeño existente definido
    ))

;Elemento minimo de una lista
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
                cero) 
               ))
           )
         )
      lista) ;l <- lista
     (hd lista)) ;Inicializo el minActual con el valor más alto existente definido
    ))


;Devuelve el mayor de dos numeros
(define mayor
    (lambda (num1)
      (lambda (num2)
        (((esmayorent num1)num2) ;Si el num1 es mayor que el num2
         num1 ;Devuelvo el num1
         num2) ;Sino, devuelvo el num2
        )
      )
  )

;Devuelve el menor de dos numeros
(define menor
  (lambda (num1)
    (lambda (num2)
      (((esmenorent num1)num2)
       num1
       num2)
      )
    )
  )

<<<<<<< Updated upstream
(define apariciones ;(printNum ((apariciones L4)dos)) -> Si se devolviera cero cuando la lista es vacía habría que usar printNumZ
=======
;Contar apariciones de un elemento y, en una lista l
(define apariciones
>>>>>>> Stashed changes
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
            zero)   
        )
      ))
        l) ; x <- l
    )
  )
)

<<<<<<< Updated upstream
(define sumaVectores ;(printLista ((sumaVectores L3)L4))
=======
;Suma de elementos de dos listas 
(define sumaVectores
>>>>>>> Stashed changes
  (lambda (lista1) ;lista1
    (lambda (lista2) ;lista2
      (((Y (lambda (f)
         (lambda (x)
           (lambda (y)
          (((null x)  ;si la lista 1 es vacía habrá que devolver la lista 2
            (lambda (no_use)
              y
            )
            (lambda (no_use)
              ((null y)  ;si la lista 2 es vacía habrá que devolver la lista 1
                x
                ((cons ((sument (hd x))(hd y)))((f (tl x))(tl y)))  ;en caso de que haya elementos en las dos listas, habrá que devolver una nueva lista con la suma de las cabezas de ambas y la suma de las colas
              )
            )
          )
            zero)
        ))
      ))
        lista1) ;x <- lista1
       lista2) ;y <- lista2
    )
  )
 )

<<<<<<< Updated upstream
(define restaVectores ;(printLista ((restaVectores L3)L4))
=======
;Resta de elementos de dos listas 
(define restaVectores
>>>>>>> Stashed changes
  (lambda (lista1) ;lista1
    (lambda (lista2) ;lista2
      (((Y (lambda (f)
         (lambda (x)
           (lambda (y)
          (((null x)  ;si la lista 1 es vacía habrá que devolver la lista 2
            (lambda (no_use)
              y
            )
            (lambda (no_use)
              ((null y)  ;si la lista 2 es vacía habrá que devolver la lista 1
                x
                ((cons ((restaent (hd x))(hd y)))((f (tl x))(tl y)))  ;en caso de que haya elementos en las dos listas, habrá que devolver una nueva lista con la resta de las cabezas de ambas y la resta de las colas
              )
            )
          )
            zero)
        ))
      ))
        lista1) ;x <- lista1
       lista2) ;y <- lista2
    )
  )
 )

<<<<<<< Updated upstream
(define multVectores ;(printLista ((multVectores L3)L4))
=======
;Producto de elementos de dos listas 
(define productoVectores
>>>>>>> Stashed changes
  (lambda (lista1) ;lista1
    (lambda (lista2) ;lista2
      (((Y (lambda (f)
         (lambda (x)
           (lambda (y)
          (((null x)  ;si la lista 1 es vacía habrá que devolver la lista 2
            (lambda (no_use)
              y
            )
            (lambda (no_use)
              ((null y)  ;si la lista 2 es vacía habrá que devolver la lista 1
                x
                ((cons ((prodent (hd x))(hd y)))((f (tl x))(tl y)))  ;en caso de que haya elementos en las dos listas, habrá que devolver una nueva lista con el producto de las cabezas de ambas y el producto de las colas
              )
            )
          )
            zero)
        ))
      ))
        lista1) ;x <- lista1
       lista2) ;y <- lista2
    )
  )
 )

;Sustituir todas las apariciones de un elemento x en la lista l por y.
(define sustituir
  (lambda (l)  ;lista
    (lambda (x)  ;elemento
      (lambda (y)
      ((Y (lambda (f)
         (lambda (l1)
          (((null l1) ;si la lista esta vacia no habra ninguna aparicion
            (lambda (no_use)
              l1
            )
            (lambda (no_use) ;sino
              (((esigualent x) (hd l1)) ;si la cabeza de la lista es el elemento que se esta buscando se suma 1 y se llama recursivamente
                ((cons y)(f (tl l1)))
                ((cons (hd l1))(f (tl l1))) ;en caso contrario se devuelve el resultado de la funcion recursiva aplicada a la cola de la lista
              )
            )
          )
            zero)  ; no_use <- x
        )
      ))
        l) ; l1 <- l
    )
  )
 )
)

;Elimina la primera aparicion de un elemento y en la lista l
(define eliminarPrimeraAparicion
  (lambda (l)  ;lista
    (lambda (y)  ;elemento
      ((Y (lambda (f)
         (lambda (l1)
          (((null l1) ;si la lista esta vacia no habra ninguna aparicion
            (lambda (no_use)
              l1
            )
            (lambda (no_use) ;sino
              (((esigualent y)(hd l1)) ;si la cabeza de la lista es el elemento que se esta buscando se suma 1 y se llama recursivamente
                (tl l1)
                ((cons (hd l1))(f (tl l1))) ;en caso contrario se devuelve el resultado de la funcion recursiva aplicada a la cola de la lista
              )
            )
          )
            zero)  ; no_use <- x
        )
      ))
        l) ; l1 <- l
    )
  )
)

;Ordenar una lista de mayor a menor
(define ordenarMayorMenor
  (lambda (l)  ;lista
      ((Y (lambda (f)
         (lambda (l1)
          (((null l1) ;si la lista esta vacia no habra ninguna aparicion
            (lambda (no_use)
              l1
            )
            (lambda (no_use) ;sino
              ((cons (maximum l1))(f ((eliminarPrimeraAparicion l1)(maximum l1))))
            )
          )
            zero)  ; no_use <- x
        )
      ))
        l) ; x <- l
    )
)

;Ordenar una lista de menor a mayor
(define ordenarMenorMayor
  (lambda (l)  ;lista
      ((Y (lambda (f)
         (lambda (l1)
          (((null l1) ;si la lista esta vacia no habra ninguna aparicion
            (lambda (no_use)
              l1
            )
            (lambda (no_use) ;sino
              ((cons (minimum l1))(f ((eliminarPrimeraAparicion l1)(minimum l1))))
            )
          )
            zero)  ; no_use <- x
        )
      ))
        l) ; x <- l
    )
)

(define tomaNElementos 
  (lambda (numero) ;numero de elementos a tomar
    (lambda (lista) ;lista
      (((Y (lambda (f)
             (lambda (n) 
               (lambda (l)
                 (((esceroent n) ;Si la lista esta vacia
                   (lambda (no_use)
                     nil 
                     )
                   (lambda (no_use) ;sino
                    
                     ((cons (hd l))((f ((restaent n)uno))(tl l))) ;Concatenamos la cabeza con n números de la cola
                     
                     )
                   )
                  cero)
                 ))
             ))
        numero) ;n <- numero
       lista) ;l <- lista
      )
    ))

(define dejaNElementos 
  (lambda (numero) ;numero de elementos a dejar
    (lambda (lista) ;lista
      (((Y (lambda (f)
             (lambda (n) 
               (lambda (l)
                 (((esceroent n) ;Si la lista esta vacia
                   (lambda (no_use)
                     l 
                     )
                   (lambda (no_use) ;sino
                    
                     ((f ((restaent n)uno))(tl l)) ;Cogemos solo números a partir del n primero
                     
                     )
                   )
                  cero) 
                 ))
             ))
        numero) ;n <- numero
       lista) ;l <- lista 
      )
    ))
  
(define menu
  (lambda (no_use)
    (begin
    (display "FUNCIONALIDADES\n")
    (display "1. Imprimir una lista -> Introduce (printLista L), siendo L la lista que deseas imprimir.\n")
    (display "2. Sacar longitud de una lista -> Introduce (printNum(long L)), siendo L la lista.\n")
    (display "3. Test de pertenenencia -> Introduce ((in LA)X), siendo L la lista y X el número (escrito en letras) que quieres buscar dentro de la lista.\n")
    (display "4. Sumar los elementos de una lista -> Introduce (printNumZ(sumaL L)) siendo L la lista.\n")
    (display "5. Añadir un elemento a la izquierda de una lista -> Introduce (printLista((concatNumList L)X)), siendo L la lista y X el número (escrito en letras) que quieres añadir a la izquierda.\n")
    (display "6. Invertir una lista -> Introduce (printLista(reverse L)), siendo L la lista.\n")
    (display "7. Concatenar dos listas -> Introduce (printLista((append L)N)), siendo L una lista y N la lista que se quiere concatenar a L\n")
    (display "8. Sacar el número máximo de una lista -> Introduce (printNumZ(maximum L)), siendo L la lista.\n")
    (display "9. Sacar el número mínimo de una lista -> Introduce (printNumZ(minimum L)), siendo L la lista.\n")
    (display "10. Sacar el número de apariciones de un elemento en una lista -> Introduce (printNum((apariciones L)X)), siendo L la lista y X el elemento que quieres contar (escrito en letras).\n")
    (display "11. Sacar la suma de dos listas -> Introduce (printLista((sumaVectores L)N)), siendo L y N las dos listas.\n")
    (display "12. Sacar la resta de dos listas -> Introduce (printLista((restaVectores L)N)), siendo L y N las dos listas.\n")
    (display "13. Sacar el producto de dos listas -> Introduce (printLista((productoVectores L)N)), siendo L y N las dos listas.\n")
    (display "14. Sustituir un elemento X en una lista por otro -> Introduce (printLista(((sustituir L)N)M)), siendo L la lista, N el elemento que se quiere sustituir (escrito en letras) y M el nuevo elemento (escrito en letras).\n")
    (display "15. Eliminar la primera aparicion de un elemento X en una lista -> Introduce (printLista((eliminarPrimeraAparicion L)N)), siendo L la lista y N el elemento (escrito en letras).\n")
    (display "16. Ordenar la lista de menor a mayor -> Introduce (printLista(ordenarMenorMayor L)), siendo L la lista.\n")
    (display "17. Ordenar la lista de mayor a menor -> Introduce (printLista(ordenarMayorMenor L)), siendo L la lista.\n")
    (display "18. Coger los N primeros elementos de una lista. Introduce (printLista((tomaNElementos N)L)), siendo N el número de elementos (escrito en letras) que se quieren coger y L la lista.\n")
    (display "19. Dejar los N primeros elementos de una lista. Introduce (printLista((dejaNElementos N)L)), siendo N el número de elementos (escrito en letras) que se quieren dejar y L la lista.\n")
    (display "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n\n")
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


(define toma ;(printLista ((toma dos)L4)
  (lambda (numero) 
    (lambda (lista)
      (((Y (lambda (f)
             (lambda (n) 
               (lambda (l)
                 (((esceroent n) ;Si la lista esta vacia
                   (lambda (no_use)
                     nil 
                     )
                   (lambda (no_use) ;sino
                    
                     ((cons (hd l))((f ((restaent n)uno))(tl l))) ;Concateno la cabeza con n números de la cola
                     
                     )
                   )
                  cero) ;Inicializo variable no_use a cero  -> NO la voy a usar
                 ))
             ))
        numero) 
       lista) 
      )
    ))

(define deja ;(printLista ((deja)dos)L4)
  (lambda (numero) 
    (lambda (lista)
      (((Y (lambda (f)
             (lambda (n) 
               (lambda (l)
                 (((esceroent n) ;Si la lista esta vacia
                   (lambda (no_use)
                     l 
                     )
                   (lambda (no_use) ;sino
                    
                     ((f ((restaent n)uno))(tl l)) ;Cojo solo números a partir del n primero
                     
                     )
                   )
                  cero) ;Inicializo variable no_use a cero  -> NO la voy a usar
                 ))
             ))
        numero) 
       lista) 
      )
    ))



;; Listas de prueba
(define L1 ((cons uno) nil))
(define L2 ((cons uno)((cons cero)((cons dos)nil))))
(define L3 ((cons uno)((cons cero)((cons dos)nil))))
(define L4 ((cons uno)((cons dos)((cons tres)((cons cuatro)nil)))))
(define L5 ((cons dos)((cons dos)((cons uno)nil))))

<<<<<<< Updated upstream

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
=======
;;Ejecución de prueba de las funcionalidades
(define LA ((cons uno)((cons dos)((cons tres)((cons cuatro)((cons cinco)((cons seis)nil)))))))
(define LB ((cons nueve)((cons dos)((cons cinco)((cons uno)((cons tres)((cons dos)nil)))))))
(menu zero)
(display "PRUEBA\n")

(display "La lista A es: ")
(printLista LA)
(display "\nLa lista B es: ")
(printLista LB)

(display "\nLa longitud de la lista A es: ")
(printNum(long LA))
(display "\nLa longitud de la lista B es: ")
(printNum(long LB))

(display "\nEl numero 7 está en la lista A:\n")
((in LA)siete)
(display "\nEl numero 2 está en la lista A:\n")
((in LB)dos)

(display "\nLa suma de los elementos de la lista A es: " )
(printNumZ(sumaL LA))
(display "\nLa suma de los elementos de la lista B es: " )
(printNumZ(sumaL LB))

(display "\nAñadir el 1 al principio de la lista A: " )
(printLista((concatNumList LA)uno))
(display "\nAñadir el 3 al principio de la lista A: " )
(printLista((concatNumList LB)tres))

(display "\nLista A invertida: " )
(printLista(reverse LA))
(display "\nLista B invertida: " )
(printLista(reverse LB))

(display "\nConcatenar a la lista A la lista B: " )
(printLista((append LA)LB))
(display "\nConcatenar a la lista A la lista B: " )
(printLista((append LB)LA))

(display "\nEl maximo de la lista A es: " )
(printNumZ(maximum LA))
(display "\nEl maximo de la lista B: " )
(printNumZ(maximum LB))

(display "\nEl minimo de la lista A es: " )
(printNumZ(minimum LA))
(display "\nEl minimo de la lista B: " )
(printNumZ(minimum LB))

(display "\nNumero de 6 que hay en la lista A: " )
(printNum((apariciones LA)seis))
(display "\nNumero de 2 que hay en la lista B: " )
(printNum((apariciones LB)dos))

(display "\nLa suma de las dos listas es: " )
(printLista((sumaVectores LA)LB))

(display "\nLa resta de las dos listas es: " )
(printLista((restaVectores LA)LB))

(display "\nLa multiplicacion de las dos listas es: " )
(printLista((productoVectores LA)LB))

(display "\nSi susituimos en la lista A los 6 por 8 nos queda: " )
(printLista(((sustituir LA)seis)ocho))
(display "\nSi susituimos en la lista B los 2 por 11 nos queda: " )
(printLista(((sustituir LB)dos)once))

(display "\nSi eliminamos el primer 5 de la lista A nos queda: " )
(printLista((eliminarPrimeraAparicion LA)cinco))
(display "\nSi eliminamos el primer 2 de la lista B nos queda: " )
(printLista((eliminarPrimeraAparicion LB)dos))

(display "\nLa lista A ordenada de menor a mayor es: " )
(printLista(ordenarMenorMayor LA))
(display "\nLa lista B ordenada de menor a mayor es: " )
(printLista(ordenarMenorMayor LB))

(display "\nLa lista A ordenada de mayor a menor es: " )
(printLista(ordenarMayorMenor LA))
(display "\nLa lista B ordenada de mayor a menor es: " )
(printLista(ordenarMayorMenor LB))

(display "\nSi dejamos los tres primeros elementos de la lista A nos queda: ")
(printLista((dejaNElementos tres)LA))
(display "\nSi dejamos los dos primeros elementos de la lista B nos queda: ")
(printLista((dejaNElementos dos)LB))

(display "\nSi tomamos los tres primeros elementos de la lista A nos queda: ")
(printLista((tomaNElementos tres)LA))
(display "\nSi tomamos los dos primeros elementos de la lista B nos queda: ")
(printLista((tomaNElementos dos)LB))

>>>>>>> Stashed changes
