#!/usr/bin/env bash

colors=(
    "{{base16.base00.default.hex}}"
    "{{base16.base01.default.hex | lighten: 10.0}}"
    "{{base16.base02.default.hex | lighten: 10.0}}"
    "{{base16.base03.default.hex | lighten: 10.0}}"
    "{{base16.base04.default.hex | lighten: 5.0}}"
    "{{base16.base05.default.hex}}"
    "{{base16.base06.default.hex}}"
    "{{base16.base07.default.hex}}"
    "{{base16.base08.default.hex}}"
    "{{base16.base09.default.hex}}"
    "{{base16.base0a.default.hex}}"
    "{{base16.base0b.default.hex}}"
    "{{base16.base0c.default.hex}}"
    "{{base16.base0d.default.hex}}"
    "{{base16.base0e.default.hex | lighten: 10.0}}"
    "{{base16.base0f.default.hex}}"
)

for i in "${!colors[@]}"; do
    printf '\033]4;%d;%s\033\\' "$i" "${colors[$i]}"
done

printf '\033]11;{{colors.background.default.hex}}\033\\'
printf '\033]10;{{colors.on_surface.default.hex}}\033\\'
printf '\033]12;{{colors.primary.default.hex}}\033\\'

printf '\033]7044;{{colors.primary.dark.hex}}\033\\'
