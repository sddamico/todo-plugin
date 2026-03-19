---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*), Bash(cat *), Bash(gh gist edit *), AskUserQuestion
description: Remove completed todo items older than a cutoff date. By default clears items completed yesterday or earlier.
---

# Clear Done Items

Remove completed items from the todo list based on their completion date.

## Today's date
!`date +%Y-%m-%d`

## Gist ID
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo-id.sh`

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Steps

1. Scan the todo list above for completed items (`- [x]`) that have a `(done: YYYY-MM-DD)` tag
2. Determine the cutoff date:
   - Default: yesterday (items completed yesterday or earlier will be removed)
   - If the user provided a date argument after `/todo:clear-done`, use that as the cutoff instead
3. Identify all completed items whose `(done: YYYY-MM-DD)` date is **on or before** the cutoff date
4. Also identify any completed items that have **no** `(done: ...)` tag — include these in the list to present to the user
5. Use AskUserQuestion to confirm with the user before removing anything. Show them:
   - The cutoff date being used
   - The list of items that will be removed
   - Options: "Yes, clear all listed items", "Let me specify a different date", "Cancel"
6. If the user picks a different date, re-filter with their new date and ask again
7. If confirmed, remove the matched lines from the todo list
8. Preserve empty `### High/Medium/Low` sections — never delete section headers
9. Update `<!-- last-updated: ... -->` timestamp
10. Write back via heredoc: `cat <<'EOF' | gh gist edit <gist-id> --filename todo.md /dev/stdin`...`EOF`
11. Confirm: "Cleared N completed items (completed on or before YYYY-MM-DD)"
