# vim-copilot-ignore

A Vim plugin to automatically disable Copilot in buffers matching patterns specified in a `.copilotignore` of the current work dir or a global `~/.copilotignore`.
Here `or` is meant non-exclusively, that is, the patterns of both files are checked, and the glob patterns are documented at `:help wildcards`.
The patterns of the global ignore file check for the whole file path whereas that of the local one for that relative to the folder of it.

One good use case is sensitive files. For example, if you have API keys in a local `.env` (dotenv) file, it would
would be more secure to avoid sending the contents of that file to a server.

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

## References

See https://github.com/orgs/community/discussions/10305 for more general discussion of ignoring files in Copilot.
