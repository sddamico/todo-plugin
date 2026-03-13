---
name: update-major
description: Bump major version (X.0.0)
---

Bump the major version of the todo plugin.

## Steps

1. Read `.claude-plugin/plugin.json` to get current version
2. Parse version string (format: X.Y.Z)
3. Increment major version (X+1), reset minor and patch to 0
4. Update version in `.claude-plugin/plugin.json`
5. Update Version History in README.md (add new entry at top with new version, today's date, and figure out the proper changes description)
6. Show the version change (e.g., "1.1.1 -> 2.0.0")

## Version Location

Update version in `.claude-plugin/plugin.json` - `version` field

## Example

If current version is `1.1.1`, the new version will be `2.0.0`.
