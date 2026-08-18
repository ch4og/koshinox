if not set -q GUIX_ENVIRONMENT
    if not string match -q '*'/nix'*' $PATH
        replay source ~/.profile

        # Guix specific fix
        if not status is-interactive
            if set -q SSH_CLIENT
                replay source /etc/profile
            end
        end
    end
end
