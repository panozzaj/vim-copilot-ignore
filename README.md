# copilotignore.vim

A Vim plugin to automatically disable Copilot in buffers matching patterns specified in `.copilotignore` or `~/.copilotignore`.

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
