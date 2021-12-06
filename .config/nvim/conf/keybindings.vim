" =============================== "
" ===== Keyboard Mappings ======= "

" Use "," as the <Leader> key
let g:mapleader="\<Space>"
let g:maplocalleader=","

nnoremap <S-Up> <C-B>
nnoremap <S-Down> <C-F>
nnoremap <C-Up> <C-U>
nnoremap <C-Down> <C-D>
inoremap <S-Up> <ESC><C-B>a
inoremap <S-Down> <ESC><C-F>a
inoremap <C-Up> <ESC><C-U>a
inoremap <C-Down> <ESC><C-D>a

" " Toggle NERDTree file browser
" nnoremap <Leader>tt :NERDTreeToggle <CR>
"
" " Open current file in NERDTree
" nnoremap <Leader>tf :NERDTreeFind <CR>

" Tagbar shows list of all methods and variables in class
" nnoremap <Leader>t :TagbarOpenAutoClose <CR>

function! OpenInMain(command_str)
  if (expand('%') =~# 'NvimTree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

" Fuzzy search open buffers
" nnoremap <silent> <C-b> :call OpenInMain(':CtrlPBuffer')<cr>
" Fuzzy search tags
" nnoremap <C-T> :CtrlPTag <CR>
" Fuzzy search all project filenames
" nnoremap <silent> <C-f> :call OpenInMain(':FZF')<cr>

nnoremap <silent> <C-p> <cmd>lua require('telescope.builtin').resume()<cr>
nnoremap <silent> <C-f> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <silent> <C-M-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <silent> <C-b> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>ph <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>pf <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader>pr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>psd <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>psw <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
nnoremap <leader>psq <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>
nnoremap <leader>pca <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>pdd <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>
nnoremap <leader>pdw <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>
nnoremap <leader>pi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <leader>pd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <leader>pt <cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>
nnoremap <leader>pp <cmd>lua require('telescope.builtin').treesitter()<cr>
nnoremap <leader>pm <cmd>lua require('telescope').extensions.metals.commands()<cr>

" Reload the .vimrc config
nnoremap <Leader>vr :so ~/.config/nvim/init.vim<CR>

" Edit .vimrc
nnoremap <Leader>ve :tabnew ~/.config/nvim/lua/init.lua <bar> :tcd ~/.config/nvim/<CR>

command! ShowMapping redir @" | silent map | redir END | new | put!
nnoremap <Leader>vm :ShowMapping<CR>

" easier quickfix nav
nnoremap [q    :cp<CR>
nnoremap ]q    :cn<CR>
nnoremap <Leader>- :cprev<CR>
nnoremap <Leader>= :cnext<CR>

" Remap C-w C-w to C-w C-o, like in tmux
nnoremap <C-w><C-o> <C-w><C-w>
nnoremap <C-w>o <C-w><C-w>

nnoremap <silent> <CR> :noh<CR><CR>

if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

vnoremap a= :Tabularize /=<CR>
vnoremap a; :Tabularize /::<CR>
vnoremap a- :Tabularize /-><CR>


" Use `[b` and `]b` for navigate buffers
nmap <silent> [b <ESC>:bprevious<CR>
nmap <silent> ]b <ESC>:bnext<CR>



" " begin metals
"
" " Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" " Used in the tab autocompletion for coc
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()
"
" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" " Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
" " Use `[c` and `]c` to navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)
"
" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
"
" " Used to expand decorations in worksheets
" nmap <localleader>ws <Plug>(coc-metals-expand-decoration)
"
" " Use K to either doHover or show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>
"
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction
"
" " Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')
"
" " Remap for rename current word
" nmap <localleader>rn <Plug>(coc-rename)
"
" " Remap for format selected region
" xmap <localleader>f  <Plug>(coc-format-selected)
" nmap <localleader>f  <Plug>(coc-format-selected)
"
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType scala setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
"
" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <localleader>as  <Plug>(coc-codeaction-selected)
" nmap <localleader>as  <Plug>(coc-codeaction-selected)<cr>
" " Remap for do codeAction of current line
" nmap <localleader>ac  <Plug>(coc-codeaction)
" nmap <localleader>al  <Plug>(coc-codelens-action)
"
" " Fix autofix problem of current line
" nmap <localleader>qf  <Plug>(coc-fix-current)
"
" " Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')
"
" " Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
" " Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
" " Trigger for code actions
" " Make sure `"codeLens.enable": true` is set in your coc config
" " nnoremap <localleader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>
"
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <localleader>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <localeader>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <localeader>p  :<C-u>CocListResume<CR>
"
" " Notify coc.nvim that <enter> has been pressed.
" " Currently used for the formatOnType feature.
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"       \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
" " Toggle panel with Tree Views
" nnoremap <silent> <localleader>tt :<C-u>CocCommand metals.tvp<CR>
" " Toggle Tree View 'metalsBuild'
" nnoremap <silent> <localleader>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" " Toggle Tree View 'metalsCompile'
" nnoremap <silent> <localleader>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" " Reveal current current class (trait or object) in Tree View 'metalsBuild'
" nnoremap <silent> <localleader>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>
"
"
" " end metals


function! WhitespaceToggle()
  set listchars=eol:¬,tab:--,trail:~,extends:>,precedes:<
  if(&list ==1)
    set nolist
  else
    set list
  endif
