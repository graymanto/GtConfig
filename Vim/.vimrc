:let mapleader = ","
inoremap jj <Esc>
:nmap <C-tab> :bnext<cr>
:nmap <C-S-tab> :bprevious<cr>
:nnoremap <leader><leader> <C-^>
:nmap <leader>sc :SyntasticCheck<CR>
:nmap <leader>lc :lclose<CR>
:nmap <C-1> :w<cr>

:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
nmap <C-j> ]e
nmap <C-k> [e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
vmap <C-k> [egv
vmap <C-j> ]egv

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

:iabbrev waht what
:iabbrev tehn then
:autocmd FileType javascript :iabbrev <buffer> iff if ()<left>

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar
:set tabstop=4

colorscheme desert

set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files

set list                      " Show invisible characters
" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the left of the scree

set nowrap
set incsearch
set hlsearch
set ignorecase
set smartcase
set number

set autochdir

set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""" You Complete Me options """""""""""""

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

""""""""""" Unite """""""""""""""

let g:unite_source_history_yank_enable = 1

nnoremap <leader>un :Unite file_rec/async<cr>
nnoremap <space>/ :Unite grep:.<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>
nnoremap <space>y :Unite history/yank<cr>

nnoremap <leader>f :<C-u>Unite -start-insert file<CR>
nnoremap <leader>r :<C-u>Unite -start-insert file_rec<CR>

""""""""""" C++ settings """""""""""""""

autocmd FileType cpp nnoremap <C-fc> :pyf ~/bin/clang-format.py<CR>
autocmd FileType cpp imap <C-fc> <ESC>:pyf ~/bin/clang-format.py<CR>i
autocmd FileType cpp set shiftwidth=4 tabstop=4

""""""""""" Arduino settings """""""""""""""

au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

autocmd FileType arduino set shiftwidth=2 tabstop=2 cindent

""""""""""" Go settings """""""""""""""

" let $GOPATH="/Users/graymant/Documents/Development/go"
" let $PATH.= ':/Users/graymant/Documents/Development/go/bin:/usr/local/go/bin'

""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'https://github.com/tpope/vim-unimpaired.git'
Plugin 'https://github.com/tpope/vim-surround.git'
Plugin 'https://github.com/tpope/vim-ragtag.git'
Plugin 'https://github.com/tpope/vim-sensible.git'
Plugin 'https://github.com/tpope/vim-repeat.git'
Plugin 'https://github.com/tpope/vim-dispatch.git'

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'https://github.com/kien/ctrlp.vim.git'
Plugin 'https://github.com/ddollar/nerdcommenter.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/jeetsukumaran/vim-buffergator.git'
Plugin 'https://github.com/scrooloose/syntastic.git'
Plugin 'https://github.com/ervandew/supertab.git'
Plugin 'https://github.com/terryma/vim-multiple-cursors.git'
Plugin 'https://github.com/majutsushi/tagbar.git'
Plugin 'https://github.com/Valloric/YouCompleteMe.git'
Plugin 'https://github.com/Lokaltog/vim-easymotion.git'
Plugin 'https://github.com/Shougo/unite.vim.git'
Plugin 'https://github.com/bling/vim-airline.git'
Plugin 'https://github.com/Shougo/vimproc.vim.git'
Plugin 'https://github.com/jplaut/vim-arduino-ino.git'
Plugin 'https://github.com/Twinside/vim-cuteErrorMarker.git'
Plugin 'https://github.com/bronson/vim-trailing-whitespace.git'

" Snippets
Plugin 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
Plugin 'https://github.com/tomtom/tlib_vim.git'
Plugin 'https://github.com/garbas/vim-snipmate.git'

  " Optional:
Plugin 'https://github.com/honza/vim-snippets.git'


Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

Plugin 'https://github.com/suan/vim-instant-markdown.git'

Plugin 'https://github.com/jiangmiao/auto-pairs.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
