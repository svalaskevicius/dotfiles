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
" func! s:gruvbit_setup() abort
"     hi Comment gui=italic cterm=italic
"     hi Statement gui=bold cterm=bold
" endfunc
"
" augroup colorscheme_change | au!
"     au ColorScheme gruvbit call s:gruvbit_setup()
" augroup END

set termguicolors
" colorscheme afterglow " gruvbit " onedark " tender

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" let g:airline_theme = 'tendersar'

" let g:deus_termcolors=256
" let &t_ZH="\e[3m"
" let &t_ZR="\e[23m"
set t_ZH=[3m
set t_ZR=[23m
" highlight CocHighlightText ctermfg=green ctermbg=black guifg=#c0f070 guibg=#253520
" highlight cocErrorSign guifg=#ff2010 guibg=#101010
" highlight Pmenu guibg=#101010
"
" if has('nvim')
"   " call sonokai#highlight('Substitute', s:palette.bg0, s:palette.yellow)
"   highlight! link VirtualTextError ErrorMsg
"   highlight! link VirtualTextWarning WarningMsg
"   highlight! link VirtualTextInfo Comment
"   highlight! link VirtualTextHint Comment
"
"   highlight! link ErrorFloat ErrorMsg
"   highlight! link WarningFloat WarningMsg
"   highlight! link InfoFloat Comment
"   highlight! link HintFloat Comment
"
"   highlight! link ErrorText ErrorMsg
"   highlight! link WarningText WarningMsg
"   highlight! link InfoText Comment
"   highlight! link HintText Comment
"
"   highlight! link LspDiagnosticsFloatingError ErrorFloat
"   highlight! link LspDiagnosticsFloatingWarning WarningFloat
"   highlight! link LspDiagnosticsFloatingInformation InfoFloat
"   highlight! link LspDiagnosticsFloatingHint HintFloat
"   highlight! link LspDiagnosticsDefaultError ErrorText
"   highlight! link LspDiagnosticsDefaultWarning WarningText
"   highlight! link LspDiagnosticsDefaultInformation InfoText
"   highlight! link LspDiagnosticsDefaultHint HintText
"   highlight! link LspDiagnosticsVirtualTextError VirtualTextError
"   highlight! link LspDiagnosticsVirtualTextWarning VirtualTextWarning
"   highlight! link LspDiagnosticsVirtualTextInformation VirtualTextInfo
"   highlight! link LspDiagnosticsVirtualTextHint VirtualTextHint
"   highlight! link LspDiagnosticsUnderlineError ErrorText
"   highlight! link LspDiagnosticsUnderlineWarning WarningText
"   highlight! link LspDiagnosticsUnderlineInformation InfoText
"   highlight! link LspDiagnosticsUnderlineHint HintText
"   highlight! link LspDiagnosticsSignError RedSign
"   highlight! link LspDiagnosticsSignWarning YellowSign
"   highlight! link LspDiagnosticsSignInformation BlueSign
"   highlight! link LspDiagnosticsSignHint GreenSign
"   highlight! link LspReferenceText CurrentWord
"   highlight! link LspReferenceRead CurrentWord
"   highlight! link LspReferenceWrite CurrentWord
"   highlight! link TermCursor Cursor
"   highlight! link healthError Red
"   highlight! link healthSuccess Green
"   highlight! link healthWarning Yellow
" endif


" highlight CocFloating guifg=#444444 guibg=#171717
" hi Pmenu guibg=#202020
" hi PmenuSel guibg=#333333
" hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#202020 gui=NONE
" hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#333333 gui=NONE


" color nortia-nvim
" " https://github.com/alaric/nortia.nvim
" :lua require('nortia.theme').set_contrast_threshold(3.5)
"
"
" highlight WordUnderCursor gui=underline guibg=#333a39

" colorscheme onedark
" hi Normal guibg=#141717
" hi NormalFloat guibg=#0b1212
" hi WordUnderCursor guibg=#1f302a
" hi NvimTreeIndentMarker guifg=#242a2a
" hi CursorLine guibg=#222a2a


colorscheme deus
" hi Normal guibg=#233138
" hi NormalFloat guibg=#0b1212
" hi WordUnderCursor guibg=#1f1f2a
hi NvimTreeIndentMarker guifg=#435C41
hi NvimTreeRootFolder gui=bold guifg=#aacccc
" hi CursorLine guibg=#132228

lua require('init')

 " hi lualine_c_normal guibg=#505050

