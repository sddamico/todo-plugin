---
model: haiku
allowed-tools: Bash(gh gist *), Bash(source *), Bash(cat *), mcp:github:get_gist, mcp:github:update_gist
description: Move a todo item between projects and/or priorities
---

# Move Todo

Move an item to a different project and/or priority.

**Gist file:** `todo.md` in the gist configured at `~/.claude/todo-gist.env`

## Arguments

The user's input after `/todo:move` includes:
- Item text (fuzzy match)
- Target project and/or priority (e.g., `--project personal --priority high`)

## Steps

1. Read the gist ID: `source ~/.claude/todo-gist.env` to get `$TODO_GIST_ID`
2. Fetch the gist: `get_gist({ gist_id: "$TODO_GIST_ID" })` (MCP) or `source ~/.claude/todo-gist.env && gh gist view $TODO_GIST_ID -f todo.md --raw` (CLI)
2. Find the item by fuzzy text match (case-insensitive substring)
3. If multiple matches, ask the user to clarify
4. Remove the item from its current location
5. Add it under the target project/priority (create project section if it doesn't exist)
6. Preserve empty section headers
7. Update `<!-- last-updated: ... -->` timestamp
9. Write back: `update_gist({ gist_id: "$TODO_GIST_ID", filename: "todo.md", content: "<full content>" })` (MCP) or pipe via heredoc: `source ~/.claude/todo-gist.env && cat <<'EOF' | gh gist edit $TODO_GIST_ID --filename todo.md /dev/stdin`...`EOF` (CLI)
9. Confirm: "Moved '<item>' to <project>/<priority>"
