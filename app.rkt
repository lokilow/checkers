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
           (h2 (a ((href "/checkers")) "New Game"))
           ,(make-square embed/url)
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

(define (make-square embed/url)
  (make-cdata #f #f (include-template "board-2.html")))

(define (click-square-handler square request)
  (define (response-generator embed/url)
    (click-square! GAME square)
    (render-game request))
  (send/suspend/dispatch response-generator))

(serve/servlet start-game
               #:servlet-path "/checkers"
               #:extra-files-paths
               (list 
                 (build-path (current-directory) "static"))
               #:launch-browser? #f)

