
function! custom_init#before() abort
	set rtp+=~/.SpaceVim.d/after

  let mapleader="\\"
  let g:indentLine_enabled = 0

	" let g:HardMode_level = 'wannabe'
	" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

	" easier split navigations
	nnoremap <C-J> <C-W><C-J>
	nnoremap <C-K> <C-W><C-K>
	nnoremap <C-L> <C-W><C-L>
	nnoremap <C-H> <C-W><C-H>

  " easier quickfix nav
  nnoremap [q    :cp<CR>
  nnoremap ]q    :cn<CR>


	" Function for whitespace toggle
	function! WhitespaceToggle()
		set listchars=eol:¬,tab:--,trail:~,extends:>,precedes:<
		if(&list ==1)
			set nolist
		else
			set list
		endif
	endfunc

	nnoremap <C-T> :call WhitespaceToggle()<cr>

	function! TrimWhitespace()
		let l:save_cursor = getpos('.')
		%s/\s\+$//e
		call setpos('.', l:save_cursor)
	endfun

	command! TrimWhitespace call TrimWhitespace() " Trim whitespace with command
	autocmd BufWritePre * :call TrimWhitespace() " Trim whitespace on every save


	set splitbelow
	set splitright


	autocmd BufWritePost * if &diff == 1 | diffupdate | endif

	set noruler


	" "zoom"; exit zoom via closing tab, e.g. <c-w>q
	nnoremap <A-z> :-tab sp<CR>
	nnoremap Ω :-tab sp<CR>


	command! ShowMapping redir @" | silent map | redir END | new | put!

	au TermOpen * setlocal nonumber norelativenumber

	let g:rainbow_active = 1


  set hidden


  " FROM SCALA METALS:

  au FileType scala let b:coc_root_patterns = ['build.sbt']


  " Smaller updatetime for CursorHold & CursorHoldI
  set updatetime=300

  " don't give |ins-completion-menu| messages.
  set shortmess+=c

  " always show signcolumns
  set signcolumn=yes

  " Some server have issues with backup files, see #649
  set nobackup
  set nowritebackup

  " Better display for messages
  set cmdheight=2


  "
  " END FROM SCALA METALS
  "

  au BufRead,BufNewFile *.sbt set filetype=scala

  if has("nvim")
    au TermOpen * tnoremap <Esc> <c-\><c-n>
    au FileType fzf tunmap <Esc>
  endif

  " copy mouse selection automatically
  :noremap <LeftRelease> "+y<LeftRelease>

endfun

function! custom_init#after() abort
	" call SpaceVim#layers#core#statusline#toggle_section("battery status")
	call SpaceVim#layers#core#statusline#toggle_section("time")
	let g:ctrlp_formatline_func = 's:formatline(v:val)'

  " slow shift finger
  cnoreabbrev W w
  cnoreabbrev Wq wq

  " set mouse=

  " colorscheme PaperColor
  " set background=dark
  " colorscheme alduin

  " METALS
  " Use <c-space> for trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[c` and `]c` for navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gcd <Plug>(coc-definition)
  nmap <silent> gcy <Plug>(coc-type-definition)
  nmap <silent> gci <Plug>(coc-implementation)
  nmap <silent> gcr <Plug>(coc-references)

  " Remap for do action format
  nnoremap <silent> F :call CocAction('format')<CR>

  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " Remap for rename current word
  nmap <leader>cr <Plug>(coc-rename)

  " Remap for do codeAction of current line
  nmap <leader>cc <Plug>(coc-codeaction)
  " Show all diagnostics
  nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>
  " Find symbol of current document
  nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>

	call coc#config('coc.preferences', {
		\ 'timeout': 7000,
		\})
	call coc#config('languageserver', {
		\ 'metals': {
		\   "command": "metals-vim",
		\   "rootPatterns": ["build.sbt"],
		\   "filetypes": ["scala", "sbt""]
		\ }
		\})


endfun
