set hlsearch
set ai
set sw=4
set ts=4
set bg=dark
set bs=2
set nu
set showmode
set ruler
set linebreak
set et
syntax on
set tags+=../tags,../../tags
set t_Co=256
set cursorline
set splitright
set splitbelow
" set scroll=21

au VimEnter * if &diff | execute 'windo set nowrap' | endif

hi  Search        cterm=NONE            ctermfg=black       ctermbg=lightblue
hi  DiffAdd       cterm=BOLD            ctermfg=white       ctermbg=darkgreen
hi  DiffChange    cterm=BOLD            ctermfg=white       ctermbg=darkcyan
hi  DiffText      cterm=BOLD            ctermfg=white       ctermbg=56
hi  DiffDelete    cterm=BOLD            ctermfg=black       ctermbg=darkred
hi  Folded        cterm=NONE            ctermfg=243         ctermbg=232
hi  CursorLine    cterm=NONE            ctermfg=NONE        ctermbg=235
hi  TabLine       cterm=NONE            ctermfg=246         ctermbg=darkblue
hi  TabLineSel    cterm=BOLD,UNDERLINE  ctermfg=21          ctermbg=220
hi  TabLineFill   cterm=NONE            ctermfg=white       ctermbg=17
hi  LineNr        cterm=BOLD            ctermfg=darkgrey
hi  CursorLineNr  cterm=BOLD,UNDERLINE  ctermfg=lightgreen

autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

map  <silent> <F12>  :Tlist<CR>
map  <silent> <F5>   :let &wrap=1-&wrap<CR>:echo "wrap=" . (&wrap? "on": "off")<CR>
map  <silent> <F6>   :let &fdc=&fdc+3<CR>
map  <silent> <C-F6> :let &fdc=&fdc-3<CR>
nmap <silent> f>     :<C-U>let &fdc=&fdc + v:count1<CR>
nmap <silent> f<     :<C-U>let &fdc=&fdc - v:count1<CR>
map  <silent> <F7>   :sp tags<CR>:g/.*"\t[^cdgpfm].*/d<CR>:g/^!!_TAG_.*/d<CR>:%s/^\([a-zA-Z0-9_~]\+\).*/syntax keyword Tag \1/<CR>:wq! tags.vim<CR>:nohl<CR><F8>
map  <silent> <F8>   :so tags.vim<CR>
map  <silent> <C-F8> :let ctab=tabpagenr()<CR>tabdo so tags.vim<CR>:execute "tabn" ctab<CR>:unlet ctab<CR>

vmap <silent> ta  "fy:execute "tabnew" @f<CR>
vmap <silent> sa  "fy:execute "sp" @f<CR>
vmap <silent> va  "fy:execute "vs" @f<CR>
vmap <silent> tr  "fy:execute "tabnew" expand('%:h') . "/" . @f<CR>
vmap <silent> sr  "fy:execute "sp" expand('%:h') . "/" . @f<CR>
vmap <silent> vr  "fy:execute "vs" expand('%:h') . "/" . @f<CR>
nmap <silent> cd  :execute "cd" expand('%:p:h')<CR>:pwd<CR>

vnoremap <Leader>y "+y
noremap  <Leader>yy "+yy
noremap  <Leader>p "+p
noremap  <Leader>P "+P
noremap  <Leader>\ :nohl<CR>

let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Auto_Highlight_Tag=1
"let Tlist_Close_On_Select=1
"let TList_Winwidth=40

set foldmethod=indent
set incsearch

set nocompatible              " be iMproved, required
filetype on                   " required

" set rtp+=~/tabnine-vim

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
"
" Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'


" All of your Plugins must be added before the following line
call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"if has("autocmd")
"    autocmd BufRead *.txt set tw=78
"    autocmd BufReadPost *
"       \ if line("'\"") > 0 && line ("'\"") <= line("$") |
"       \   exe "normal g'\"" |
"       \ endif
"endif
