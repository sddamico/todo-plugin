---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*)
description: Display the full formatted todo list
---

# Show Todo List

Display the entire todo list formatted nicely.

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Steps

1. Display the full list above formatted in markdown, preserving the project/priority structure. IMPORTANT: Markdown `- [ ]` and `- [x]` render as invisible checkboxes in the terminal. Instead, display items as plain list items with a text prefix: `- \[ \]` for open items and `- \[x\]` for completed items (backslash-escape the brackets so they render as visible text).
2. For open items with a `{due: YYYY-MM-DD}` tag (curly braces only), compare the due date to today's date. Ignore `(created: ...)` dates — those are creation dates, not due dates:
   - **Past due**: prefix the item line with `🔴` and append `**OVERDUE**`
   - **Due today**: prefix the item line with `🟡` and append `**DUE TODAY**`
   - **Future due**: show the due date normally, no special formatting
   - Completed items (`\[x\]`): ignore due dates, no highlighting
   - Strip the raw `{due: ...}` tag from display and show it as `(due YYYY-MM-DD)` instead
