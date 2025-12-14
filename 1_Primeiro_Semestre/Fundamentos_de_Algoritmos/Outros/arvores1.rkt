;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname arvores1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define-struct nó (esq dir))
; Uma AB (árvore binária) é:
; 1. empty
; 2. (make-nó id nível esq dir), onde
; id : String (representa o id do nó)
; nível : Número (Nível do nó)
; esq : AB (representa a subárvore esquerda do nó)
; dir : AB (representa a subárvore direita do nó)


(define B
  (make-nó empty empty))

(define D
  (make-nó empty empty))

(define C
  (make-nó empty D))

(define A
  (make-nó B C))

(define (árvore-espelhada arvore)
  (cond
    [(empty? arvore) empty]
    [else (make-nó (árvore-espelhada (nó-dir arvore)) (árvore-espelhada(nó-esq arvore)) )]))






(define (profundidade-arvore arvore)
  (cond
    [(empty? arvore) 0]
    [(and (empty? (nó-dir arvore)) (empty? (nó-esq arvore))) 1]
    [else (+ 1 (profundidade-arvore-aux (nó-dir arvore) (nó-esq arvore)))]))


(define (profundidade-arvore-aux arvore1 arvore2)
  (max (profundidade-arvore arvore1) (profundidade-arvore arvore2)))


(profundidade-arvore A)








