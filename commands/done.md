---
model: haiku
allowed-tools: Bash(gh gist *), Bash(source *), Bash(cat *), mcp:github:get_gist, mcp:github:update_gist
description: Mark a todo item as complete by fuzzy text match
---

# Mark Todo Done

Mark an open item as complete.

**Gist file:** `todo.md` in the gist configured at `~/.claude/todo-gist.env`

## Arguments

The user's input after `/todo:done` is a fuzzy text match for the item to complete.

## Steps

1. Read the gist ID: `source ~/.claude/todo-gist.env` to get `$TODO_GIST_ID`
2. Fetch the gist: `get_gist({ gist_id: "$TODO_GIST_ID" })` (MCP) or `source ~/.claude/todo-gist.env && gh gist view $TODO_GIST_ID -f todo.md --raw` (CLI)
3. Find open items (`- [ ]`) matching the text (case-insensitive substring)
4. If multiple matches, ask the user to clarify
5. Change `- [ ]` to `- [x]` for the matched item
6. Update `<!-- last-updated: ... -->` timestamp
7. Write back: `update_gist({ gist_id: "$TODO_GIST_ID", filename: "todo.md", content: "<full content>" })` (MCP) or pipe via heredoc: `source ~/.claude/todo-gist.env && cat <<'EOF' | gh gist edit $TODO_GIST_ID --filename todo.md /dev/stdin`...`EOF` (CLI)
8. Confirm: "Completed '<item>'"
