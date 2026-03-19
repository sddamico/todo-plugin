---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*), Bash(cat *), Bash(gh gist edit *)
description: Delete a todo item entirely by fuzzy text match
---

# Remove Todo

Permanently delete an item from the list.

## Gist ID
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo-id.sh`

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Arguments

The user's input after `/todo:remove` is a fuzzy text match for the item to delete.

## Steps

1. Find items in the todo list above matching the text (case-insensitive substring, searches both open and completed)
2. If multiple matches, ask the user to clarify
3. Remove the entire line for the matched item
4. Preserve empty `### High/Medium/Low` sections — never delete section headers
5. Update `<!-- last-updated: ... -->` timestamp
6. Write back via heredoc: `cat <<'EOF' | gh gist edit <gist-id> --filename todo.md /dev/stdin`...`EOF`
7. Confirm: "Removed '<item>'"
