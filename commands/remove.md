---
model: haiku
allowed-tools: Bash(gh gist *), Bash(source *), Bash(cat *), mcp:github:get_gist, mcp:github:update_gist
description: Delete a todo item entirely by fuzzy text match
---

# Remove Todo

Permanently delete an item from the list.

**Gist file:** `todo.md` in the gist configured at `~/.claude/plugins/local/todo/todo-gist.env`

## Arguments

The user's input after `/todo:remove` is a fuzzy text match for the item to delete.

## Steps

1. Read the gist ID: `source ~/.claude/plugins/local/todo/todo-gist.env` to get `$TODO_GIST_ID`
2. Fetch the gist: `get_gist({ gist_id: "$TODO_GIST_ID" })` (MCP) or `source ~/.claude/plugins/local/todo/todo-gist.env && gh gist view $TODO_GIST_ID -f todo.md --raw` (CLI)
2. Find items matching the text (case-insensitive substring, searches both open and completed)
3. If multiple matches, ask the user to clarify
4. Remove the entire line for the matched item
5. Preserve empty `### High/Medium/Low` sections — never delete section headers
6. Update `<!-- last-updated: ... -->` timestamp
8. Write back: `update_gist({ gist_id: "$TODO_GIST_ID", filename: "todo.md", content: "<full content>" })` (MCP) or pipe via heredoc: `source ~/.claude/plugins/local/todo/todo-gist.env && cat <<'EOF' | gh gist edit $TODO_GIST_ID --filename todo.md /dev/stdin`...`EOF` (CLI)
8. Confirm: "Removed '<item>'"
