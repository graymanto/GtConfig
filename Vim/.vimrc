:let mapleader = ","
inoremap jj <Esc>
:nmap <C-tab> :bnext<cr>
:nmap <C-S-tab> :bprevious<cr>
:nnoremap <leader><leader> <C-^>
:nmap <leader>sc :SyntasticCheck<CR>
:nmap <leader>lc :lclose<CR>

:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

colorscheme desert

set incsearch
set hlsearch
set ignorecase
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

""""""""""" C++ settings """""""""""""""

map <C-I> :pyf ~/bin/clang-format.py<CR>
imap <C-I> <ESC>:pyf ~/bin/clang-format.py<CR>

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
