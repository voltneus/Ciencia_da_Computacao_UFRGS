;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Lista3-Vitor_Feijo-Turma_C) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;; NOME: Vítor Santana Feijó

;; Exercício individual.
;; Para cada exercício, faça pelo menos 2 testes usando check-expect.
;; Lembre que todas as funções devem conter a documentação completa,
;; incluindo contrato, objetivo, exemplos e testes.

;; ==================================================================

;;  LISTA 3

;; ==========================================================
;; DEFINIÇÕES DE DADOS:
;; ==========================================================


;; ================
;; TIPO Raça:
;; ================
;; Uma Raça (de acordo com o IBGE) é um elemento do conjunto
;; {"preta", "parda", "branca", "amarela", "indígena"}

;; ======================
;; TIPO Funcionário:
;; ======================
(define-struct funcionário (nome admissão raça))
;; Um elemento do conjunto Funcionário é
;;        (make-funcionário  n a r)
;; onde:
;;       n : String, representa o nome da pessoa
;;       a : Número, representa o ano de admissao da pessoa
;;       r : Raça, representa a raça, de acordo com o IBGE.

;; ======================
;; TIPO ListaDeMembros:
;; ======================
;; Um elemento do conjunto ListaDeMembros pode ser
;;  1. empty, ou
;;  2. (cons  f lm)  onde:
;;       f : Funcionário
;;       lf : ListaDeMembros
;;  3. (cons  d lm)  onde:
;;       d : Departamento
;;       lf : ListaDeMembros

;; ==================
;; TIPO Departamento:
;; ==================
(define-struct departamento (nome chefe membros))
;; Um elemento do conjunto Departamento é
;;        (make-departamento  n c m)
;; onde:
;;       n : String, representa o nome do departamento
;;       c : String, representa o nome do chefe do departamento
;;       m : ListaDeMembros, representa a lista de membros do departamento


;; =========================================
;; 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
;; =========================================
;;Defina uma constante chamada EMPRESA  que contém a estrutura de uma empresa,
;; sendo que esta empresa deve ter pelo menos 15 funcionários, 4 departamentos e
;; uma hierarquia com profundidade mínima 4. Cada funcionário só pode aparecer
;; uma vez na hierarquia da empresa.

;;Funcionarios:

(define Andre (make-funcionário  "Andre" 2021 "preta"))
(define Bruno (make-funcionário "Bruno" 2020 "indígena"))
(define Camila (make-funcionário "Camila" 2019 "amarela"))
(define Daniela (make-funcionário "Daniela" 2022 "parda"))
(define Eduardo (make-funcionário "Eduardo" 2018 "preta"))
(define Fernanda (make-funcionário "Fernanda" 2021 "indígena"))
(define Gabriela (make-funcionário "Gabriela" 2023 "amarela"))
(define Henrique (make-funcionário "Henrique" 2020 "preta"))
(define Isabella (make-funcionário "Isabella" 2022 "branca"))
(define João (make-funcionário "João" 2017 "preta"))
(define Karla (make-funcionário "Karla" 2021 "branca"))
(define Leonardo (make-funcionário "Leonardo" 2019 "parda"))
(define Mariana (make-funcionário "Mariana" 2020 "amarela"))
(define Natalia (make-funcionário "Natalia" 2018 "indígena"))
(define Otavio (make-funcionário "Otavio" 2023 "preta"))
(define Pedro (make-funcionário "Pedro" 2019 "preta"))


(define membrosCompras(list Otavio Pedro Camila))
(define Compras(make-departamento "Compras" "Otavio" membrosCompras))

(define membrosFinanceiro(list Natalia Leonardo Compras))
(define Financeiro(make-departamento "Financeiro" "Leonardo" membrosFinanceiro))

(define membrosPessoal(list Karla João Isabella Bruno ))
(define Pessoal(make-departamento "Pessoal" "Isabella" membrosPessoal))

(define membrosCoordenação(list Andre Mariana Eduardo Henrique Pessoal Financeiro))
(define Coordenação(make-departamento "Coordenação" "Mariana" membrosCoordenação))

(define membrosDireção(list Gabriela Fernanda Eduardo Daniela Coordenação))
(define Direção(make-departamento "Direção" "Fernanda" membrosDireção))


;;Empresa

  
(define EMPRESA Direção)
   
  

;; =========================================
;; 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 
;; =========================================

