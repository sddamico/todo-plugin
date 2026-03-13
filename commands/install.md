---
model: haiku
allowed-tools: Write, AskUserQuestion
description: Configure the gist ID used by the todo list
---

# Install Todo List

Configure which GitHub Gist backs the shared todo list.

**Env file:** `~/.claude/plugins/local/todo/todo-gist.env`

## Steps

1. Ask the user for their GitHub Gist ID (the hex string from the gist URL)
2. Write `TODO_GIST_ID=<id>\n` to `~/.claude/plugins/local/todo/todo-gist.env` using the Write tool
3. Confirm: "Todo list configured with gist `<id>`"
