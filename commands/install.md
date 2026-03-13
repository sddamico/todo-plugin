---
model: haiku
allowed-tools: Bash(gh gist *), Bash(source *), AskUserQuestion, Write
description: Configure the gist ID used by the todo list
---

# Install Todo List

Configure which GitHub Gist backs the shared todo list.

**Env file:** `~/.claude/todo-gist.env`

## Steps

1. Ask the user: "Do you have an existing GitHub Gist for your todo list, or would you like to create a new one?" with options **Existing gist** and **Create new gist**.

### Existing gist flow

2. Ask the user for their GitHub Gist ID (the hex string from the gist URL).
3. Fetch the gist with `gh gist view <id> -f todo.md --raw` to validate it.
4. Validate the content has ALL of the following:
   - A `# Todo List` header
   - A `<!-- last-updated:` comment
   - At least one `## Project:` section with `### High`, `### Medium`, and `### Low` subsections
5. If valid: write `TODO_GIST_ID=<id>` to `~/.claude/todo-gist.env` using the Write tool. Confirm: "Todo list configured with gist `<id>`."
6. If invalid: warn the user about exactly what's missing or wrong with the format. Do NOT save the gist ID. Suggest they either fix the gist or use the "Create new gist" option instead.

### New gist flow

2. Create a new gist by running:
   ```
   gh gist create -p -d "Todo List" -f todo.md - <<'EOF'
   # Todo List

   <!-- last-updated: TIMESTAMP -->

   ## Project: inbox

   ### High

   ### Medium

   ### Low
   EOF
   ```
   Replace `TIMESTAMP` with the current UTC timestamp in ISO 8601 format (e.g., `2026-03-12T15:30:00Z`).
3. Extract the gist ID from the URL in the command output (the last path segment of the URL).
4. Write `TODO_GIST_ID=<id>` to `~/.claude/todo-gist.env` using the Write tool.
5. Confirm: "Todo list created and configured! Gist URL: `<url>`"
