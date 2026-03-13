---
model: haiku
allowed-tools: Bash(gh gist *), Bash(source *), mcp:github:get_gist
description: Display the full formatted todo list
---

# Show Todo List

Display the entire todo list formatted nicely.

**Gist file:** `todo.md` in the gist configured at `~/.claude/plugins/local/todo/todo-gist.env`

## Steps

1. Read the gist ID: `source ~/.claude/plugins/local/todo/todo-gist.env` to get `$TODO_GIST_ID`
2. Fetch the gist: `get_gist({ gist_id: "$TODO_GIST_ID" })` (MCP) or `source ~/.claude/plugins/local/todo/todo-gist.env && gh gist view $TODO_GIST_ID -f todo.md --raw` (CLI)
2. Display the full list formatted in markdown, preserving the project/priority structure. IMPORTANT: Markdown `- [ ]` and `- [x]` render as invisible checkboxes in the terminal. Instead, display items as plain list items with a text prefix: `- \[ \]` for open items and `- \[x\]` for completed items (backslash-escape the brackets so they render as visible text).
3. For open items with a `{due: YYYY-MM-DD}` tag, compare the due date to today's date:
   - **Past due**: prefix the item line with `🔴` and append `**OVERDUE**`
   - **Due today**: prefix the item line with `🟡` and append `**DUE TODAY**`
   - **Future due**: show the due date normally, no special formatting
   - Completed items (`\[x\]`): ignore due dates, no highlighting
   - Strip the raw `{due: ...}` tag from display and show it as `(due YYYY-MM-DD)` instead

This is a read-only command — do not write back to the gist.
