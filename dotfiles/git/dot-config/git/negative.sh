#!/bin/sh

set -eu

if [ "$#" -ne 0 ]; then
    printf '%s\n' 'usage: git negative' >&2
    exit 1
fi

cd "$(git rev-parse --show-toplevel)"
index=$(git rev-parse --path-format=absolute --git-path index)
lock=$index.lock
if ! (set -C; : >"$lock") 2>/dev/null; then
    printf '%s\n' "git negative: index is locked: $lock" >&2
    exit 1
fi

tmp=
cleanup() {
    rm -f "$lock"
    if [ -n "$tmp" ]; then
        rm -rf "$tmp"
    fi
}
trap cleanup EXIT
trap 'exit 1' HUP INT TERM

tmp=$(mktemp -d "${index}.negative.XXXXXX")
if [ -f "$index" ]; then
    cp "$index" "$tmp/index"
fi
export GIT_INDEX_FILE="$tmp/index"

if [ -n "$(git ls-files --unmerged)" ]; then
    printf '%s\n' 'git negative: resolve existing conflicts first; index unchanged' >&2
    exit 1
fi

# Capture index -> working tree, including untracked files, without staging them.
staged=$(git write-tree)
git add -A
working=$(git write-tree)
git diff --binary --full-index --no-ext-diff --no-textconv --no-renames \
    "$staged" "$working" >"$tmp/unstaged.patch"

if head=$(git rev-parse --verify HEAD 2>/dev/null); then
    git read-tree "$head"
else
    git symbolic-ref -q HEAD >/dev/null
    git read-tree --empty
fi

# Merge the unstaged changes onto HEAD, excluding the previously staged changes.
if [ -s "$tmp/unstaged.patch" ]; then
    if ! git apply --cached --3way --whitespace=nowarn "$tmp/unstaged.patch"; then
        printf '%s\n' 'git negative: changes cannot be inverted independently; index unchanged' >&2
        exit 1
    fi
fi

cp "$GIT_INDEX_FILE" "$lock"
mv -f "$lock" "$index"
