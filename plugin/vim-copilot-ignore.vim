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
    let filefolder = fnamemodify(a:filepath, ':p:h')
    let local = filefolder ==# $HOME ? v:false : v:true
    let l:lines = readfile(a:filepath)
    for l:line in l:lines
      call add(l:patterns,
            \ (local ? filefolder..(!exists("+shellslash") || &shellslash ? '/' : '\') : '')..trim(l:line))
    endfor
  endif
  return l:patterns
endfunction

" Function to check if a file matches any simple wildcard pattern
function! s:MatchesAnyPattern(filename, patterns) abort
  for l:pattern in a:patterns
    let l:regex = glob2regpat(l:pattern)
    if a:filename =~# l:regex
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
  autocmd BufNew,BufRead * call s:CheckAndDisableCopilot()
augroup END
