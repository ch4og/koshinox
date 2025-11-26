export SHELL

replay source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
replay source ~/.profile

# Guix specific fix
if not status is-interactive
    if set -q SSH_CLIENT
        replay source /etc/profile
    end
end

# Guix specific fix
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
