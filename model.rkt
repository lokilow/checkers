#lang racket/base

(struct game (board) #:mutable)
(struct board (colors))

(define GAME
  (game
    (board
      (make-hash '((a1 . red) (a2 . black)))
      )))

(define (click-square! a-game a-square)  ;player current-pos next-pos)
  (switch-color (game-board a-game) a-square))


(define (switch-color board square)
  (if (equal? (hash-ref (board-colors board)square) 'red)
    (hash-set! (board-colors board) square 'black)
    (hash-set! (board-colors board) square 'red)))
(define (get-color board square)
  (hash-ref (board-colors board) square))
(provide (all-defined-out))

