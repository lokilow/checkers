#lang racket/base

(struct game (board) #:mutable)
(struct board (color))

(define GAME
  (game
    (board
      'red)))

(define (click-square! a-game)  ;player current-pos next-pos)
  (set-game-board!
    a-game
    (board 
    (if (equal? (board-color (game-board a-game)) 'red) 'black 'red))))
(provide (all-defined-out))
