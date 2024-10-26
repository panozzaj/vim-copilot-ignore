" copilotignore.vim - Disable Copilot for ignored files
"
" Maintainer:   Anthony Panozzo
" Version:      1.0
" License:      MIT

if exists('g:loaded_copilotignore')
  finish
endif
let g:loaded_copilotignore = 1

let s:slash = !exists("+shellslash") || &shellslash ? '/' : '\'

function! s:FindCopilotIgnore(dir) abort
    let current_dir = a:dir
    while !(current_dir ==# $HOME || current_dir ==# '/' || current_dir =~# '^[A-Za-z]:\\?$' || current_dir ==# '\\')
        if filereadable(current_dir..s:slash..'.copilotignore')
            return current_dir..s:slash..'.copilotignore'
        endif
        let current_dir = fnamemodify(current_dir, ':h')
    endwhile
    return ''
endfunction

" Function to read ignore patterns from a file
function! s:ReadIgnorePatterns(filepath) abort
  if !filereadable(a:filepath) | return [] | endif
  let filefolder = fnamemodify(a:filepath, ':p:h')
  let local = filefolder ==# $HOME ? v:false : v:true
  let lines = readfile(a:filepath)
  let patterns = []
  for line in lines
    call add(patterns, (local ? filefolder..s:slash : '')..trim(line))
  endfor
  return patterns
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
  let l:localPatterns = s:ReadIgnorePatterns(s:FindCopilotIgnore(expand('%:p:h')))
  let l:globalPatterns = s:ReadIgnorePatterns($HOME..s:slash..'.copilotignore')
  let l:bufferName = expand('%:p')

  if s:MatchesAnyPattern(l:bufferName, l:localPatterns + l:globalPatterns)
    let b:copilot_enabled = v:false
  endif
endfunction

" Automatically run the function when entering a buffer
augroup copilotignore
  autocmd!
  autocmd BufNew,BufRead * call s:CheckAndDisableCopilot()
augroup END
