(define-module (shikaguix substitutes)
  )

(define-public shika-subs
  '("https://mirror.yandex.ru/mirrors/guix" "https://mirror.sjtu.edu.cn/guix"
    "https://bordeaux.guix.gnu.org" "https://nonguix-proxy.ditigal.xyz"))

(define-public shika-subs-urls
  (string-append "--substitute-urls=\""
                 (string-join shika-subs " ") "\""))

