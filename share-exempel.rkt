#lang web-server/insta

(struct blog (posts) #:mutable)

(struct post (title body))

(define BLOG
  (blog
   (list (post "second post" "this is another post")
         (post "first post" "this is the first post"))))

(define (blog-insert-post! a-blog a-post)
  (set-blog-posts! a-blog
                   (cons a-post (blog-posts a-blog))))

(define (start request)
  (render-blog-page request))

(define (parse-post bindings)
  (post (extract-binding/single 'title bindings)
        (extract-binding/single 'body bindings)))

(define (render-blog-page request)
  (define (response-generator embed/url)
    (response/xexpr
     `(html (head (title "min blogg"))
            (body
             (h1 "min blogg")
             ,(render-posts)
             (form ((action
                     ,(embed/url insert-post-handler)))
                   (input ((name "title")))
                   (input ((name "body")))
                   (input ((type "submit"))))))))
  (define (insert-post-handler request)
    (blog-insert-post!
     BLOG (parse-post (request-bindings request)))
    (render-blog-page request))
  
  (send/suspend/dispatch response-generator))

(define (render-post a-post)
  `(div ((class "post"))
        ,(post-title a-post)
        (p ,(post-body a-post))))

(define (render-posts)
  `(div ((class "posts"))
        ,@(map render-post (blog-posts BLOG))))
