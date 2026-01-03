(define raw-channels
  (call-with-input-file "/run/current-system/channels.scm" read))

(define channels (cdr raw-channels))

(define (unquote x)
  (if (and (pair? x) (eq? (car x) 'quote)) (cadr x) x))

(define (channel-commit name)
  (let loop ((chs channels))
    (cond
      ((null? chs) #f)
      ((and (pair? (car chs))
            (eq? (car (car chs)) 'channel)
            (string=? name
                     (symbol->string (unquote (cadr (assoc 'name (cdr (car chs))))))))
       (cadr (assoc 'commit (cdr (car chs)))))
      (else (loop (cdr chs))))))

(let ((commit (channel-commit "guix")))
  (when commit
    (display "g @")
    (display (substring commit 0 7))
    (display ", ")))
(let ((commit (channel-commit "nonguix")))
  (when commit
    (display "n @")
    (display (substring commit 0 7))
    (newline)))
