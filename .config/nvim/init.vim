scriptencoding utf-8

" Automatically detect filetypes
filetype plugin indent on

let init_dir_path = expand('<sfile>:p:h').'/'
let config_path = init_dir_path . 'conf/'

exec 'source' init_dir_path.'plug.vim'
let config_list = [
      \ 'settings.vim',
      \ 'variables.vim',
      \ 'plugins.vim',
      \ 'keybindings.vim',
      \ 'autocmds.vim'
      \]
for files in config_list
  for f in glob(config_path.files, 1, 1)
    exec 'source' f
  endfor
endfor


" set syntax highlighting options.
syntax on

hi! Normal ctermbg=NONE guibg=NONE
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" Color scheme
set background=dark
color minimalist
highlight CocHighlightText ctermfg=Red guifg=#c0e050
" guibg=#302000

