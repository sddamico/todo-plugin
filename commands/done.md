---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*), Bash(cat *), Bash(gh gist edit *)
description: Mark a todo item as complete by fuzzy text match
---

# Mark Todo Done

Mark an open item as complete.

## Gist ID
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo-id.sh`

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Arguments

The user's input after `/todo:done` is a fuzzy text match for the item to complete.

## Steps

1. Find open items (`- [ ]`) in the todo list above matching the text (case-insensitive substring)
2. If multiple matches, ask the user to clarify
3. Change `- [ ]` to `- [x]` for the matched item and append `(done: YYYY-MM-DD)` with today's date
4. Update `<!-- last-updated: ... -->` timestamp
5. Write back via heredoc: `cat <<'EOF' | gh gist edit <gist-id> --filename todo.md /dev/stdin`...`EOF`
6. Confirm: "Completed '<item>'"
