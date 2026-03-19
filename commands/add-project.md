---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*), Bash(cat *), Bash(gh gist edit *)
description: Create a new project section in the todo list
---

# Add Project

Create a new project section with High/Medium/Low subsections.

## Gist ID
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo-id.sh`

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Arguments

The user's input after `/todo:add-project` is the project name.

## Steps

1. Check if a project with that name already exists in the todo list above (case-insensitive). If so, inform the user.
2. Append a new section at the end:
   ```
   ## Project: <Name>
   ### High
   ### Medium
   ### Low
   ```
3. Update `<!-- last-updated: ... -->` timestamp
4. Write back via heredoc: `cat <<'EOF' | gh gist edit <gist-id> --filename todo.md /dev/stdin`...`EOF`
5. Confirm: "Created project '<name>'"
