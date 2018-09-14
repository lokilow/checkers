#lang racket/base

(struct game (colors) #:mutable)

(define GAME
  (game
      (make-hash '((a1 . red) (a2 . black)))
      ))

(define (click-square! a-game a-square)  ;player current-pos next-pos)
  (switch-color a-game a-square))


(define (switch-color game square)
  (if (equal? (hash-ref (game-colors game) square) 'red)
    (hash-set! (game-colors game) square 'black)
    (hash-set! (game-colors game) square 'red)))
(define (get-color game square)
  (hash-ref (game-colors game) square))
(provide (all-defined-out))

