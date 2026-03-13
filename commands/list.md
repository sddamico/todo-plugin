---
model: haiku
allowed-tools: Bash(gh gist *), Bash(source *), mcp:github:get_gist
description: List todo items, optionally filtered by project or priority
---

# List Todo Items

List open items from the shared todo list, with optional filtering.

**Gist file:** `todo.md` in the gist configured at `~/.claude/plugins/local/todo/todo-gist.env`

## Arguments

The user's input after `/todo:list` is an optional filter:
- A project name (e.g., `fcc-app`, `personal`, `inbox`)
- A priority (e.g., `high`)
- Both (e.g., `fcc-app high`)
- If empty, show all open items grouped by project

## Steps

1. Read the gist ID: `source ~/.claude/plugins/local/todo/todo-gist.env` to get `$TODO_GIST_ID`
2. Fetch the gist: `get_gist({ gist_id: "$TODO_GIST_ID" })` (MCP) or `source ~/.claude/plugins/local/todo/todo-gist.env && gh gist view $TODO_GIST_ID -f todo.md --raw` (CLI)
2. Parse and filter items based on user input (case-insensitive matching on project names)
3. Display only open items (`- [ ]`), grouped by project and priority
4. For items with a `{due: YYYY-MM-DD}` tag, compare the due date to today's date:
   - **Past due**: prefix the item line with `🔴` and append `**OVERDUE**`
   - **Due today**: prefix the item line with `🟡` and append `**DUE TODAY**`
   - **Future due**: show the due date normally, no special formatting
   - Strip the raw `{due: ...}` tag from display and show it as `(due YYYY-MM-DD)` instead
5. If no items match, say so

This is a read-only command — do not write back to the gist.
