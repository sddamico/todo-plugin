---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*), Bash(cat *), Bash(gh gist edit *), AskUserQuestion
description: Fix formatting issues on todo items — backfill missing dates, migrate old date formats, normalize due date syntax
---

# Fix Todo Formatting

Scan the todo list for formatting issues and fix them in one pass.

## Today's date
!`date +%Y-%m-%d`

## Gist ID
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo-id.sh`

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Issues to detect and fix

Scan every item in the list for these issues:

### 1. Missing creation date
Open items (`- [ ]`) with no `(created: YYYY-MM-DD)` tag. Fix: append `(created: TODAY)`.

### 2. Old-format creation date
Items with a bare `(YYYY-MM-DD)` at the end (not prefixed by `created:`, `done:`, or `due:`). Fix: convert to `(created: YYYY-MM-DD)`.

### 3. Missing done date
Completed items (`- [x]`) with no `(done: YYYY-MM-DD)` tag. Fix: append `(done: TODAY)`.

### 4. Due date in wrong format
Items with `(due: YYYY-MM-DD)` using parentheses instead of curly braces. Fix: convert to `{due: YYYY-MM-DD}`.

## Steps

1. Scan every item in the todo list above for the four issues listed
2. If no issues are found, say "No formatting issues found" and stop
3. List all issues found, grouped by type, showing the affected items
4. Use AskUserQuestion to confirm: "Found N formatting issues. Apply all fixes?" with options "Yes, fix all", "Cancel"
5. If confirmed, apply all fixes to the todo list
6. Update `<!-- last-updated: ... -->` timestamp
7. Write back via heredoc: `cat <<'EOF' | gh gist edit <gist-id> --filename todo.md /dev/stdin`...`EOF`
8. Confirm: "Fixed N items: X creation dates added, Y done dates added, Z date formats migrated"
