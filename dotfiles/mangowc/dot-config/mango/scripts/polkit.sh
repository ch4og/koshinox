#!/usr/bin/env sh

if [ -f /usr/lib/polkit-mate-authentication-agent-1 ]; then
    exec /usr/lib/polkit-mate-authentication-agent-1 &
else
    if ! command -v guix >/dev/null 2>&1; then
        exit 1
    fi

    POLKIT=$(guix build mate-polkit)
    exec $POLKIT/libexec/polkit-mate-authentication-agent-1 &
fi
