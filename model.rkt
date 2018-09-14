#lang racket/base

(struct game (active-player position) #:mutable)
(define squares '(s1 s2 s3 s4 s5 s6 s7 s8 s9))
;Player 1 is X
;Player 2 is O
(define GAME
  (game 'p1
      (make-hash (map (lambda (s) (cons s 'e)) squares) ))
      )
(print (game-position GAME))
(define (click-square! game square)
  (make-move game square))


(define (make-move game square)
  (if (equal? (game-active-player game) 'p1)
    (begin
    (hash-set! (game-position game) square 'x)
     (set-game-active-player! GAME 'p2))
    (begin
    (hash-set! (game-position game) square 'o)
     (set-game-active-player! GAME 'p1))))

(define (get-square game square)
  (hash-ref (game-position game) square))
(provide (all-defined-out))

