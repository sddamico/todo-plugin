# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Claude Code plugin for managing a shared todo list backed by a GitHub Gist. Provides slash commands for adding, listing, completing, moving, and organizing todo items across projects with priority levels and optional due dates.

## Plugin Structure

```
.claude-plugin/plugin.json     # Plugin manifest
.claude-plugin/marketplace.json # Marketplace entry
commands/                       # Slash commands (auto-discovered .md files)
todo-gist.env                   # User's gist ID configuration
```

## Adding a New Command

1. Create a `.md` file under `commands/` using kebab-case (e.g., `commands/my-command.md`)
2. Add YAML frontmatter with `model`, `allowed-tools`, and `description`
3. The `description` field controls when Claude activates the command
4. All commands should source `todo-gist.env` to get the gist ID rather than hardcoding it

## Setup

After installing the plugin, run `/todo:install` to configure your GitHub Gist ID. The gist should contain a `todo.md` file with the expected markdown format (projects with High/Medium/Low priority sections).

## Conventions

- All write commands use heredoc piped to `/dev/stdin` instead of tmp files
- Due dates are stored as `{due: YYYY-MM-DD}` tags inline with items
- Creation dates are stored as `(YYYY-MM-DD)` at the end of item text
- Commands run on Haiku model for speed
