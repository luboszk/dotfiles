#!/usr/bin/env bash
# Claude Code status line - mirrors Starship default prompt style

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Directory: show basename, but keep ~ for home
home="$HOME"
if [[ "$cwd" == "$home" ]]; then
  dir="~"
elif [[ "$cwd" == "$home/"* ]]; then
  dir="~/$(basename "$cwd")"
else
  dir="$(basename "$cwd")"
fi

# Git branch (skip optional lock to avoid blocking)
branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" -c core.hooksPath=/dev/null symbolic-ref --short HEAD 2>/dev/null \
            || git -C "$cwd" -c core.hooksPath=/dev/null rev-parse --short HEAD 2>/dev/null)
fi

# Build the line
parts=()

# user@host dir
parts+=("$(whoami)@$(hostname -s) $dir")

# git branch
[ -n "$branch" ] && parts+=(" $branch")

# model
[ -n "$model" ] && parts+=("$model")

# context usage
if [ -n "$used_pct" ]; then
  printf -v used_pct_int "%.0f" "$used_pct"
  parts+=("ctx:${used_pct_int}%")
fi

printf "%s" "${parts[*]}"
