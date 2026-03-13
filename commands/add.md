---
model: haiku
allowed-tools: Bash(gh gist *), Bash(source *), Bash(cat *), mcp:github:get_gist, mcp:github:update_gist
description: Add a new todo item with optional project and priority
---

# Add Todo Item

Add a new item to the shared todo list.

**Gist file:** `todo.md` in the gist configured at `~/.claude/plugins/local/todo/todo-gist.env`

## Arguments

The user's input after `/todo:add` is the item text. It may also include:
- A project name (e.g., `--project fcc-app` or just mentioning the project naturally)
- A priority (e.g., `--priority high` or `high priority`)
- A due date (e.g., `by Friday`, `on March 20`, `due 2026-03-15`, `by end of week`). Convert relative dates to absolute YYYY-MM-DD using today's date.
- Defaults: project = "inbox", priority = "Medium", due date = none

## Steps

1. Read the gist ID: `source ~/.claude/plugins/local/todo/todo-gist.env` to get `$TODO_GIST_ID`
2. Fetch the gist: `get_gist({ gist_id: "$TODO_GIST_ID" })` (MCP) or `source ~/.claude/plugins/local/todo/todo-gist.env && gh gist view $TODO_GIST_ID -f todo.md --raw` (CLI)
2. Parse the item text, project, and priority from the user's input
3. Find the matching `## Project: <name>` section and `### <Priority>` subsection
4. If the project doesn't exist, create it with High/Medium/Low subsections
5. Append `- [ ] <item text> (YYYY-MM-DD)` with today's date. If a due date was provided, append ` {due: YYYY-MM-DD}` after the creation date.
6. Update `<!-- last-updated: ... -->` to current UTC time
7. Write back: `update_gist({ gist_id: "$TODO_GIST_ID", filename: "todo.md", content: "<full content>" })` (MCP) or pipe via heredoc: `source ~/.claude/plugins/local/todo/todo-gist.env && cat <<'EOF' | gh gist edit $TODO_GIST_ID --filename todo.md /dev/stdin`...`EOF` (CLI)
8. Confirm: "Added '<item>' to <project>/<priority>". If a due date was set, include it in the confirmation.
