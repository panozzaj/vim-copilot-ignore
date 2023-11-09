# vim-copilot-ignore

A Vim plugin to automatically disable Copilot in buffers matching patterns specified in `.copilotignore` or `~/.copilotignore`.

One good use case is sensitive files. For example, if you have API keys in a local `.env` (dotenv) file, it would
would be more secure to avoid sending the contents of that file to a server.

## Installation

Use your favorite plugin manager.

For example, using [vim-plug](https://github.com/junegunn/vim-plug):

```vimscript
Plug 'panozzaj/vim-copilot-ignore.vim'
```

## Usage

Create a `.copilotignore` file in your project directory or a global `~/.copilotignore` file. Add patterns to ignore, one per line:

```
.env
backup/*
```

## References

See https://github.com/orgs/community/discussions/10305 for more general discussion of ignoring files in Copilot.
