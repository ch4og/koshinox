;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages development)
  #:use-module (gnu packages))

(define-public %koshi-development-home-packages
  (specifications->packages (list "awscli"
                                  "blue"
                                  "bun-bin"
                                  "ccusage"
                                  "cli-proxy-api"
                                  "claude-code-bin"
                                  "corepack-pnpm"
                                  "corepack-yarn"
                                  "direnv"
                                  "emacs-no-x"
                                  "gcc-toolchain"
                                  "git-delta"
                                  "jujutsu"
                                  "lazygit"
                                  "neovim"
                                  "node"
                                  "opencode-bin"
                                  "pipx"
                                  "reuse"
                                  "tree-sitter-cli"
                                  "vscodium"
                                  "wakatime-cli")))
