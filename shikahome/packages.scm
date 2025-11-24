(define-module (shikahome packages)
  )
(use-modules (guix utils)
             (gnu packages)
             (gnu packages wm)
             (gnu packages dns)
             (guix transformations)
             (nongnu packages nvidia))
(define transform
  (options->transformation '((with-graft . "mesa=nvda"))))

(append (specifications->packages '("bind:utils"))
        (map transform
             (map specification->package
                  '("bat"
                    "blueman"
                    "btop"
                    "curl"
                    "direnv"
                    "eog"
                    "eza"
                    "fastfetch"
                    "fd"
                    "file"
                    "file-roller"
                    "filezilla"
                    "firefox"
                    "font-awesome-nonfree"
                    "fontforge"
                    "font-google-noto"
                    "fzf"
                    "gnupg"
                    "grim"
                    "heroic-nvidia"
                    "imagemagick"
                    "jujutsu"
                    "kdenlive"
                    "krita"
                    "libreoffice"
                    "mangowc"
                    "mpv"
                    "ncurses"
                    "neovim"
		    "network-manager-applet"
		    "networkmanager-dmenu"
                    "nftables"
                    "pavucontrol"
                    "pcmanfm"
                    "pinentry"
                    "pipewire"
                    "qbittorrent-enhanced"
                    "quickshell"
                    "remmina"
                    "reuse"
                    "ripgrep"
                    "rofi"
                    "slurp"
                    "starship"
		    "steam"
                    "swappy"
                    "swaybg"
                    "swww"
                    "tmux"
                    "torbrowser"
                    "unzip"
                    "virt-manager"
                    "waybar"
                    "wireplumber"
                    "wl-clipboard"
                    "wtype"
                    "xdg-desktop-portal"
                    "xdg-desktop-portal-gtk"
                    "xdg-desktop-portal-wlr"
                    "xdg-utils"
		    "zapret"
                    "zip"
                    "zoxide"))))

