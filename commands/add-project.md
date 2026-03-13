---
model: haiku
allowed-tools: Bash(gh gist *), Bash(source *), Bash(cat *), mcp:github:get_gist, mcp:github:update_gist
description: Create a new project section in the todo list
---

# Add Project

Create a new project section with High/Medium/Low subsections.

**Gist file:** `todo.md` in the gist configured at `~/.claude/todo-gist.env`

## Arguments

The user's input after `/todo:add-project` is the project name.

## Steps

1. Read the gist ID: `source ~/.claude/todo-gist.env` to get `$TODO_GIST_ID`
2. Fetch the gist: `get_gist({ gist_id: "$TODO_GIST_ID" })` (MCP) or `source ~/.claude/todo-gist.env && gh gist view $TODO_GIST_ID -f todo.md --raw` (CLI)
2. Check if a project with that name already exists (case-insensitive). If so, inform the user.
3. Append a new section at the end:
   ```
   ## Project: <Name>
   ### High
   ### Medium
   ### Low
   ```
4. Update `<!-- last-updated: ... -->` timestamp
6. Write back: `update_gist({ gist_id: "$TODO_GIST_ID", filename: "todo.md", content: "<full content>" })` (MCP) or pipe via heredoc: `source ~/.claude/todo-gist.env && cat <<'EOF' | gh gist edit $TODO_GIST_ID --filename todo.md /dev/stdin`...`EOF` (CLI)
6. Confirm: "Created project '<name>'"
