let mapleader = ","
inoremap jj <Esc>
imap <C-j> <Right><Plug>snipMateNextOrTrigger
nmap <C-tab> :bnext<cr>
nmap <C-S-tab> :bprevious<cr>
nmap <leader>sc :SyntasticCheck<CR>
nmap <leader>lc :lclose<CR>
nmap <leader>noh :noh<CR>
nmap <C-1> :w<cr>
nnoremap <leader>qq :q<CR>
nnoremap <leader>qa :qa<CR>
nnoremap <leader>ww :w<CR>
nnoremap <leader>ee :Bclose<CR>
nnoremap <leader>ra :bufdo e!<CR>

noremap <leader>mm :make<CR>
noremap <leader>co :Copen<CR>
noremap <leader>sm :messages<CR>

nnoremap <leader>zw :ZoomWin<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>cpps :vsplit ~/.vim/bundle/vim-snippets/snippets/cpp.snippets<cr>
nnoremap <leader>cards :vsplit ~/.vim/bundle/vim-snippets/snippets/arduino.snippets<cr>

""""""""""" Complimentary settings bindings """""""""""""""

nnoremap [et :set expandtab<cr>
nnoremap ]et :set noexpandtab<cr>
nnoremap [pt :set paste<cr>
nnoremap ]pt :set nopaste<cr>

""""""""""" Terminal fixes """""""""""""""
"fix meta-keys which generate <Esc>a .. <Esc>z

if !has('gui_running')
	let c='a'
	while c <= 'z'
		exec "set <M-".toupper(c).">=\e".c
		exec "imap \e".c." <M-".toupper(c).">"
		let c = nr2char(1+char2nr(c))
	endw
endif


""""""""""" Resize  mode """""""""""""""

nnoremap <M-Right> :vertical resize +5<CR>
nnoremap <M-Left>  :vertical resize -5<CR>
nnoremap <M-Up>    :resize -5<CR>
nnoremap <M-Down>  :resize +5<CR>

if has("gui_macvim")
	set fuoptions=maxvert,maxhorz
	set noballooneval

	" Automatically resize splits
	" when resizing MacVim window
	autocmd VimResized * wincmd =
