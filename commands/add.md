---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*), Bash(cat *), Bash(gh gist edit *)
description: Add a new todo item with optional project and priority
---

# Add Todo Item

Add a new item to the shared todo list.

## Gist ID
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo-id.sh`

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Arguments

The user's input after `/todo:add` is the item text. It may also include:
- A project name (e.g., `--project fcc-app` or just mentioning the project naturally)
- A priority (e.g., `--priority high` or `high priority`)
- A due date (e.g., `by Friday`, `on March 20`, `due 2026-03-15`, `by end of week`). Convert relative dates to absolute YYYY-MM-DD using today's date.
- Defaults: project = "inbox", priority = "Medium", due date = none

## Steps

1. Parse the item text, project, and priority from the user's input
2. Find the matching `## Project: <name>` section and `### <Priority>` subsection in the todo list above
3. If the project doesn't exist, create it with High/Medium/Low subsections
4. Append `- [ ] <item text> (YYYY-MM-DD)` with today's date. If a due date was provided, append ` {due: YYYY-MM-DD}` after the creation date.
5. Update `<!-- last-updated: ... -->` to current UTC time
6. Write back via heredoc: `cat <<'EOF' | gh gist edit <gist-id> --filename todo.md /dev/stdin`...`EOF`
7. Confirm: "Added '<item>' to <project>/<priority>". If a due date was set, include it in the confirmation.
