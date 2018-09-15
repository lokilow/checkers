#lang racket

(require web-server/servlet
         web-server/servlet-env
         web-server/templates
         xml
         "model.rkt")

(define (start-game request)
  (lambda (embed/url)
    (response/full
      200 #"Okay"
      (current-seconds) TEXT/HTML-MIME-TYPE
      empty
      (list (string->bytes/utf-8 (include-template "initial-load.html")))))
  (render-game request))

(define (render-game request)
  (define (response-generator embed/url)
    (response/full
      200 #"Okay"
      (current-seconds) TEXT/HTML-MIME-TYPE
      empty
      (list (string->bytes/utf-8 (include-template "index.html")))))
  (send/suspend/dispatch response-generator))

(define (render-board embed/url)
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
  (include-template "board.html"))

(define (game-status game)
  (if (> 5 (length (game-open-squares game)))
    (cond 
      [(and (equal? (game-active-player game) 'p1)
            (< 0 (length(get-winning-combination (game-p2-moves game)))))
       "Player 2 Wins!"]
      [(and (equal? (game-active-player game) 'p2)
            (< 0 (length(get-winning-combination (game-p1-moves game)))))
       "Player 1 Wins!"]
      [else "Game On!"])
    "Game On!"))

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
               #:port 8080
               #:listen-ip "0.0.0.0"
               #:launch-browser? #f)

