#lang web-server/insta

(require "model.rkt")

(define (start request)
  (render-game request))

(define (render-game request)
  (define (response-generator embed/url)
    (response/xexpr
      `(html
         (head (title "Racket Checkers!")
               (link ((rel "stylesheet")
                      (href "/style.css")
                      (type "text/css"))))
         (body
           (h1 "Checkers in Racket!")
           ,(render-board embed/url)))))
  (send/suspend/dispatch response-generator))

(define (render-board embed/url)
  `(div ((class "board"))
        (a ((href ,(embed/url click-square-handler)))
           (div ((class "square")
                 (id "a1")
                 (style 
                   ,(string-append 
                      "background-color:" 
                      (symbol->string (board-color (game-board GAME))))))))))

(define (click-square-handler request)
  (define (response-generator embed/url)
    (click-square! GAME )
    (render-game request))
  (send/suspend/dispatch response-generator))

(static-files-path (current-directory))

