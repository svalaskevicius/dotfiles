set shell=/usr/bin/env\ bash
set nocompatible               " be iMproved

" enable 256 colors
" set t_Co=256

" Required for operations modifying multiple buffers like rename.
set hidden

" Default Indentation Settings
set autoindent
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab

" Automatically write file for some commands, like cfile
set autowrite

" show lines numbers
set relativenumber
set number

" enable real-time searching
set incsearch

" highlight search matches
set hlsearch

set completeopt=menuone,menu,longest

set history=1000
set nospell
set pastetoggle=<F12>

" status lines -- note this is not used when airline is enabled
if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\ " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=%#warningmsg#
    "set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    set statusline+=\ [%{&ff}/%Y] " filetype
    set statusline+=\ [%{getcwd()}] " current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif

" Ignore files
set wildignore+=*/.git/*,*.cache,*.swp,*.swo,**/cache/**,*.min.js

" Only get tags from CWD
set tags=tags;

let g:deoplete#enable_at_startup = 1

 " Configuration for coc.nvim
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=200

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

set mouse=a
" End of Configuration suggested for coc.nvim

" set cmdheight=2

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#coc#enabled = 1


let g:rainbow_active = 1

let g:ackprg = 'ag --vimgrep --smart-case'



" Lowering this improves performance in files with long lines
set synmaxcol=500

let g:markdown_fenced_languages = ['html', 'vim', 'ruby', 'python', 'bash=sh', 'rust', 'haskell', 'c', 'cpp', 'scala', 'java']

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#excludes = []
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

" NerdTree
let g:NERDTreeCascadeOpenSingleChildDir=1
let g:NERDTreeCascadeSingleChildDir=1
let g:NERDTreeQuitOnOpen = 0

" NerdCommenter
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDSpaceDelims = 1



" CtrlP
let g:ctrlp_follow_symlinks = 0
let g:ctrlp_max_files = 20000
let g:ctrlp_max_depth = 80
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = ''
let g:ctrlp_map = ''


let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_disable_when_zoomed = 0

set timeoutlen=300
let g:which_key_flatten = 1
let g:which_key_position = 'botleft'
let g:which_key_align_by_seperator = 1
let g:which_key_use_floating_win = 1
let g:which_key_display_names = { ' ': 'SPC', '<SPACE>': 'SPC', '<C-H>': 'BS', '<C-I>': 'TAB', '<TAB>': 'TAB', }
let g:which_key_floating_opts =  { 'row': '+2', 'col': '-3', 'width': '+3' }



