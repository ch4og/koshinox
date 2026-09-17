#!/usr/bin/env bash

spotify_players=(fastpotify spotify spotifyd)
ayugram_player=AyuGramDesktop

player_status() {
	playerctl -p "$1" status 2>/dev/null
}

first_spotify_player() {
	local wanted player status

	for wanted in "$@"; do
		for player in "${spotify_players[@]}"; do
			status=$(player_status "$player")
			if [[ "$status" == "$wanted" ]]; then
				printf '%s\n' "$player"
				return
			fi
		done
	done
}

select_player() {
	local ayugram_status spotify_player

	ayugram_status=$(player_status "$ayugram_player")

	# A playing Spotify client always has priority.
	spotify_player=$(first_spotify_player Playing)
	if [[ -n "$spotify_player" ]]; then
		printf '%s\n' "$spotify_player"
		return
	fi

	# AyuGram takes over as soon as Spotify is no longer playing.
	if [[ "$ayugram_status" == "Playing" ]]; then
		printf '%s\n' "$ayugram_player"
		return
	fi

	# Keep showing Spotify when it is running but stopped or paused.
	spotify_player=$(first_spotify_player Paused Stopped)
	if [[ -n "$spotify_player" ]]; then
		printf '%s\n' "$spotify_player"
		return
	fi
}

player=$(select_player)

if [[ -n "${1:-}" ]]; then
	case "$1" in
		play-pause|previous|next)
			[[ -n "$player" ]] && playerctl -p "$player" "$1"
			;;
	esac
	exit 0
fi

if [[ -n "$player" ]]; then
	status=$(player_status "$player")
	title=$(playerctl -p "$player" metadata title 2>/dev/null)
	artist=$(playerctl -p "$player" metadata artist 2>/dev/null)
else
	status=Stopped
	title=
	artist=
fi

escape() {
	sed -e 's/&/\&amp;/g' \
		-e 's/</\&lt;/g' \
		-e 's/>/\&gt;/g'
}

if [[ "$status" == "Playing" ]]; then
	text="$artist - $title"
	alt="playing"
elif [[ "$status" == "Paused" ]]; then
	text="$artist - $title"
	alt="paused"
elif [[ -n "$player" ]]; then
	text=""
	alt="stopped"
else
	text=""
	alt="none"
fi

text=$(printf '%s' "$text" | escape)

output=$(jq -n --unbuffered --compact-output \
	--arg alt "$alt" \
	--arg text "$text" \
	'{text: $text, alt: $alt}')
echo "$output"
