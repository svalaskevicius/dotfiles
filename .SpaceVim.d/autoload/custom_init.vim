
function! custom_init#before() abort
	set rtp+=~/.SpaceVim.d/after

	let g:HardMode_level = 'wannabe'
	autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

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

	" Ensime
	function! SearchWithEnsime()
		let query = input("Ensime search: ")
		if strlen(query)
			exe "EnSearch " . query
		else
			echo "No query"
		endif
	endfun

	" autocmd FileType scala,java
				" \ nnoremap <buffer> <silent> <LocalLeader>t :EnType<CR> |
        " \ xnoremap <buffer> <silent> <LocalLeader>t :EnType selection<CR> |
        " \ nnoremap <buffer> <silent> <LocalLeader>T :EnTypeCheck<CR>|
				" \
				" \ nnoremap <buffer> <silent> K  :EnDocBrowse<CR>|
				" \ nnoremap <buffer> <silent> <LocalLeader>/  :call SearchWithEnsime()<CR>|
				" \ nnoremap <buffer> <silent> gd :EnDeclaration<CR>|
				" \
				" \ nnoremap <buffer> <silent> <C-]>  :EnDeclaration<CR>|
				" \ nnoremap <buffer> <silent> <C-w>] :EnDeclarationSplit<CR>|
				" \ nnoremap <buffer> <silent> <C-w><C-]> :EnDeclarationSplit<CR>|
				" \ nnoremap <buffer> <silent> <C-v>] :EnDeclarationSplit v<CR>|
				" \
				" \ nnoremap <buffer> <silent> <LocalLeader>i :EnInspectType<CR>|
				" \ nnoremap <buffer> <silent> <LocalLeader>I :EnSuggestImport<CR>|
				" \ nnoremap <buffer> <silent> <LocalLeader>r :EnRename<CR>



	autocmd BufWritePost * if &diff == 1 | diffupdate | endif

	set noruler
	" augroup EnsimeAutoTypeCheck
		" autocmd FileType scala
					" \ autocmd! EnsimeAutoTypeCheck BufWritePost <buffer> EnTypeCheck
	" augroup END


	" "zoom"; exit zoom via closing tab, e.g. <c-w>q
	nnoremap <A-z> :-tab sp<CR>
	nnoremap Ω :-tab sp<CR>


	function! SbtCompile()
		let _wid = win_getid()
		50vsp
		te sbt ~compile
		normal G
		call win_gotoid(_wid)
	endfun

	command! SbtCompile call SbtCompile()
	command! ShowMapping redir @" | silent map | redir END | new | put!

	au TermOpen * setlocal nonumber norelativenumber

	let g:rainbow_active = 1

	let g:ycm_server_keep_logfiles = 1
  " let g:ycm_server_log_level = 'debug'

  " let g:deoplete#omni#input_patterns.scala = ['[^.]\.\w*', '= *\w*', '\(\s*\w*', '\{\s*\w*', '=>\s*\w*']


  set hidden

  let g:LanguageClient_serverCommands = {
      \ 'scala': ['bash', '-c', 'coursier launch -r bintray:scalameta/maven org.scalameta:metals_2.12:0.1.0-M1+267-28b92d0a -M scala.meta.metals.Main'],
      \ }


  autocmd FileType scala
        \ nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>|
        \
        \ nnoremap <buffer> <silent> <LocalLeader><Tab>  :call LanguageClient#textDocument_documentSymbol()<CR>|
        \ nnoremap <buffer> <silent> <LocalLeader>q  :call LanguageClient#textDocument_references()<CR>|
        \ nnoremap <buffer> <silent> <LocalLeader>f  :call LanguageClient#textDocument_formatting()<CR>|
        \ nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>|
        \
        \ nnoremap <buffer> <silent> <LocalLeader>r :call LanguageClient#textDocument_rename()<CR>


endfun

function! custom_init#after() abort
	" call SpaceVim#layers#core#statusline#toggle_section("battery status")
	call SpaceVim#layers#core#statusline#toggle_section("time")
	let g:ctrlp_formatline_func = 's:formatline(v:val)'

endfun
