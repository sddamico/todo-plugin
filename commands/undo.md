---
model: haiku
allowed-tools: Bash(gh gist *), Bash(source *), Bash(cat *), mcp:github:get_gist, mcp:github:update_gist
description: Uncheck a completed todo item by fuzzy text match
---

# Undo Todo

Re-open a completed item.

**Gist file:** `todo.md` in the gist configured at `~/.claude/todo-gist.env`

## Arguments

The user's input after `/todo:undo` is a fuzzy text match for the item to re-open.

## Steps

1. Read the gist ID: `source ~/.claude/todo-gist.env` to get `$TODO_GIST_ID`
2. Fetch the gist: `get_gist({ gist_id: "$TODO_GIST_ID" })` (MCP) or `source ~/.claude/todo-gist.env && gh gist view $TODO_GIST_ID -f todo.md --raw` (CLI)
2. Find completed items (`- [x]`) matching the text (case-insensitive substring)
3. If multiple matches, ask the user to clarify
4. Change `- [x]` to `- [ ]` for the matched item
5. Update `<!-- last-updated: ... -->` timestamp
6. Write back: `update_gist({ gist_id: "$TODO_GIST_ID", filename: "todo.md", content: "<full content>" })` (MCP) or pipe via heredoc: `source ~/.claude/todo-gist.env && cat <<'EOF' | gh gist edit $TODO_GIST_ID --filename todo.md /dev/stdin`...`EOF` (CLI)
7. Confirm: "Re-opened '<item>'"
