#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="$HOME/pictures/walls"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper-thumbnails"

mkdir -p "$CACHE_DIR"

get_thumbnail() {
    local file="$1"
    local relative="${file#"$WALLPAPER_DIR"/}"
    local thumbnail="$CACHE_DIR/${relative//\//__}.jpg"

    if [[ ! -f "$thumbnail" || "$file" -nt "$thumbnail" ]]; then
        mkdir -p "$(dirname "$thumbnail")"

        local name
        name="$(basename "$file")"

        convert "$file" \
            -thumbnail '512x512>' \
            -gravity South \
            -background '#000000AA' \
            -fill white \
            -font DejaVu-Sans \
            -pointsize 24 \
            -splice 0x36 \
            -annotate +0+6 "$name" \
            -quality 85 \
            "$thumbnail"
    fi

    printf '%s\n' "$thumbnail"
}

selection=$(
    while IFS= read -r -d '' file; do
        thumbnail="$(get_thumbnail "$file")"

        printf '%s\0icon\x1f%s\0info\x1f%s\n' \
            "$file" \
            "$thumbnail" \
            "$file"
    done < <(
        find "$WALLPAPER_DIR" -type f \
            \( \
                -iname '*.jpg' \
                -o -iname '*.jpeg' \
                -o -iname '*.png' \
                -o -iname '*.webp' \
                -o -iname '*.avif' \
            \) \
            -print0
    ) |
    rofi \
        -dmenu \
        -show-icons \
        -i \
        -theme-str '
            window {
                width: 85%;
                height: 90%;

                location: center;
                anchor: center;

                padding: 12px;
                border: 0px;
            }

            mainbox {
                children: [inputbar, listview];
            }

            listview {
                columns: 5;
                lines: 4;

                spacing: 2px;

                fixed-columns: true;

                scrollbar: false;
            }

            element {
                orientation: vertical;

                padding: 0px;
                margin: 0px;

                horizontal-align: 0.5;
                vertical-align: 0.5;

                border-radius: 8px;
            }

            element normal {
                background-color: transparent;
            }

            element selected {
                background-color: rgba(255, 255, 255, 0.12);
                border-radius: 8px;
            }

            element-icon {
                size: 210px;

                horizontal-align: 0.5;
            }

            element-text {
                enabled: false;
            }

            inputbar {
                enabled: true;

                padding: 4px;
                margin: 0px 0px 4px 0px;
            }
        '
)

[[ -n "$selection" ]] || exit 0

awww img "$selection" \
    --transition-type wipe \
    --transition-step 120 \
    --transition-angle 305 \
    --transition-duration 3 \
    --transition-fps 60
sleep 2.5
matugen image "$selection" --source-color-index 0
