#!/usr/bin/env bash

rules_file="$(dirname -- "${BASH_SOURCE[0]}")/switch_layouts.conf"
current_layout=default

is_target() {
    local app_id="$1"
    local window_title="$2"
    local pattern

    if [ -z "$app_id" ] && [ -z "$window_title" ]; then
        return 1
    fi

    for pattern in "${TARGET_APPIDS[@]}"; do
        [[ "$app_id" == $pattern ]] && return 0
    done

    for pattern in "${TARGET_TITLES[@]}"; do
        [[ "$window_title" == $pattern ]] && return 0
    done

    return 1
}

use_target_layout() {
    [ "$current_layout" = target ] && return

    mmsg dispatch 'setoption,xkb_rules_variant,,' >/dev/null && current_layout=target
}

use_default_layout() {
    [ "$current_layout" = default ] && return

    mmsg dispatch 'setoption,xkb_rules_variant,colemak,' >/dev/null && current_layout=default
}

mmsg watch focusing-client | while read -r client; do
    source "$rules_file"

    app_id=$(printf '%s\n' "$client" | jq -r '.appid // empty') || continue
    window_title=$(printf '%s\n' "$client" | jq -r '.title // empty') || continue

    if is_target "$app_id" "$window_title"; then
        use_target_layout
    else
        use_default_layout
    fi
done
