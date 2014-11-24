:let mapleader = ","
inoremap jj <Esc>
:imap <C-j> <Right><Plug>snipMateNextOrTrigger
:nmap <C-tab> :bnext<cr>
:nmap <C-S-tab> :bprevious<cr>
:nmap <leader>sc :SyntasticCheck<CR>
:nmap <leader>lc :lclose<CR>
:nmap <leader>noh :noh<CR>
:nmap <C-1> :w<cr>
:nnoremap <leader>qq :q<CR>
:nnoremap <leader>qa :qa<CR>
:nnoremap <leader>ww :w<CR>
:nnoremap <leader>ee :Bclose<CR>
:nnoremap <leader>nt :NERDTreeToggle<CR>

:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

:nnoremap <leader>cpps :vsplit ~/.vim/bundle/vim-snippets/snippets/cpp.snippets<cr>
:nnoremap <leader>cards :vsplit ~/.vim/bundle/vim-snippets/snippets/arduino.snippets<cr>

""""""""""" Resize  mode """""""""""""""

if has("gui_macvim")
		set fuoptions=maxvert,maxhorz
		set noballooneval

		" resize current buffer by +/- 5
		nnoremap <M-Right> :vertical resize +5<CR>
		nnoremap <M-Left>  :vertical resize -5<CR>
		nnoremap <M-Up>    :resize -5<CR>
		nnoremap <M-Down>  :resize +5<CR>

		" Automatically resize splits
		" when resizing MacVim window
		autocmd VimResized * wincmd =
else
		nnoremap <M-Right> :vertical resize +5<CR>
		nnoremap <M-Left>  :vertical resize -5<CR>
		nnoremap <M-Up>    :resize -5<CR>
		nnoremap <M-Down>  :resize +5<CR>
endif

""""""""""""""""""""""""""""""""""""""""

silent! :unmap <leader>b
:noremap <leader>bw :bw<CR>
:noremap <leader>bc :BClose<CR>

:vnoremap . :norm.<CR>

" upper/lower word
nmap <leader>uc mQviwU`Q
nmap <leader>lc mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<cr>:set wrap?<cr>

" Bubble multiple lines
vmap <C-k> [egv
vmap <C-j> ]egv

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

""""""""""" Commands """"""""""""""

" Some just for shell command examples. Can be done better if that was the
" idea
command! -range StripLastChar <line1>,<line2>!rev | cut -c 2- | rev
command! -range -nargs=1 StripLastChars <line1>,<line2>!rev | cut -c <f-args>- | rev
command! -range -nargs=1 StripFirstChars <line1>,<line2>!cut -c <f-args>-
command! -range TrimFront <line1>,<line2>!sed 's/^[ 	]*//g'

"""""""""""""""""""""""""""""""""""

" System clipboard
"vmap <Leader>y "+y
" vmap <Leader>d "+d
" nmap <Leader>p "+p
" nmap <Leader>P "+P
" vmap <Leader>p "+p
" vmap <Leader>P "+P

:iabbrev waht what
:iabbrev tehn then


:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar
:set tabstop=4

colorscheme desert

set dir-=.
" set backupdir-=.
" set directory-=.

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

" set autochdir
set autowriteall

set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""" Tag settings """""""""""""
set csprg=gtags-cscope
" cscope add /foo/bar/GTAGS

"""""""""""" Vimdiff settings """""""""""""

noremap <leader>dgl :diffget LO<CR>
noremap <leader>dgb :diffget BA<CR>
noremap <leader>dgr :diffget RE<CR>

"""""""""""" Grep settings """""""""""""

set grepprg=ack\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

"""""""""""" You Complete Me options """""""""""""

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_collect_identifiers_from_tags_files = 1

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

:nnoremap <leader>gto :YcmCompleter GoTo<CR>
:nnoremap <leader>gti :YcmCompleter GoToImprecise<CR>
:nnoremap <F12> :YcmCompleter GoToImprecise<CR>

""""""""""" Unite """""""""""""""
let g:unite_source_history_yank_enable = 1

nnoremap <space>u :Unite -start-insert file_rec/async<cr>
nnoremap <leader>uunc :Unite -quick-match change<cr>
nnoremap <space>c :Unite -quick-match change<cr>
nnoremap <leader>u/ :Unite grep:.<cr>
nnoremap <leader>bb :Unite -quick-match buffer<cr>
nnoremap <space>y :Unite -quick-match history/yank<cr>
nnoremap <space>f :Unite -start-insert buffer<cr>

nnoremap <leader>gg :execute 'Unite gtags/def'<CR>
nnoremap <leader>gc :execute 'Unite gtags/context'<CR>
nnoremap <leader>gr :execute 'Unite gtags/ref'<CR>
nnoremap <leader>ge :execute 'Unite gtags/grep'<CR>
vnoremap <leader>gg <ESC>:execute 'Unite gtags/def:'.GetVisualSelection()<CR>

nnoremap <leader>uo :Unite outline<CR>

" Can filter if required ie :Unite -input=foo file

nnoremap <leader>of :<C-u>Unite -start-insert file/async<CR>

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

""""""""""" Easy motion """""""""""""""

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap <space>s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

map  <space>/ <Plug>(easymotion-sn)
omap <space>/ <Plug>(easymotion-tn)
nmap <space>w <Plug>(easymotion-w)
nmap <space>b <Plug>(easymotion-b)

