---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*)
description: Show today's agenda — due/overdue items, then high priority, then project summary
---

# Today's Todo Agenda

Show the most important items for today. This is a triaged view, not the full list.

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Steps

1. Scan ALL open items (`- [ ]`) across ALL projects in the todo list above for `{due: YYYY-MM-DD}` tags (curly braces only). Compare each due date to today's date. Ignore `(created: ...)` dates — those are creation dates, not due dates.
2. Display based on this priority cascade:

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