else
	" For terminal
	nnoremap [1;3C     :vertical resize +5<CR>
	nnoremap [1;3D     :vertical resize -5<CR>
	nnoremap [1;3A     :resize -5<CR>
	nnoremap [1;3B     :resize +5<CR>
endif

if has("macunix")
	nnoremap <space><Right> :vertical resize +5<CR>
	nnoremap <space><Left>  :vertical resize -5<CR>
	nnoremap <space><Up>    :resize -5<CR>
	nnoremap <space><Down>  :resize +5<CR>
endif

""""""""""""""""""""""""""""""""""""""""

silent! :unmap <leader>b
noremap <leader>bw :bw<CR>
noremap <leader>bc :BClose<CR>

vnoremap . :norm.<CR>

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

set shiftwidth=4

""""""""""" Commands """"""""""""""

" Some just for shell command examples. Can be done better if that was the
" idea
command! -range StripLastChar <line1>,<line2>!rev | cut -c 2- | rev
command! -range -nargs=1 StripLastChars <line1>,<line2>!rev | cut -c <f-args>- | rev
command! -range -nargs=1 StripFirstChars <line1>,<line2>!cut -c <f-args>-
command! -range TrimFront <line1>,<line2>!sed 's/^[ 	]*//g'
command! Spacify :.s/\t/    /g
command! SpacifyAll :%!expand -t4
command! TabifyAll :%!unexpand -t4
command! -range AddNumbers :<line1>,<line2>!nl | sed 's/ *//g'

"""""""""""""""""""""""""""""""""""

" System clipboard
"vmap <Leader>y "+y
" vmap <Leader>d "+d
nmap <Leader>pp "+p
" nmap <Leader>P "+P
" vmap <Leader>p "+p
" vmap <Leader>P "+P

:iabbrev waht what
:iabbrev tehn then


set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set tabstop=4

colorscheme desert

set dir-=.
" set backupdir-=.
" set directory-=.

set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files

set list                      " Show invisible characters
func! ListCharsCommon()
	set listchars+=trail:.            " show trailing spaces as dots
	set listchars+=extends:>          " The character to show in the last column when wrap is
	" off and the line continues beyond the right of the screen
	set listchars+=precedes:<         " The character to show in the last column when wrap is
	" off and the line continues beyond the left of the scree
	"
endfunc

func! ListCharsShowTabs()
	" List chars
	set listchars=""                  " Reset the listchars
	" set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
	set listchars=tab:-.             " a tab should display as "  ", trailing whitespace as "."

	call ListCharsCommon()
endfunc
func! ListCharsHideTabs()
	" List chars
	set listchars=""                  " Reset the listchars
	set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."

	call ListCharsCommon()
endfunc
command! ShowTabs :call ListCharsShowTabs()
command! HideTabs :call ListCharsHideTabs()

HideTabs

set nowrap
set incsearch
set hlsearch
set ignorecase
set smartcase
set gdefault
set number
set showmatch

" set autochdir
set autowriteall

set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""" Tag settings """""""""""""
set csprg=gtags-cscope
" cscope add /foo/bar/GTAGS

"""""""""""" Vimdiff merge settings """""""""""""

noremap <leader>dgl :diffget LO<CR>
noremap <leader>dgb :diffget BA<CR>
noremap <leader>dgr :diffget RE<CR>

if &diff
	" diff mode only ignore whitespace in comparisons
	set diffopt+=iwhite
endif

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

nnoremap <leader>gto :YcmCompleter GoTo<CR>
nnoremap <leader>gti :YcmCompleter GoToImprecise<CR>
nnoremap <F12> :YcmCompleter GoToImprecise<CR>

""""""""""" Omnisharp """""""""""""""

let g:OmniSharp_selector_ui = 'unite'
let g:OmniSharp_server_type = 'roslyn'

augroup omnisharp_commands
	autocmd!

	au BufRead,BufNewFile *.csx set filetype=cs

	"Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
	autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

	" Synchronous build (blocks Vim)
	"autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
	" Builds can also run asynchronously with vim-dispatch installed
	autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
	" automatic syntax check on events (TextChanged requires Vim 7.4)
	autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

	" Automatically add new cs files to the nearest project on save
	autocmd BufWritePost *.cs call OmniSharp#AddToProject()

	"show type information automatically when the cursor stops moving
	autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

	"The following commands are contextual, based on the current cursor position.

	autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
	autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
	autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
	autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
	autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
	"finds members in the current buffer
	autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
	" cursor can be anywhere on the line containing an issue
	" autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
	" autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
	" autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
	" autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
	"navigate up by method/property/field
	" autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
	"navigate down by method/property/field
	" autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

	autocmd FileType cs set shiftwidth=4 tabstop=4 expandtab

augroup END


""""""""""" Tabularize """""""""""""""

vnoremap <leader>ta :Tabularize assignment<CR>

""""""""""" Tagbar """""""""""""""

nnoremap <leader>tb :TagbarToggle<CR>

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

""""""""""" Zsh settings """"""""""""""""""""""

augroup zshag
	autocmd!
	autocmd FileType zsh set shiftwidth=4 tabstop=4
augroup END

""""""""""" Vimfile settings """"""""""""""""""""""

augroup vimag
	autocmd!
	autocmd FileType vim set shiftwidth=4 tabstop=4 noexpandtab
augroup END

""""""""""" Haskell settings """""""""""""""

let g:ycm_semantic_triggers = {'haskell' : ['.']}

let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1

let g:haskell_indent_if = 0
let g:haskell_indent_case = 0
let g:haskell_indent_let = 0
let g:haskell_indent_where = 0
let g:haskell_indent_do = 0
let g:haskell_indent_in = 0

augroup hskag
	autocmd!
	:autocmd FileType haskell set omnifunc=necoghc#omnifunc
augroup END

""""""""""" Javascript settings """""""""""""""

augroup javascriptag
	autocmd!
	:autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
augroup END

""""""""""" Json formatting """""""""""""""

func! FormatJson()
	let l:winview = winsaveview()
	:exe '%!jq ''.'''
	call winrestview(l:winview)
endfunc
nnoremap <leader>fjs :call FormatJson()<CR>

""""""""""" Pony settings """""""""""""""

augroup ponglang
	autocmd!
	autocmd FileType pony set shiftwidth=2 tabstop=2 expandtab
augroup END

""""""""""" C settings """""""""""""""

func! FormatCPP()
	let l:winview = winsaveview()
	:exe '%!clang-format -style=file'
	call winrestview(l:winview)
endfunc

augroup cac
	autocmd!
	autocmd FileType c nnoremap <leader>fcc :pyf ~/bin/clang-format.py<CR>
	autocmd FileType c vnoremap <leader>fcc :pyf ~/bin/clang-format.py<CR>
	autocmd FileType c imap <C-cf> <ESC>:pyf ~/bin/clang-format.py<CR>i
	autocmd FileType c inoremap jk ->
	autocmd FileType c set shiftwidth=4 tabstop=4 expandtab
	au FileType c nnoremap <leader>fff :call FormatCPP()<CR>
augroup END

""""""""""" C++ settings """""""""""""""

augroup cppac
	autocmd!
	func! Format()
		call FormatCpp()
	endfunc
	autocmd FileType cpp nnoremap <leader>fcc :pyf ~/bin/clang-format.py<CR>
	autocmd FileType cpp vnoremap <leader>fcc :pyf ~/bin/clang-format.py<CR>
	autocmd FileType cpp imap <C-cf> <ESC>:pyf ~/bin/clang-format.py<CR>i
	autocmd FileType cpp inoremap jk ->
	autocmd FileType cpp inoremap ::: <C-R>=expand("%:t:r") . "::"<CR>
	autocmd FileType cpp set shiftwidth=4 tabstop=4 expandtab
	autocmd FileType cpp nnoremap <leader>fcpp :call FormatCPP()<CR>
	au FileType cpp nnoremap <leader>fff :call FormatCPP()<CR>
	" autocmd FileType cpp setlocal makeprg=cd\ Build\ &&\ make\ -j4
	" autocmd BufWrite *.cpp call FormatCPP()
	" autocmd BufWrite *.cpp Make
augroup END

""""""""""" XML settings """""""""""""""

augroup xmlag
	autocmd FileType xml set shiftwidth=4 tabstop=4 expandtab
augroup END

""""""""""" Arduino settings """""""""""""""

au BufRead,BufNewFile *.pde set filetype=cpp
au BufRead,BufNewFile *.ino set filetype=cpp

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

nnoremap <leader>fmd :call FormatMD()<CR>
vnoremap <leader>pft !par w120<CR>

""""""""""" Go settings """""""""""""""

augroup golangac
	autocmd!
	func! FormatGoLang()
		let l:winview = winsaveview()
		:exe '%!gofmt'
		call winrestview(l:winview)
	endfunc
	autocmd FileType go nnoremap <leader>fgo :call FormatGoLang()<CR>
	autocmd FileType go set shiftwidth=4 tabstop=4
	au FileType go nnoremap <leader>fff :call FormatGoLang()<CR>
augroup END

""""""""""" Lua settings """""""""""""""

augroup luagac
	autocmd!
	func! FormatLua()
		let l:winview = winsaveview()
		" :silent! %s/\(,\)\([a-zA-Z0-9#{(]\)/\1 \2/g
		" :silent! %s/\([=\/%\+]\)\([a-zA-Z0-9]\)/\1 \2/g
		" :silent! %s/\([a-zA-Z0-9]\)\([=\/%\+]\)/\1 \2/g
		normal gg=G
		" To do...
		call winrestview(l:winview)
	endfunc
	let g:lua_complete_omni = 1
	let g:lua_complete_dynamic = 0
	autocmd FileType lua nnoremap <leader>fmt :call FormatLua()<CR>
	autocmd FileType lua set shiftwidth=4 tabstop=4 expandtab
	au FileType lua nnoremap <leader>fff :call FormatLua()<CR>
	" vnoremap <leader>fff :call FormatLines()<CR>
augroup END

""""""""""" CMake settings """"""""""""""""""""""

augroup cmakeac
	autocmd!
	autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim
	autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
	autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake
augroup END

""""""""""" Python settings """"""""""""""""""""""

augroup pythonac
	autocmd!
	autocmd FileType python set shiftwidth=4 tabstop=4 expandtab
	" autocmd FileType python vnoremap <leader>ffp :!autopep8 -<CR>
augroup END

command! ClearPypath :let $PYTHONPATH=''
command! SetArduPypath :let $PYTHONPATH='ArduCopterTestSitl/:ArduCopterTestSitl/pysim'

vnoremap <leader>ffp :!autopep8 -a -<CR>
nnoremap <leader>ffp :%!autopep8 -a %<CR>

""""""""""" Html settings """"""""""""""""""""""

nnoremap <leader>fht :%!pandoc -f html -t markdown \| pandoc -f markdown -t html<CR>
vnoremap <leader>fht :!pandoc -f html -t markdown \| pandoc -f markdown -t html<CR>

""""""""""" Binary settings """"""""""""""""""""""

" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
func! ToggleHex()
	" hex mode should be considered a read-only operation
	" save values for modified and read-only for restoration later,
	" and clear the read-only flag for now
	let l:modified=&mod
	let l:oldreadonly=&readonly
	let &readonly=0
	let l:oldmodifiable=&modifiable
	let &modifiable=1
	if !exists("b:editHex") || !b:editHex
		" save old options
		let b:oldft=&ft
		let b:oldbin=&bin
		" set new options
		setlocal binary " make sure it overrides any textwidth, etc.
		silent :e " this will reload the file without trickeries 
		"(DOS line endings will be shown entirely )
		let &ft="xxd"
		" set status
		let b:editHex=1
		" switch to hex editor
		%!xxd
	else
		" restore old options
		let &ft=b:oldft
		if !b:oldbin
			setlocal nobinary
		endif
		" set status
		let b:editHex=0
		" return to normal editing
		%!xxd -r
	endif
	" restore values for modified and read only state
	let &mod=l:modified
	let &readonly=l:oldreadonly
	let &modifiable=l:oldmodifiable
endfunction

" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
	" vim -b : edit binary using xxd-format!
	augroup Binary
		au!

		" set binary option for all binary files before reading them
		au BufReadPre *.bin,*.hex setlocal binary

		" if on a fresh read the buffer variable is already set, it's wrong
		au BufReadPost *
					\ if exists('b:editHex') && b:editHex |
					\   let b:editHex = 0 |
					\ endif

		" convert to hex on startup for binary files automatically
		au BufReadPost *
					\ if &binary | Hexmode | endif

		" When the text is freed, the next time the buffer is made active it will
		" re-read the text and thus not match the correct mode, we will need to
		" convert it again if the buffer is again loaded.
		au BufUnload *
					\ if getbufvar(expand("<afile>"), 'editHex') == 1 |
					\   call setbufvar(expand("<afile>"), 'editHex', 0) |
					\ endif

		" before writing a file when editing in hex mode, convert back to non-hex
		au BufWritePre *
					\ if exists("b:editHex") && b:editHex && &binary |
					\  let oldro=&ro | let &ro=0 |
					\  let oldma=&ma | let &ma=1 |
					\  silent exe "%!xxd -r" |
					\  let &ma=oldma | let &ro=oldro |
					\  unlet oldma | unlet oldro |
					\ endif

		" after writing a binary file, if we're in hex mode, restore hex mode
		au BufWritePost *
					\ if exists("b:editHex") && b:editHex && &binary |
					\  let oldro=&ro | let &ro=0 |
					\  let oldma=&ma | let &ma=1 |
					\  silent exe "%!xxd" |
					\  exe "set nomod" |
					\  let &ma=oldma | let &ro=oldro |
					\  unlet oldma | unlet oldro |
					\ endif
	augroup END
endif

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
Plugin 'https://github.com/tpope/vim-git.git'

" plugin from http://vim-scripts.org/vim/scripts.html

" Unused for now. Potentially delete.
" Plugin 'https://github.com/kien/ctrlp.vim.git'
" Plugin 'https://github.com/jeetsukumaran/vim-buffergator.git'

Plugin 'L9'
Plugin 'https://github.com/ddollar/nerdcommenter.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
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
Plugin 'https://github.com/oplatek/Conque-Shell'
Plugin 'https://github.com/vim-scripts/Cppcheck-compiler.git'

Plugin 'https://github.com/terryma/vim-expand-region.git'
Plugin 'https://github.com/editorconfig/editorconfig-vim.git'
Plugin 'https://github.com/vim-scripts/ZoomWin.git'

" PHP
Plugin 'https://github.com/spf13/PIV.git'

" Tags
Plugin 'https://github.com/vim-scripts/gtags.vim.git'
Plugin 'https://github.com/hewes/unite-gtags.git'
Plugin 'https://github.com/Shougo/unite-outline.git'


" Haskell
Plugin 'https://github.com/dag/vim2hs.git'
Plugin 'https://github.com/eagletmt/neco-ghc.git'
Plugin 'https://github.com/eagletmt/ghcmod-vim.git'
Plugin 'https://github.com/pbrisbin/vim-syntax-shakespeare.git'
Plugin 'https://github.com/raichoo/haskell-vim.git'

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
Plugin 'https://github.com/flazz/vim-colorschemes.git'

Plugin 'https://github.com/amoffat/snake.git'

Plugin 'https://github.com/dleonard0/pony-vim-syntax.git'

Plugin 'https://github.com/OmniSharp/omnisharp-vim.git'

Plugin 'https://github.com/xolox/vim-misc.git'
Plugin 'https://github.com/xolox/vim-lua-ftplugin.git'
Plugin 'https://github.com/graymanto/vim-lua-indent.git'
" Plugin 'https://github.com/xolox/vim-lua-inspect.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

""""""""""" Platform specific plugins """""""""""""""""
if has("macunix")
	Plugin 'https://github.com/kballard/vim-swift.git'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""" After plugin settings """"""""""""""""""""""

:nnoremap <leader><leader> <C-^>

if !has('gui_running')
	highlight Pmenu ctermbg=200 ctermfg=white gui=bold
endif

ShowTabs