" JK motions: Line motions
map <space>j <Plug>(easymotion-j)
map <space>k <Plug>(easymotion-k)
map <space>l <Plug>(easymotion-lineforward)
map <space>h <Plug>(easymotion-linebackward)

""""""""""" Region Expanding """""""""""""""

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

""""""""""" Haskell settings """""""""""""""

let g:ycm_semantic_triggers = {'haskell' : ['.']}

augroup hskag
	autocmd!
	:autocmd FileType haskell set omnifunc=necoghc#omnifunc
augroup END

""""""""""" Javascript settings """""""""""""""

augroup javascriptag
	autocmd!
	:autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
augroup END

""""""""""" C++ settings """""""""""""""

augroup cppac
	autocmd!
	autocmd FileType cpp nnoremap <leader>fcc :pyf ~/bin/clang-format.py<CR>
	autocmd FileType cpp vnoremap <leader>fcc :pyf ~/bin/clang-format.py<CR>
	autocmd FileType cpp imap <C-cf> <ESC>:pyf ~/bin/clang-format.py<CR>i
	autocmd FileType cpp inoremap jk ->
	autocmd FileType cpp inoremap ::: <C-R>=expand("%:t:r") . "::"<CR>
	autocmd FileType cpp set shiftwidth=4 tabstop=4 expandtab
	" autocmd FileType cpp setlocal makeprg=cd\ Build\ &&\ make\ -j4
	" autocmd BufWrite *.cpp call FormatCPP()
	" autocmd BufWrite *.cpp Make
augroup END

func! FormatCPP()
    let l:winview = winsaveview()
    :exe '%!clang-format -style=file'
    call winrestview(l:winview)
endfunc

:nnoremap <leader>fcpp :call FormatCPP()<CR>
:noremap <leader>mm :make<CR>
:noremap <leader>co :Copen<CR>

""""""""""" XML settings """""""""""""""

augroup xmlag
	autocmd FileType xml set shiftwidth=4 tabstop=4 expandtab
augroup END

""""""""""" Arduino settings """""""""""""""

au BufRead,BufNewFile *.pde set filetype=cpp
au BufRead,BufNewFile *.ino set filetype=arduino

augroup arduinoac
	autocmd!
	autocmd FileType arduino setlocal shiftwidth=4 tabstop=4 cindent
	autocmd FileType arduino setlocal makeprg=cd\ ..\ &&\ ino\ build
	autocmd FileType arduino nnoremap <leader>iu :exe '!cd .. && ino upload'<CR>
augroup END

""""""""""" Markdown settings """""""""""""""

augroup markdownac
	autocmd!
	autocmd FileType mkd setlocal spell
augroup END

func! FormatMD()
    let l:winview = winsaveview()
    :exe '%!par w120'
    call winrestview(l:winview)
endfunc

:nnoremap <leader>fmd :call FormatMD()<CR>
:vnoremap <leader>pft !par w120<CR>

""""""""""" Go settings """""""""""""""

" let $GOPATH="/Users/graymant/Documents/Development/go"
" let $PATH.= ':/Users/graymant/Documents/Development/go/bin:/usr/local/go/bin'


""""""""""" CMake settings """"""""""""""""""""""

augroup cmakeac
	autocmd!
	:autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim
	:autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
	:autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake
augroup END

""""""""""" Python settings """"""""""""""""""""""

augroup pythonac
	autocmd!
	" autocmd FileType cpp set shiftwidth=4 tabstop=4 expandtab
augroup END

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
Plugin 'https://github.com/tpope/vim-rsi.git'
Plugin 'https://github.com/tpope/vim-endwise.git'

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
Plugin 'https://github.com/vim-scripts/a.vim.git'
Plugin 'https://github.com/octol/vim-cpp-enhanced-highlight'
Plugin 'othree/html5.vim'
Plugin 'https://github.com/tpope/vim-git.git'
Plugin 'https://github.com/spf13/PIV.git'
Plugin 'https://github.com/oplatek/Conque-Shell'
Plugin 'https://github.com/vim-scripts/Cppcheck-compiler.git'

Plugin 'https://github.com/terryma/vim-expand-region.git'

" Tags
Plugin 'https://github.com/vim-scripts/gtags.vim.git'
Plugin 'https://github.com/hewes/unite-gtags.git'
Plugin 'https://github.com/Shougo/unite-outline.git'


" Haskell
Plugin 'https://github.com/dag/vim2hs.git'
Plugin 'https://github.com/eagletmt/neco-ghc.git'
Plugin 'https://github.com/eagletmt/ghcmod-vim.git'
Plugin 'https://github.com/pbrisbin/vim-syntax-shakespeare.git'

" Snippets
Plugin 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
Plugin 'https://github.com/tomtom/tlib_vim.git'
Plugin 'https://github.com/garbas/vim-snipmate.git'

  " Optional:
Plugin 'https://github.com/honza/vim-snippets.git'


Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'https://github.com/OrangeT/vim-csharp.git'
Plugin 'https://github.com/vadimr/bclose.vim.git'

Plugin 'https://github.com/suan/vim-instant-markdown.git'

Plugin 'https://github.com/jiangmiao/auto-pairs.git'

Plugin 'https://github.com/mtth/scratch.vim.git'
Plugin 'https://github.com/rhysd/vim-clang-format.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

:nnoremap <leader><leader> <C-^>