;; chefe-no-departamento?:  Departamento -> Booleano
;; Dado um departamento, verifica se o chefe faz parte do departamento.
;; Exemplos/testes:
   (check-expect (chefe-no-departamento? (make-departamento "DEP-X" "Luiza" empty)) false)
   (check-expect (chefe-no-departamento? Compras) true)


 (define (chefe-no-departamento? dep)
   (cond
     ;;se a lista de membros estiver vazia, devolver falso
     [(empty? (departamento-membros dep)) false]
     ;se for um departamento, devolver falso
     [(departamento? (first(departamento-membros dep))) false]
     ;se for o funcionario com o nome do chefe do departamento, devolver true
     [(string=? (funcionário-nome (first(departamento-membros dep))) (departamento-chefe dep)) true]
     ;senão, chamar a função com o resto da lista de membros
     [else (chefe-no-departamento?
            (make-departamento (departamento-nome dep) (departamento-chefe dep) (rest(departamento-membros dep))))]))




;; cargos-chefe-preenchidos?:  Departamento -> Boooleano
;; Dado um departamento, verificar se o departamento e todos seus sub-departamentos tem chefes.
;; Exemplo:
     (check-expect (cargos-chefe-preenchidos?  EMPRESA) true)
     (check-expect (cargos-chefe-preenchidos?  (make-departamento "DEP-X" "Luiza" empty))  false)

 (define (cargos-chefe-preenchidos? dep)
  (cond
    ;;se o chefe do departamento não está na lista, devolver falso
    [(not (chefe-no-departamento? dep)) false]
    ;;se a lista de subdepartamentos estiver vazia, devolver verdadeiro
    [(empty? (filter departamento? (departamento-membros dep))) true]
    ;;chama a função subDepChefe para verificar os subdepartamentos
    [else (subDepChefe (filter departamento? (departamento-membros dep)))]))


;; subDepChefe:  Departamento -> Boooleano
;; Dado um subdepartamento, verificar se o subdepartamento e todos seus sub-departamentos tem chefes

