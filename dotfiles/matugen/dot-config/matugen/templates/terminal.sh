#!/usr/bin/env bash

colors=(
    "{{colors.surface.dark.hex}}"
    "{{colors.error.dark.hex | auto_lightness: 15}}"
    "{{colors.tertiary.dark.hex | auto_lightness: 25}}"
    "{{colors.tertiary.dark.hex | auto_lightness: 20}}"
    "{{colors.secondary.dark.hex | auto_lightness: 25}}"
    "{{colors.secondary.dark.hex | auto_lightness: 20}}"
    "{{colors.primary.dark.hex | auto_lightness: 10}}"
    "{{colors.on_surface_variant.dark.hex}}"
    "{{colors.surface_container_high.dark.hex}}"
    "{{colors.error.dark.hex | auto_lightness: 10}}"
    "{{colors.tertiary.dark.hex | auto_lightness: 10}}"
    "{{colors.tertiary_fixed.dark.hex | auto_lightness: 10}}"
    "{{colors.secondary.dark.hex | auto_lightness: 10}}"
    "{{colors.secondary_fixed.dark.hex | auto_lightness: 10}}"
    "{{colors.primary.dark.hex | auto_lightness: -5}}"
    "{{colors.on_surface.dark.hex}}"
)

for i in "${!colors[@]}"; do
    printf '\033]4;%d;%s\033\\' "$i" "${colors[$i]}"
done

printf '\033]11;{{colors.surface.dark.hex}}\033\\'
printf '\033]19;{{colors.surface.dark.hex}}\033\\'
printf '\033]4;232;{{colors.surface.dark.hex}}\033\\'
printf '\033]4;257;{{colors.surface.dark.hex}}\033\\'
printf '\033]708;{{colors.surface.dark.hex}}\033\\'
printf '\033]10;{{colors.on_surface.dark.hex}}\033\\'
printf '\033]17;{{colors.on_surface.dark.hex}}\033\\'
printf '\033]4;256;{{colors.on_surface.dark.hex}}\033\\'
printf '\033]12;{{colors.on_surface.dark.hex}}\033\\'
printf '\033]13;{{colors.on_surface.dark.hex}}\033\\'
