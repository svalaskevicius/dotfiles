" =============================== "
" ======= Plugin Imports ======== "

let vimplug_exists=expand('~/.local/share/nvim/site/autoload/plug.vim')

" Required:
call plug#begin(expand('~/.local/share/nvim/plugged'))

" General fuzzy search capability
Plug 'junegunn/fzf', { 'dir': '~/.local/bin/fzf', 'do': './install --all' }

" Some surrounding characters trickery (not sure if should keep it)
Plug 'tpope/vim-surround'

" Aligning - TODO - Check if it's doing any usefull stuff
Plug 'godlygeek/tabular'

" Ctrlp - quickly find files, tags and buffers using fuzzy search
Plug 'kien/ctrlp.vim'

" Nerdtree file browser
" Plug 'preservim/nerdtree'

" Easily comment - <Leader>cc
Plug 'preservim/nerdcommenter'

" Git support
" Plug 'tpope/vim-fugitive'

" Apply a command on every file in the quickfix list :Qdo %s/Foobar/Barfoo
Plug 'henrik/vim-qargs'

" Airline status bar
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Git gutter
" Plug 'airblade/vim-gitgutter'

" Tmux focus events support - fugitive needs it
Plug 'tmux-plugins/vim-tmux-focus-events'

Plug 'christoomey/vim-tmux-navigator'

" LSP
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'ckipp01/coc-metals', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
" " Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
" Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}
Plug 'scalameta/nvim-metals'

Plug 'derekwyatt/vim-scala'

Plug 'neovimhaskell/haskell-vim'
" Plug 'alx741/vim-hindent'
Plug 'mpickering/hlint-refactor-vim'

Plug 'gruvbox-community/gruvbox'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'jacoborus/tender.vim'

Plug 'ryanoasis/vim-devicons'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'neomake/neomake'

Plug 'majutsushi/tagbar'

Plug 'chrisbra/Colorizer'

Plug 'luochen1990/rainbow'

" Plug 'YorickPeterse/happy_hacking.vim'

" Plug 'ntk148v/vim-horizon'

Plug 'mlopes/vim-farin'
Plug 'rafi/awesome-vim-colorschemes'
" Plug 'srcery-colors/srcery-vim'
Plug 'tomasiser/vim-code-dark'
Plug 'habamax/vim-gruvbit'

Plug 'mileszs/ack.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'svalaskevicius/vim-leader-guide'
" Plug 'liuchengxu/vim-which-key'
" Plug 'kana/vim-arpeggio'

Plug 'vim-scripts/CycleColor'

Plug 'will133/vim-dirdiff'

Plug 'rktjmp/lush.nvim'
Plug 'alaric/nortia.nvim'


" Initialize plugin system
call plug#end()
