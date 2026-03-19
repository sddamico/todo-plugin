#!/bin/bash
source ~/.claude/todo-gist.env
gh gist view "$TODO_GIST_ID" -f todo.md --raw