endfunc

nnoremap <C-T> :call WhitespaceToggle()<cr>

" copy mouse selection automatically
" noremap <LeftRelease> "+y<LeftRelease>

" vnoremap <C-C> "+y
" nnoremap <C-V> "+p
" inoremap <C-V> <ESC>"+pa

" slow shift finger
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev WQ wq
noreabbrev Wqa wq
noreabbrev WQa wq

nnoremap <silent> <M-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <M-Up> :TmuxNavigateUp<cr>
nnoremap <silent> <M-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <M-\\> :TmuxNavigatePrevious<cr>


nnoremap <C-M-Left> <C-O>
nnoremap <C-M-Right> <C-I>
inoremap <C-M-Left> <ESC><C-O>a
inoremap <C-M-Right> <ESC><C-I>a

nmap <leader>1 <Cmd>BufferLineGoToBuffer 1<cr>
nmap <leader>2 <Cmd>BufferLineGoToBuffer 2<cr>
nmap <leader>3 <Cmd>BufferLineGoToBuffer 3<cr>
nmap <leader>4 <Cmd>BufferLineGoToBuffer 4<cr>
nmap <leader>5 <Cmd>BufferLineGoToBuffer 5<cr>
nmap <leader>6 <Cmd>BufferLineGoToBuffer 6<cr>
nmap <leader>7 <Cmd>BufferLineGoToBuffer 7<cr>
nmap <leader>8 <Cmd>BufferLineGoToBuffer 8<cr>
nmap <leader>9 <Cmd>BufferLineGoToBuffer 9<cr>
nmap <leader>0 <Cmd>BufferLineGoToBuffer 10<cr>

noremap <ESC>[1;6A <C-S-Up>
noremap! <ESC>[1;6A <C-S-Up>
noremap <ESC>[1;6B <C-S-Down>
noremap! <ESC>[1;6B <C-S-Down>
noremap <ESC>[1;6C <C-S-Right>
noremap! <ESC>[1;6C <C-S-Right>
noremap <ESC>[1;6D <C-S-Left>
noremap! <ESC>[1;6D <C-S-Left>

nnoremap <silent><C-Right> :BufferLineCycleNext<CR>
nnoremap <silent><C-Left> :BufferLineCyclePrev<CR>
nnoremap <silent><C-S-Right> :BufferLineMoveNext<CR>
nnoremap <silent><C-S-Left> :BufferLineMovePrev<CR>
" nnoremap <silent><C-M-Right> :tabnext<CR>
" nnoremap <silent><C-M-Left> :tabprevious<CR>



nnoremap <M-f> <ESC>:Rg<SPACE>''<left>

function! CloseOtherBuffers()

  let curr = bufnr("%")
  let to_close = join(map(filter(filter(getbufinfo(), 'v:val.bufnr != ' . curr), 'v:val.name !~ "NvimTree"'), 'v:val.bufnr'))

  silent! execute "bd ".to_close
endfun

nnoremap <silent> <leader>bd :bp\|bd #<CR>
nnoremap <silent> <leader>bD :bp\|bd! #<CR>
nnoremap <silent> <leader>bo :call CloseOtherBuffers()<CR>


let g:NERDCreateDefaultMappings = 0
nmap <silent> <C-_> <Plug>NERDCommenterToggle
vmap <silent> <C-_> <Plug>NERDCommenterToggle gv
imap <silent> <C-_> <Esc><C-_>a

" let g:leaderGuide_display_plus_menus = 1
" let g:leaderGuide_run_map_on_popup = 1
" nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
" vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
" nnoremap <silent> g :<c-u>LeaderGuide 'g'<CR>

nnoremap <leader>. :lcd %:p:h<cr>

nnoremap <silent> gq gq
nnoremap <silent> gw gw
nnoremap <silent> gg 1G
nnoremap <silent> g; g;
nnoremap <silent> g, g,

" let g:leaderGuide_display_plus_menus = 1
" let g:leaderGuide_run_map_on_popup = 1
" nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
" vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
" nnoremap <silent> g :<c-u>LeaderGuide 'g'<CR>

nnoremap <leader>. :lcd %:p:h<cr>

nnoremap <silent> gg 1G
nnoremap <silent> g; g;
nnoremap <silent> g, g,

" let g:which_key_map =  {}
" let g:which_key_map.1 = 'which_key_ignore'
" let g:which_key_map.2 = 'which_key_ignore'
" let g:which_key_map.3 = 'which_key_ignore'
" let g:which_key_map.4 = 'which_key_ignore'
" let g:which_key_map.5 = 'which_key_ignore'
" let g:which_key_map.6 = 'which_key_ignore'
" let g:which_key_map.7 = 'which_key_ignore'
" let g:which_key_map.8 = 'which_key_ignore'
" let g:which_key_map.9 = 'which_key_ignore'
" call which_key#register('<Space>', "g:which_key_map")
" noremap <silent> <leader> :WhichKey '<Space>'<CR>
" vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
" nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
" vnoremap <silent> <localleader> :<c-u>WhichKeyVisual  ','<CR>
" nnoremap <silent> g :<c-u>WhichKey  'g'<CR>
" nnoremap <silent> [ :<c-u>WhichKey  '['<CR>
" nnoremap <silent> ] :<c-u>WhichKey  ']'<CR>
"