(define (subDepChefe ldep)
  (cond
    ;;se a lista está vazia, devolver true(todos os subdepartamentos foram verificados
    [(empty? ldep) true]
    ;;se o primeiro subdepartamento não tem chefe, retorna falso
    [(not (cargos-chefe-preenchidos? (first ldep))) false]
    ;;senão, chama a função para os subdepartamentos
    [else (subDepChefe (rest ldep))]))

   





;; =========================================
;; 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
;; =========================================
;; ===> Substitua os exemplos/testes pelos da sua hierarquia,
;; os apresentados a seguir são da hierarquia EMPRESA ilustrada no enunciado.

;; profundidade-hierarquia: Departamento -> Numero
;; Dado um departamento, devolver a profundidade da hierarquia.
;; Exemplos/testes:
   (check-expect (profundidade-hierarquia Financeiro) 2)
   (check-expect (profundidade-hierarquia EMPRESA) 4)

(define (profundidade-hierarquia dep)
  (cond
    ;;se o departamento não tiver subdepartamentos, a profundidade é 1
    [(empty? (filter departamento? (departamento-membros dep))) 1]
    ;;senão, calcula a profundidade máxima dos subdepartamentos
    [else (+ 1 (max-profund (map profundidade-hierarquia (filter departamento? (departamento-membros dep)))))]))


;; profundidade-hierarquia: Departamento -> Lista
;; Dado um subdepartamento, devolver a profundidade da hierarquia dos subdepartamentos.

(define (max-profund lst)
  (cond
    ;;se a lista estiver vazia, retorna 0
    [(empty? lst) 0]
    ;;senão, calcula a profundidade máxima dos subdepartamentos
    [else (max (first lst) (max-profund (rest lst)))])) 


   

;; =========================================
;; 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 
;; =========================================

;; ===> Substitua os exemplos/testes pelos da sua hierarquia,
;; os apresentados a seguir são da hierarquia mostrada no enunciado.

;; ATENÇÃO: Nesta questão não devem ser usadas expressões condicionais cond ou if
;; no código das funções (em nenhuma função desta questão). Devem ser usadas definições locais.

;; número-funcionários-por-raça: String Departamento -> Number

  ; (check-expect (número-funcionários-por-raça "preta" EMPRESA) 3)
    (check-expect (número-funcionários-por-raça "branca" EMPRESA) 2)
    (check-expect (número-funcionários-por-raça "branca" Compras) 0)




(define (número-funcionários-por-raça raça dep)
  (local   
    (
      ;; função que verifica se um funcionário é da raça dada
      (define (funRaça raça)
        (lambda (f) (string=? raça (funcionário-raça f))))
      
      ;; lista de funcionários diretos deste departamento da raça dada
      (define (funDep raça dep)
        (filter (funRaça raça) (filter funcionário? (departamento-membros dep))))
      
      ;; número de funcionários diretos deste departamento da raça dada
      (define (numFun raça dep)
        (foldl + 0 (map (lambda (x) 1) (funDep raça dep))))
      
      ;; lista de subdepartamentos deste departamento
      (define (listaSubdep dep)
        (filter departamento? (departamento-membros dep)))
      
      ;; soma dos funcionários da raça dada nos subdepartamentos
      (define (numSubdep raça subdeps)
        (foldl + 0 (map (lambda (subdep) (número-funcionários-por-raça raça subdep)) subdeps)))
    )
    ;soma do número de funcionarios da raça dada no departamento e seus subdepartamentos
    (+ (numFun raça dep) (numSubdep raça (listaSubdep dep)))))




 
;; =========================================
;; 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
;; =========================================

;; gráfico-funcionários-por-raça: Departamento -> Imagem
;; Dado um departamento, gera um gráfico de barras representando as porcentagens de
;; cada raça entre os funcionários da empresa.

; preta - marrom escuro
; branca - cinza
; parda - marrom
; amarela - amarela
; indigena - vermelho

 (define (gráfico-funcionários-por-raça dep)
   (above
    (beside
     (overlay (text (string-append (number->string (quotient (* (número-funcionários-por-raça "preta" dep) 100) 15)) "%") 24 "white")
      (rectangle (* (número-funcionários-por-raça "preta" dep) 100) 50 "solid" "dark brown"))

     (overlay (text (string-append (number->string (quotient (* (número-funcionários-por-raça "parda" dep)100) 15)) "%") 24 "white")
      (rectangle (* (número-funcionários-por-raça "parda" dep) 100) 50 "solid" "brown"))

     (overlay (text (string-append (number->string (quotient (* (número-funcionários-por-raça "indígena" dep)100) 15)) "%") 24 "white")
      (rectangle (* (número-funcionários-por-raça "indígena" dep) 100) 50 "solid" "red"))

     (overlay (text (string-append (number->string (quotient (* (número-funcionários-por-raça "amarela" dep)100) 15)) "%") 24 "white")
      (rectangle (* (número-funcionários-por-raça "amarela" dep) 100) 50 "solid" "yellow"))

     (overlay (text (string-append (number->string (quotient (* (número-funcionários-por-raça "branca" dep)100) 15)) "%") 24 "white")
      (rectangle (* (número-funcionários-por-raça "branca" dep) 100) 50 "solid" "gray")) )

    (beside
     (beside
      (rectangle 20  20 "solid" "dark brown")
      (text "preta" 24 "white"))
     
     (beside
      (rectangle 20  20 "solid" "brown")
      (text "parda" 24 "white"))

     (beside
      (rectangle 20  20 "solid" "red")
      (text "indígena" 24 "white"))

     (beside
      (rectangle 20  20 "solid" "yellow")
      (text "amarela" 24 "white"))

     (beside
      (rectangle 20  20 "solid" "gray")
      (text "branca" 24 "white")))))

   


(gráfico-funcionários-por-raça EMPRESA)


;; =========================================
;; 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6
;; =========================================

;; imagem-departamento : Departamento -> Resultado
;; 
;; Exemplos:
;;   (imagem-departamento EMPRESA) = imagem mostrada na lista de enunciados
   (check-expect (imagem-departamento (make-departamento "D4" "Luiza" empty))  "Estrutura do departamento inconsistente.")

 ;Tipo misto: Resultado
 ;Um elemento do conjunto Resultado é
 ;1) Um Imagem, ou
 ;2) uma String.



 (define (imagem-departamento dep)
   (local
     (
      (define (desenhamembrosDep lst)
        (cond
          [(empty? lst) empty-image]
          [else (beside (text (first lst) 15 "white")
                        (desenhatodosDep (rest lst)))]))
      
      (define (desenhaDep dep)
        (cond
          [(empty?  dep) empty-image]
          [else (above
                 (text (departamento-nome dep) 30 "white")
                 (desenhamembrosDep (filter string? (departamento-membros dep))))]))
 
      (define (desenhatodosDep dep)
        (cond
          [(empty? (departamento-membros dep)) empty-image]
          [(= 1 (length (filter departamento? (departamento-membros dep))))
                   (map desenhaDep (filter departamento? (departamento-membros dep)))]
          [else (map desenhaDep (filter departamento? (departamento-membros dep)))]))
      )
    (cond
      ;; se algum dos chefes do departamento ... não faz parte do respectivo departamento,
      ;; devolver a mensagem ...
      [(not (cargos-chefe-preenchidos? dep)) "Estrutura do departamento inconsistente."]
      ;; senão, gerar a imagem do departameto ...
      [else (desenhatodosDep dep)])))






;não funciona direito     
;(imagem-departamento EMPRESA)
