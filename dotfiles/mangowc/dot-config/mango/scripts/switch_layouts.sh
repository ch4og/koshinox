#!/usr/bin/env bash

TARGET_APPS=(
    "\.exe$"
    "^steam_app_"
)

declare -A APPID_BY_MONITOR
CURRENT_LAYOUT="default"
LOCKFILE="/tmp/layout_switch.lock"
LAST_APPID=""

is_target_app() {
    local appid="$1"
    for target in "${TARGET_APPS[@]}"; do
        if [[ "$appid" =~ $target ]]; then
            return 0
        fi
    done
    return 1
}

handle_focus_change() {
    local monitor="$1"
    local appid="${APPID_BY_MONITOR[$monitor]}"

    if is_target_app "$appid"; then
        if [ "$CURRENT_LAYOUT" != "game" ]; then
            echo "Switching layout to 'game' for app '$appid' on monitor '$monitor'..."
            mmsg -d "setoption,xkb_rules_variant,,"
            mmsg -d "setoption,xkb_rules_variant,,"
            mmsg -d "setoption,xkb_rules_variant,,"
            mmsg -d "setoption,xkb_rules_variant,,"
            CURRENT_LAYOUT="game"
        fi
    elif [ "$CURRENT_LAYOUT" = "game" ]; then
        echo "Switching back to 'default' layout on monitor '$monitor'..."
        mmsg -d "setoption,xkb_rules_variant,colemak,"
        mmsg -d "setoption,xkb_rules_variant,colemak,"
        mmsg -d "setoption,xkb_rules_variant,colemak,"
        mmsg -d "setoption,xkb_rules_variant,colemak,"
        CURRENT_LAYOUT="default"
    fi

    LAST_APPID="$appid"
}

exec 204>"$LOCKFILE"
flock -n 204 || { echo "Another instance is running"; exit 1; }

mmsg -w | while read -r monitor event value; do
    case "$event" in
        "appid")
            APPID_BY_MONITOR["$monitor"]="$value"
            ;;
        "selmon")
            if [ "$value" = "1" ]; then
                if [ "${APPID_BY_MONITOR[$monitor]}" != "$LAST_APPID" ]; then
                    handle_focus_change "$monitor"
                fi
            fi
            ;;
    esac
done
