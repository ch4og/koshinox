if status is-interactive
    set -l tty_now (tty 2>/dev/null)

    if test -n "$tty_now"
        set -gx GPG_TTY "$tty_now"
        set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    end
end
