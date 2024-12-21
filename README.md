# vim-copilot-ignore

A Vim plugin to automatically disable Copilot in buffers matching user-specified patterns.

One good use case is disabling Copilot for sensitive files. For example, if you have API keys in a local `.env` (dotenv) file, it would
would be more secure to avoid sending the contents of that file to a server. Also, you're unlikely to get useful completions from it.

## Installation

Use your favorite plugin manager.

For example, using [vim-plug](https://github.com/junegunn/vim-plug):

```vimscript
Plug 'panozzaj/vim-copilot-ignore'
```

## Usage

Create a `.copilotignore` file in your project directory or a global `~/.copilotignore` file. Add patterns to ignore, one per line:

```
.env
backup/*
```

Glob patterns are documented at `:help wildcards`.

## Ignore file details

Each time a buffer is created or read, the plugin will check to see if Copilot should be disbled.

The plugin will obtain Copilot ignore file patterns from two sources, and use the union of the patterns:

1. global: `~/.copilotignore` file
2. subdirectory / project-specific: the first `.copilotignore` file found, starting in the directory of the buffer and traversing up

For example, if you had the following file tree:

```
/home/user/.copilotignore                (global)
/home/user/repo/.copilotignore           (local, but not first encountered)
/home/user/repo/subfolder/.copilotignore (local)
/home/user/repo/subfolder/some_file.txt  (file being edited)
```

and were editing a file in or under `/home/user/repo/subfolder/`, the plugin would use the patterns from `/home/user/.copilotignore` and `/home/user/repo/subfolder/.copilotignore`.

If a pattern matches the full path of the file, Copilot will be disabled for that file.

## References

See https://github.com/orgs/community/discussions/10305 for more general discussion of ignoring files in Copilot.
