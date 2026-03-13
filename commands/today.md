---
model: haiku
allowed-tools: Bash(gh gist *), Bash(source *), mcp:github:get_gist
description: Show today's agenda — due/overdue items, then high priority, then project summary
---

# Today's Todo Agenda

Show the most important items for today. This is a triaged view, not the full list.

**Gist file:** `todo.md` in the gist configured at `~/.claude/plugins/local/todo/todo-gist.env`

## Steps

1. Read the gist ID: `source ~/.claude/plugins/local/todo/todo-gist.env` to get `$TODO_GIST_ID`
2. Fetch the gist: `get_gist({ gist_id: "$TODO_GIST_ID" })` (MCP) or `source ~/.claude/plugins/local/todo/todo-gist.env && gh gist view $TODO_GIST_ID -f todo.md --raw` (CLI)
3. Scan ALL open items (`- [ ]`) across ALL projects for `{due: YYYY-MM-DD}` tags. Compare each due date to today's date.
4. Display based on this priority cascade:

### Tier 1: Due or overdue items exist
If any open items are due today or overdue, display them grouped by project:
- 🔴 prefix + **OVERDUE** suffix for past-due items
- 🟡 prefix + **DUE TODAY** suffix for items due today
- Strip the raw `{due: ...}` tag and show as `(due YYYY-MM-DD)`
- Use `\[ \]` (escaped brackets) so checkboxes render visibly

### Tier 2: No due items, but high priority items exist
If no items are due/overdue, check for open items under any `### High` section across all projects. Display them grouped by project with escaped checkboxes. Say "Nothing due today, but here are your high priority items:"

### Tier 3: No due items and no high priority items
If neither due/overdue nor high priority items exist, say "Nothing high priority for today." Then list which projects have open items and how many, so the user knows where pending work lives.

This is a read-only command — do not write back to the gist.
