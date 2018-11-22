#lang web-server/insta

(struct post (title body))

(define BLOG
  (list (post "Second Post" "This is another post")
        (post "First Post" "This the first post")))

(define (start request)
  (define a-blog
    (cond [(can-parse-post? (request-bindings request))
           (cons (parse-post (request-bindings request))
                 BLOG)]
          [else
           BLOG]))
  (render-blog-page a-blog request))

(define (can-parse-post? bindings)
  (and (exists-binding? 'title bindings)
       (exists-binding? 'body bindings)))

(define (parse-post bindings)
        (post (extract-binding/single 'title bindings)
              (extract-binding/single 'body bindings)))

(define (render-blog-page a-blog request)
  (response/xexpr
   `(html (head (title "whusutopi"))
          (body
           (h1 "mina utkast")
           ,(render-posts a-blog)
           (form
            (input ((name "title")))
            (input ((name "body")))
            (input ((type "submit"))))))))

(define (render-post a-post)
  `(div ((class "post"))
        ,(post-title a-post)
        (p ,(post-body a-post))))

(define (render-posts a-blog)
  `(div ((class "posts"))
        ,@(map render-post a-blog)))