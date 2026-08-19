;;; SPDX-FileCopyrightText: 2025 Hilton Chain <hako@ultrarare.space>
;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;;
;;; SPDX-License-Identifier: GPL-3.0-or-later

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
(straight-use-package 'docker-compose-mode)
(straight-use-package 'magit)
(straight-use-package 'evil)
(straight-use-package 'dockerfile-mode)
(straight-use-package 'typescript-mode)

(when (executable-find "wl-copy")
  (defun wl-copy (text)
    (let ((p (make-process :name "wl-copy"
                           :command '("wl-copy")
                           :connection-type 'pipe)))
      (process-send-string p text)
      (process-send-eof p)))
  (setq interprogram-cut-function 'wl-copy))

(require 'dockerfile-mode)
(require 'typescript-mode)
(global-wakatime-mode)
(evil-mode 1)

(straight-use-package 'catppuccin-theme)
(load-theme 'catppuccin :no-confirm)

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package inheritenv
  :ensure t)

(use-package ghostel
  :straight (:type git :host github :repo "dakra/ghostel"))

(use-package monet
  :straight (:type git :host github :repo "stevemolitor/monet"))

(use-package evil-ghostel
  :after (ghostel evil)
  :hook (ghostel-mode . evil-ghostel-mode))

(use-package claude-code
  :straight (:type git :host github :repo "stevemolitor/claude-code.el" :branch "main" :depth 1
                   :files ("*.el" (:exclude "images/*")))
  :bind-keymap
  ("C-c c" . claude-code-command-map)
  :bind
  (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode))
  :custom
  (claude-code-terminal-backend 'ghostel)
  :config
  (add-hook 'claude-code-process-environment-functions #'monet-start-server-function)
  (monet-mode 1)
  (claude-code-mode))

(use-package elcord
  :ensure t
  :config
  (elcord-mode))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package zig-mode
  :mode "\\.zig\\'")

(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :custom
  (markdown-command "pandoc"))

(use-package markdown-mode
  :mode ("\\.md\\'" . gfm-mode)
  :custom
  (markdown-command "pandoc"))

(use-package which-key
  :config
  (which-key-setup-side-window-right-bottom)
  :hook
  (after-init . which-key-mode))

(use-package completion-preview
  :custom
  (global-completion-preview-mode t))

(use-package emacs
  :custom
  (indent-tabs-mode nil)
  :config
  (setopt electric-indent-inhibit t)
  :hook
  (before-save . delete-trailing-whitespace)
  (after-init . electric-pair-mode))

(use-package geiser
  :custom
  (geiser-autodoc-identifier-format "%s → %s")
  (geiser-mode-smart-tab-p t)
  (geiser-mode-start-repl-p t)
  (geiser-repl-query-on-kill-p nil))

(use-package geiser-guile
  :after (geiser)
  :custom
  (geiser-default-implementation 'guile)
  (geiser-active-implementation '(guile))
  :config
  (dolist (path
           (mapcar
            #'expand-file-name
            '("~/.config/guix/current/lib/guile/3.0/site-ccache"
              "~/.config/guix/current/share/guile/site/3.0"
              "~/.guix-profile/lib/guile/3.0/site-ccache"
              "~/.guix-profile/share/guile/site/3.0"
              "~/.guix-home/profile/lib/guile/3.0/site-ccache"
              "~/.guix-home/profile/share/guile/site/3.0"
              "/run/current-system/profile/lib/guile/3.0/site-ccache"
              "/run/current-system/profile/share/guile/site/3.0")))
    (add-to-list 'geiser-guile-load-path path t)))

(straight-use-package 'nerd-icons)

(use-package doom-modeline
  :after nerd-icons
  :custom
  (doom-modeline-icon nil)
  (doom-modeline-height 18)
  :hook
  (after-init . doom-modeline-mode))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package org-rainbow-tags
  :hook
  (org-mode . org-rainbow-tags-mode))

(use-package paren
  :custom
  (show-paren-context-when-offscreen 'overlay)
  :hook
  (after-init . show-paren-mode))

(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

(setq-default require-final-newline t)

(customize-set-variable 'menu-bar-mode nil)
(customize-set-variable 'tool-bar-mode nil)
(customize-set-variable 'scroll-bar-mode nil)

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

(add-to-list 'default-frame-alist '(alpha-background . 95))
(add-to-list 'default-frame-alist '(font . "Comic Code NerdFont SemiBold-12"))

(defun on-frame-open (&optional frame)
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))

(add-hook 'after-make-frame-functions 'on-frame-open)
(setq create-lockfiles nil)
(setq backup-directory-alist '(("." . "~/.cache/emacs")))
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)

(setopt custom-file (locate-user-emacs-file "custom.el"))

(if (not (file-exists-p custom-file))
    (make-empty-file custom-file)
  (load custom-file))
