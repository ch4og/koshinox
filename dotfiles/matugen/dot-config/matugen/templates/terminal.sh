#!/usr/bin/env bash

colors=(
    "{{colors.background.default.hex}}"
    "{{colors.error_container.default.hex}}"
    "{{colors.tertiary_container.default.hex}}"
    "{{colors.outline.default.hex}}"
    "{{colors.primary_container.default.hex}}"
    "{{colors.secondary_container.default.hex}}"
    "{{colors.primary.default.hex | lighten: 10.0}}"
    "{{colors.on_surface.default.hex}}"
    "{{colors.surface_variant.default.hex}}"
    "{{colors.error.default.hex}}"
    "{{colors.tertiary.default.hex}}"
    "{{colors.on_surface_variant.default.hex}}"
    "{{colors.primary.default.hex}}"
    "{{colors.secondary.default.hex}}"
    "{{colors.primary.default.hex | lighten: 20.0}}"
    "{{colors.on_surface.default.hex | lighten: 5.0}}"
)

for i in "${!colors[@]}"; do
    printf '\033]4;%d;%s\033\\' "$i" "${colors[$i]}"
done

printf '\033]11;{{colors.background.default.hex}}\033\\'
printf '\033]10;{{colors.on_surface.default.hex}}\033\\'
printf '\033]12;{{colors.primary.default.hex}}\033\\'

printf '\033]7044;{{colors.primary.dark.hex}}\033\\'
