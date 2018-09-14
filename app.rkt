#lang web-server/insta

(require web-server/templates
         xml
         "model.rkt")

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
(define (make-square embed/url id)
  (make-cdata #f #f (include-template "square.html")))
(define (render-board embed/url)
  `(div ((class "board"))
        (a ((href ,(embed/url ((curry click-square-handler) 'a1 ))))
           (div ((class "square")
                 (id "a1")
                 (style 
                   ,(string-append 
                      "background-color:" 
                      (symbol->string (get-color 
                                        GAME 'a1)))))))
        (a ((href ,(embed/url ((curry click-square-handler) 'a2))))
           (div ((class "square")
                 (id "a2")
                 (style 
                   ,(string-append 
                      "background-color:" 
                      (symbol->string (get-color GAME  'a2)))))))))

(define (click-square-handler square request)
  (define (response-generator embed/url)
    (click-square! GAME square)
    (render-game request))
  (send/suspend/dispatch response-generator))

(static-files-path (current-directory))

