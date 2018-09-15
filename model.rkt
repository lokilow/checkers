#lang racket/base

(require racket/list)

(struct game (active-player open-squares p1-moves p2-moves) #:mutable)

(define squares '(8 1 6 3 5 7 4 9 2))

(define GAME
  (game 'p1
        squares
        '()
        '()))

(define (click-square! game square)
  (make-move game square))

;Player 1 is x
;Player 2 is o
(define (make-move game square)
  (if (member square (game-open-squares game) )
    (begin 
    (set-game-open-squares! GAME 
                          (remove square (game-open-squares game) ))
    (if (equal? (game-active-player GAME) 'p1)
      (begin
        (set-game-p1-moves! GAME 
                            (cons square (game-p1-moves GAME)))
        (set-game-active-player! GAME 'p2))
      (begin
        (set-game-p2-moves! GAME
                            (cons square (game-p2-moves GAME)))
        (set-game-active-player! GAME 'p1))))
    (void)))

(define (get-winning-combination moves)
  (define triplets (combinations moves 3))
  (filter (lambda (x) (equal? 15 (foldl + 0 x))) triplets))

(provide (all-defined-out))

