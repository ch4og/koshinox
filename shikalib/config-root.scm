(define-module (shikalib config-root)
  )
(define-public config-root
  (let* ((source-file (current-filename))
         (abs-path (canonicalize-path source-file)))
    (dirname abs-path)))

