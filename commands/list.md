---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*)
description: List todo items, optionally filtered by project or priority
---

# List Todo Items

List open items from the shared todo list, with optional filtering.

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Arguments

The user's input after `/todo:list` is an optional filter:
- A project name (e.g., `fcc-app`, `personal`, `inbox`)
- A priority (e.g., `high`)
- Both (e.g., `fcc-app high`)
- If empty, show all open items grouped by project

## Steps

1. Parse and filter items from the todo list above based on user input (case-insensitive matching on project names)
3. Display only open items (`- [ ]`), grouped by project and priority
4. For items with a `{due: YYYY-MM-DD}` tag, compare the due date to today's date:
   - **Past due**: prefix the item line with `🔴` and append `**OVERDUE**`
   - **Due today**: prefix the item line with `🟡` and append `**DUE TODAY**`
   - **Future due**: show the due date normally, no special formatting
   - Strip the raw `{due: ...}` tag from display and show it as `(due YYYY-MM-DD)` instead
5. If no items match, say so

This is a read-only command — do not write back to the gist.
