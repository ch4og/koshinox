#!/usr/bin/env sh
wayfreeze --after-freeze-cmd "bash -c 'grim -g \"\$(slurp)\" - > >(swappy -f -); killall wayfreeze'"
