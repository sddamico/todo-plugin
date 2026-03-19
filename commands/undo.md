---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*), Bash(cat *), Bash(gh gist edit *)
description: Uncheck a completed todo item by fuzzy text match
---

# Undo Todo

Re-open a completed item.

## Gist ID
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo-id.sh`

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Arguments

The user's input after `/todo:undo` is a fuzzy text match for the item to re-open.

## Steps

1. Find completed items (`- [x]`) in the todo list above matching the text (case-insensitive substring)
2. If multiple matches, ask the user to clarify
3. Change `- [x]` to `- [ ]` for the matched item and remove any `(done: YYYY-MM-DD)` tag
4. Update `<!-- last-updated: ... -->` timestamp
5. Write back via heredoc: `cat <<'EOF' | gh gist edit <gist-id> --filename todo.md /dev/stdin`...`EOF`
6. Confirm: "Re-opened '<item>'"
