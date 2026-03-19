---
model: haiku
allowed-tools: Bash(${CLAUDE_PLUGIN_ROOT}/bin/*)
description: List all project names in the todo list
---

# List Projects

Show all project names from the todo list. You MUST output every project — never summarize or skip. A brief conversational note is fine, but the full list is the primary output.

## Current todo list
!`${CLAUDE_PLUGIN_ROOT}/bin/get-todo.sh`

## Steps

1. Extract all `## Project: <name>` headers from the todo list above
2. List them with a count of open items in each

This is a read-only command — do not write back to the gist.
