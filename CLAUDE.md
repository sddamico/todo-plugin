# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Claude Code plugin for managing a shared todo list backed by a GitHub Gist. Provides slash commands for adding, listing, completing, moving, and organizing todo items across projects with priority levels and optional due dates.

## Plugin Structure

```
.claude-plugin/plugin.json     # Plugin manifest
.claude-plugin/marketplace.json # Marketplace entry
commands/                       # Slash commands (auto-discovered .md files)
todo-gist.env                   # User's gist ID (template; actual config at ~/.claude/todo-gist.env)
```

## Adding a New Command

1. Create a `.md` file under `commands/` using kebab-case (e.g., `commands/my-command.md`)
2. Add YAML frontmatter with `model`, `allowed-tools` (if tools are needed), and `description`
3. The `description` field controls when Claude activates the command
4. Use `!`source ~/.claude/todo-gist.env && gh gist view $TODO_GIST_ID -f todo.md --raw`` to pre-fetch gist content into the prompt (saves tool calls)
5. For write commands, also inject the gist ID with `!`source ~/.claude/todo-gist.env && echo $TODO_GIST_ID``

## Setup

After installing the plugin, run `/todo:install` to set up your todo list. The install command offers two options:

1. **Existing gist** — provide a gist ID and the command validates its format before saving
2. **Create new gist** — the command creates a properly formatted gist via `gh gist create` and saves the ID automatically

## Conventions

- All commands use `!`command`` syntax to pre-fetch gist content before the prompt reaches the model
- Read-only commands (show, list, today, projects) need zero tool calls
- Write commands use heredoc piped to `/dev/stdin` instead of tmp files
- Due dates are stored as `{due: YYYY-MM-DD}` tags inline with items
- Creation dates are stored as `(YYYY-MM-DD)` at the end of item text
- Commands run on Haiku model for speed
