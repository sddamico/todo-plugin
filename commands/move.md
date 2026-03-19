---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*), Bash(cat *), Bash(gh gist edit *)
description: Move a todo item between projects and/or priorities
---

# Move Todo

Move an item to a different project and/or priority.

## Gist ID
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo-id.sh`

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Arguments

The user's input after `/todo:move` includes:
- Item text (fuzzy match)
- Target project and/or priority (e.g., `--project personal --priority high`)

## Steps

1. Find the item in the todo list above by fuzzy text match (case-insensitive substring)
2. If multiple matches, ask the user to clarify
3. Remove the item from its current location
4. Add it under the target project/priority (create project section if it doesn't exist)
5. Preserve empty section headers
6. Update `<!-- last-updated: ... -->` timestamp
7. Write back via heredoc: `cat <<'EOF' | gh gist edit <gist-id> --filename todo.md /dev/stdin`...`EOF`
8. Confirm: "Moved '<item>' to <project>/<priority>"
