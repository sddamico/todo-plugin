# Todo Plugin for Claude Code

A Claude Code plugin for managing a shared todo list backed by a GitHub Gist. Instead of switching between apps to track tasks, this plugin lets you manage your todo list directly inside Claude Code with slash commands.

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-03-12 | Initial release with full CRUD commands, due dates, priority tiers, and daily agenda view |

## Installation

### Step 1: Add marketplace and install

```bash
claude
/plugin marketplace add https://github.com/sddamico/todo-plugin.git
/plugin install todo@todo-plugin
```

### Step 2: Configure your Gist

Create a GitHub Gist with a `todo.md` file, then run:

```
/todo:install
```

This will prompt you for your Gist ID and save it locally.

### Step 3: Enable auto-update (recommended)

Auto-update keeps your commands in sync with the latest changes on `main`. To enable:

1. Run `/plugin` in Claude Code
2. Select **Marketplaces**
3. Choose `todo-plugin`
4. Select **Enable auto-update**

---

## Commands

| Command | Description |
|---------|-------------|
| `/todo:show` | Display the full formatted todo list |
| `/todo:list` | List open items, optionally filtered by project or priority |
| `/todo:today` | Show today's agenda — due/overdue items, then high priority, then project summary |
| `/todo:add` | Add a new item with optional project, priority, and due date |
| `/todo:done` | Mark an item as complete by fuzzy text match |
| `/todo:undo` | Re-open a completed item by fuzzy text match |
| `/todo:remove` | Delete an item entirely by fuzzy text match |
| `/todo:move` | Move an item between projects and/or priorities |
| `/todo:projects` | List all projects with open item counts |
| `/todo:add-project` | Create a new project section |
| `/todo:install` | Configure which GitHub Gist backs the todo list |

### Getting started

Run `/todo:install` first to connect your GitHub Gist. Then just use natural language:

```
/todo:add fix the login bug by Friday --project my-app --priority high
/todo:list my-app
/todo:done login bug
/todo:today
```

### Due dates

Items can have optional due dates. Add them naturally when creating items:

```
/todo:add deploy new API by March 20
/todo:add review PR by tomorrow
```

Due dates show up as color-coded indicators in `/todo:today`, `/todo:show`, and `/todo:list`.

---

## Contributing

To add a new command:

1. Create a `.md` file under `commands/` using kebab-case (e.g., `commands/my-command.md`)
2. Add YAML frontmatter:
   ```yaml
   ---
   model: haiku
   allowed-tools: Bash(gh gist *), Bash(source *), mcp:github:get_gist
   description: Short description of what the command does
   ---
   ```
3. Write step-by-step instructions in the body
4. Source `todo-gist.env` for the gist ID — never hardcode it
5. Update the **Commands** table in this README
6. Open a pull request

---

## Project Structure

```
todo-plugin/
├── .claude-plugin/
│   ├── plugin.json          # Plugin metadata
│   └── marketplace.json     # Marketplace registry
├── commands/
│   ├── add.md               # Add a todo item
│   ├── add-project.md       # Create a new project
│   ├── done.md              # Mark item complete
│   ├── install.md           # Configure gist ID
│   ├── list.md              # List open items
│   ├── move.md              # Move item between projects/priorities
│   ├── projects.md          # List all projects
│   ├── remove.md            # Delete an item
│   ├── show.md              # Display full todo list
│   ├── today.md             # Daily agenda view
│   └── undo.md              # Re-open a completed item
├── todo-gist.env            # Your gist ID (gitignored)
└── README.md
```
