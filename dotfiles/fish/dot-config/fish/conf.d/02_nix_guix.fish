if not set -q GUIX_ENVIRONMENT
    if not string match -q '*'/nix'*' $PATH
        if not status is-interactive
            if set -q SSH_CLIENT
                replay source /etc/profile
            end
        end

        replay source ~/.profile
    end
end
