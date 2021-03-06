scriptencoding utf-8

" Automatically detect filetypes
filetype plugin indent on

let init_dir_path = expand('<sfile>:p:h').'/'
let config_path = init_dir_path . 'conf/'

exec 'source' init_dir_path.'plug.vim'
let config_list = [
      \ 'settings.vim',
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
" set termguicolors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" Color scheme
set cursorline
set t_Co=256
set background=dark
" color deus " hybrid  minimalist
func! s:gruvbit_setup() abort
    hi Comment gui=italic cterm=italic
    hi Statement gui=bold cterm=bold
endfunc

augroup colorscheme_change | au!
    au ColorScheme gruvbit call s:gruvbit_setup()
augroup END

set termguicolors
colorscheme gruvbit " onedark " tender
" let g:airline_theme = 'tendersar'

" let g:deus_termcolors=256
" let &t_ZH="\e[3m"
" let &t_ZR="\e[23m"
set t_ZH=[3m
set t_ZR=[23m
highlight CocHighlightText ctermfg=green ctermbg=black guifg=#c0f070 guibg=#253520
highlight cocErrorSign guifg=#ff2010 guibg=#101010
highlight Pmenu guibg=#101010

" highlight CocFloating guifg=#444444 guibg=#171717
" hi Pmenu guibg=#202020
" hi PmenuSel guibg=#333333
" hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#202020 gui=NONE
" hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#333333 gui=NONE


