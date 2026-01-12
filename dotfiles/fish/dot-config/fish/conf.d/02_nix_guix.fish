if not set -q GUIX_ENVIRONMENT
    if not string match -q '*'/nix'*' $PATH
        replay source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
        replay source ~/.profile

        # Guix specific fix
        if not status is-interactive
            if set -q SSH_CLIENT
                replay source /etc/profile
            end
        end

        fish_add_path /run/setuid-programs

        # Guix specific fix
        gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    end
end
