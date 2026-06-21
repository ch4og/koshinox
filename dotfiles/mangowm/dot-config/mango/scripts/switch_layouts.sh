#!/usr/bin/env bash

TARGET_APPIDS=(
    "\.exe$"
    "^steam_app_"
)

TARGET_TITLES=(
    "Terraria"
)

declare -A APPID_BY_MONITOR
declare -A TITLE_BY_MONITOR

CURRENT_LAYOUT="default"
LOCKFILE="/tmp/layout_switch.lock"
LAST_APPID=""

is_target_appid() {
    local appid="$1"
    [ -z "$appid" ] && return 1
    for pattern in "${TARGET_APPIDS[@]}"; do
        [[ "$appid" =~ $pattern ]] && return 0
    done
    return 1
}

is_target_title() {
    local title="$1"
    [ -z "$title" ] && return 1
    for pattern in "${TARGET_TITLES[@]}"; do
        [[ "$title" =~ $pattern ]] && return 0
    done
    return 1
}

handle_focus_change() {
    local monitor="$1"
    local appid="${APPID_BY_MONITOR[$monitor]}"
    local title="${TITLE_BY_MONITOR[$monitor]}"

    if is_target_appid "$appid" || is_target_title "$title"; then
        if [ "$CURRENT_LAYOUT" != "game" ]; then
            echo "Switching layout to 'game' (appid='$appid', title='$title') on monitor '$monitor'..."
            setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle
            CURRENT_LAYOUT="game"
        fi
    elif [ "$CURRENT_LAYOUT" = "game" ]; then
        echo "Switching back to 'default' layout (appid='$appid', title='$title') on monitor '$monitor'..."
        setxkbmap -model pc105 -layout us,ru -variant colemak, -option grp:alt_shift_toggle
        CURRENT_LAYOUT="default"
    fi

    LAST_APPID="$appid"
}

exec 204>"$LOCKFILE"
flock -n 204 || { echo "Another instance is running"; exit 1; }

mmsg -w | while IFS= read -r line; do
    monitor="${line%% *}"
    rest="${line#* }"

    if [[ "$rest" == *" "* ]]; then
        event="${rest%% *}"
        value="${rest#* }"
    else
        event="$rest"
        value=""
    fi

    case "$event" in
        selmon)
            if [ "$value" = "1" ]; then
                CURRENT_MONITOR="$monitor"
                handle_focus_change "$monitor"
            fi
            ;;
        appid)
            APPID_BY_MONITOR["$monitor"]="$value"
            if [ "$monitor" = "$CURRENT_MONITOR" ]; then
                handle_focus_change "$monitor"
            fi
            ;;
        title)
            TITLE_BY_MONITOR["$monitor"]="$value"
            if [ "$monitor" = "$CURRENT_MONITOR" ]; then
                handle_focus_change "$monitor"
            fi
            ;;
    esac
done
