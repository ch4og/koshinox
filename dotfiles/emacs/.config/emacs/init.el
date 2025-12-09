(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
	"straight/repos/straight.el/bootstrap.el"
	(or (bound-and-true-p straight-base-dir)
	    user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'wakatime-mode)
(straight-use-package 'magit)
(straight-use-package 'evil)

(global-wakatime-mode)
(evil-mode 1)

(straight-use-package 'catppuccin-theme)
(load-theme 'catppuccin :no-confirm)

(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

(customize-set-variable 'menu-bar-mode nil)
(customize-set-variable 'tool-bar-mode nil)
(customize-set-variable 'scroll-bar-mode nil)

(set-frame-font "Comic Code NerdFont SemiBold 12")

(xterm-mouse-mode)
(setq mouse-autoselect-window 't)

(setq ring-bell-function 'ignore)
(winner-mode t)
(add-hook 'prog-mode-hook
          'display-line-numbers-mode)

(setq fci-rule-column 80)
(pixel-scroll-mode)
(setq compilation-window-height 15)
(setq-default truncate-lines t)

(defun on-frame-open (&optional frame)
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))

(add-hook 'after-make-frame-functions 'on-frame-open)
(setq create-lockfiles nil)
(setq backup-directory-alist '(("." . "~/.cache/emacs")))
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)
