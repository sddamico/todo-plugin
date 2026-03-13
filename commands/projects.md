---
model: haiku
allowed-tools: Bash(gh gist *), Bash(source *), mcp:github:get_gist
description: List all project names in the todo list
---

# List Projects

Show all project names from the todo list.

**Gist file:** `todo.md` in the gist configured at `~/.claude/plugins/local/todo/todo-gist.env`

## Steps

1. Read the gist ID: `source ~/.claude/plugins/local/todo/todo-gist.env` to get `$TODO_GIST_ID`
2. Fetch the gist: `get_gist({ gist_id: "$TODO_GIST_ID" })` (MCP) or `source ~/.claude/plugins/local/todo/todo-gist.env && gh gist view $TODO_GIST_ID -f todo.md --raw` (CLI)
2. Extract all `## Project: <name>` headers
3. List them with a count of open items in each

This is a read-only command — do not write back to the gist.
