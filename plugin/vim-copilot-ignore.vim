" copilotignore.vim - Disable Copilot for ignored files
"
" Maintainer:   Anthony Panozzo
" Version:      1.0
" License:      MIT

if exists('g:loaded_copilotignore')
  finish
endif
let g:loaded_copilotignore = 1

" Function to read ignore patterns from a file
function! s:ReadIgnorePatterns(filepath) abort
  let l:patterns = []
  if filereadable(a:filepath)
    let l:lines = readfile(a:filepath)
    for l:line in l:lines
      call add(l:patterns, substitute(l:line, '^\s*\(.\{-}\)\s*$', '\1', ''))
    endfor
  endif
  return l:patterns
endfunction

" Function to convert a simple wildcard pattern to a Vim-compatible regex
function! s:ConvertWildcardToRegex(pattern) abort
  let l:regex = substitute(a:pattern, '\*', '.*', 'g')
  let l:regex = substitute(l:regex, '?', '.', 'g')
  return l:regex
endfunction

" Function to check if a file matches any simple wildcard pattern
function! s:MatchesAnyPattern(filename, patterns) abort
  let l:only_filename = fnamemodify(a:filename, ':t')

  for l:pattern in a:patterns
    let l:regex = s:ConvertWildcardToRegex(l:pattern)
    if l:only_filename =~ l:regex
      return 1
    endif
  endfor
  return 0
endfunction

" Main function to check and disable Copilot for the current buffer
function! s:CheckAndDisableCopilot() abort
  let l:localPatterns = s:ReadIgnorePatterns('.copilotignore')
  let l:globalPatterns = s:ReadIgnorePatterns(expand('~/.copilotignore'))
  let l:allPatterns = l:localPatterns + l:globalPatterns
  let l:bufferName = expand('%:p')

  if s:MatchesAnyPattern(l:bufferName, l:allPatterns)
    let b:copilot_enabled = v:false
  endif
endfunction

" Automatically run the function when entering a buffer
augroup copilotignore
  autocmd!
  autocmd BufEnter * call s:CheckAndDisableCopilot()
augroup END
