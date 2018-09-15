#lang racket

(require web-server/servlet
         web-server/servlet-env
         web-server/templates
         xml
         "model.rkt")

(define (start-game request)
  (render-game request))

(define (render-game request)
  (define (response-generator embed/url)
    (response/xexpr
      `(html
         (head (title "Racket Tic Tac Toe!")
               (link ((rel "stylesheet")
                      (href "/style.css")
                      (type "text/css"))))
         (body
           (h1 "Tic Tac Toe")
           (h2 (a ((href "/tic-tac-toe")) "New Game"))
           ,(show-winner GAME)
           ,(make-board embed/url)
           (div ((class "about"))
                (img ((class "racket-logo")
                      (src "/racket-logo.svg")
                      (alt "Racket Logo")))
                (p "This html and css for this application is rendered serverside.  I
                   was inspired by the Chris McCord's keynote at ElixirConf 2018 and
                   what he is doing with the Elixir/Phoenix ecosystem.  I am very
                   excited for LiveView, but for now I will keep developing in
                   Racket."))))))
                   (send/suspend/dispatch response-generator))

(define (make-board embed/url)
  (define (make-url game s)
    (if (member s (game-open-squares game))
      (embed/url ((curry click-square-handler) s))
      "#"))
  (define (get-square-class game s)
    (cond [(member s (game-open-squares game))
           'e]
          [(member s (game-p1-moves game))
           'x]
          [(member s (game-p2-moves game))
           'o]))
  (make-cdata #f #f (include-template "board.html")))

(define (show-winner game)
  (if (> 5 (length (game-open-squares game)))
    (cond 
      [(and (equal? (game-active-player game) 'p1)
            (< 0 (length(get-winning-combination (game-p2-moves game)))))
       `(h2 "Player 2 Wins!")]
      [(and (equal? (game-active-player game) 'p2)
            (< 0 (length(get-winning-combination (game-p1-moves game)))))
       `(h2 "Player 1 Wins!")]
      [else `(h2 "Game On!")])
    `(h2 "Game On!")))

(define (click-square-handler square request)
  (define (response-generator embed/url)
    (click-square! GAME square)
    (render-game request))
  (send/suspend/dispatch response-generator))

(serve/servlet start-game
               #:servlet-path "/tic-tac-toe"
               #:extra-files-paths
               (list 
                 (build-path (current-directory) "static"))
               #:launch-browser? #f)

