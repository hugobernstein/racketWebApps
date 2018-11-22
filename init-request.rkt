#lang web-server/insta

(define (start request)
  (response/xexpr
   '(html
     (head (title "min blogg"))
     (body (h1 "Under construction")))))