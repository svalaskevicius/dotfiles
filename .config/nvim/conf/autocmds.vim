" function! s:CloseIfOnlyNerdTreeLeft()
"   if exists("t:NERDTreeBufName")
"     if bufwinnr(t:NERDTreeBufName) != -1
"       if winnr("$") == 1
"         q
"       endif
"     endif
"   endif
" endfunction

function! TrimWhitespace()
  let l:save_cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:save_cursor)
endfun

augroup defaultgroup
  autocmd!

  " autocmd VimEnter * NERDTree

  " Highlight symbol under cursor on CursorHold
  " autocmd CursorHold * silent call CocActionAsync('highlight')

  " autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

  autocmd FileType c,cpp,java,php,scala,haskell,ts,css autocmd BufWritePre * :call TrimWhitespace() " Trim whitespace on every save

  au BufRead,BufNewFile *.sbt set filetype=scala
  " Settings for rst / markdown
  autocmd FileType rst setlocal textwidth=78
  autocmd Filetype markdown setlocal textwidth=78
"  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	autocmd BufWritePost * if &diff == 1 | diffupdate | endif

  if has("nvim")
    au TermOpen * setlocal nonumber norelativenumber
    au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
    au FileType fzf tunmap <buffer> <Esc>
    "au FileType fzf tnoremap <buffer> <Esc> <Esc>:q!<cr>
    "au FileType fzf noremap <buffer> <Esc> <Esc>:q!<cr>
  endif

  " autocmd FileType which_key set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler


  " autocmd VimLeavePre * :call coc#rpc#kill()
  " autocmd VimLeave * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -'.g:coc_process_pid) | endif
augroup END

