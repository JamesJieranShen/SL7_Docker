" Clean Vim setup
" Author: James Shen

set nocompatible
" filetype off	" required for VUNDLE
"==============================================================================
"				VUNDLE Management
"==============================================================================
"
" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'
" Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'vim-latex/vim-latex'


"==============================================================================
"				Plugins END
"==============================================================================

" call vundle#end()            " required
" filetype plugin indent on    " required

" Common setups:
set autoindent
" set colorcolumn=81 " put red line at col 80.
set number " Line number
set ruler " Bottom left coordinate
set guioptions=Te " Keey GUI buttons visible
set lbr " auto line break
set tw=80 "total width = 79 
set tabstop =4 " tabs appear as 4 spaces
set shiftwidth =4 "size of an indent
set expandtab " expand tab to spaces
set smarttab
set smartcase " Override ignorecase when search contains CAPS
set ignorecase " default search not case sensitive
set tabpagemax=100 " increase # of tabs that can be opened
set cursorline " highlight cursorline
set wildmenu " visual autocomplete for command menu


" Line-wrap behaviors
: set fo+=t " Use textwidth
:set fo-=l " wrap pre-existing long lines

filetype on " Enable filetype detection

" Function determining braces remal
function GetFileType()
	let fts = ['c', 'cpp', 'java', 'objc', 'haskell', 'javascript', 'r']

	let curr = &filetype

    if index(fts, curr) == 0 || index(fts, curr) == 1
        return 2        " c file
    elseif index(fts, curr) == -1
		return 0
	else
		return 1
	endif
endfunction

" Setting pairing parenthesis, square brackets, and expanding curly braces
inoremap <expr> {} (GetFileType() != 0 ? '{<CR>}<ESC>O' : '{}<Esc>i')
inoremap <expr> /* (GetFileType() == 2 ? '/**/<ESC>hi' : '/*')
inoremap () ()<Esc>i
inoremap [] []<Esc>i
inoremap "" ""<Esc>i
inoremap '' ''<Esc>i
inoremap `` ``<Esc>i
inoremap <> <><Esc>i

" Syntax control:
syntax on

"" Make overlength stuff red
"highlight OverLength	ctermbg=red	guibg = red
"augroup myMatches
"	autocmd!
"	au WinEnter,BufEnter *
"		\ call clearmatches() |
"		\ call matchadd('OverLength', '\%81v.\+', -1)
"augroup END

" searching setup
set incsearch
set hlsearch

" turnoff search highlight with comma+space
nnoremap ,<space> :nohlsearch<CR>


" key remaps
nnoremap J ^
nnoremap L $
nnoremap ^ <nop>
nnoremap & <nop>

" backup settings
set writebackup
set backupext=.bak
