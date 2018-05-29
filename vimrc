set nocompatible    " Disables vi compatibility

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

"loads python3 first instead of python2 for vim to use python3
if has('python3')
endif

"VUNDLE PLUGINS SECTION
"
"
"
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Install YouCompleteMe, autocompletition of code
Plugin 'Valloric/YouCompleteMe'

" Ctrlp, fuzzy file finder
Plugin 'ctrlpvim/ctrlp.vim'

" gitgutter, shows add, deleted and changed lines in git project
Plugin 'airblade/vim-gitgutter'

" Class outline viewer for vim. Easy way to browse tags
Plugin 'majutsushi/tagbar'

"Ack, search tool for substrings of code
Plugin 'mileszs/ack.vim'

"Nerdcommenter, commenter tool
Plugin 'scrooloose/nerdcommenter'

"Delete hidden buffers
Plugin 'arithran/vim-delete-hidden-buffers'

"Repeats last action, even from plugins
Plugin 'tpope/vim-repeat'

"auto-pairs. For example ( inputs ()
Plugin 'jiangmiao/auto-pairs'

"Nerdtree. Interactive project tree management
Plugin 'scrooloose/nerdtree'

"Vim airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'tpope/vim-surround'

"Goes to normal mode with jk or kj
Plugin 'zhou13/vim-easyescape'

"Syntactic checker
Plugin 'vim-syntastic/syntastic'

"Plugin to see and remove trailing whitespaces
Plugin 'ntpeters/vim-better-whitespace'

"git wrapper
Plugin 'tpope/vim-fugitive'

"emmet, html helper tool
Plugin 'mattn/emmet-vim'

Plugin 'godlygeek/tabular'

"vim blade. Syntax for blade
Plugin 'jwalton512/vim-blade'

call vundle#end()            " required

let g:ycm_python_binary_path = '/usr/bin/python3' "for YouCompleteMe
let g:ycm_python_binary_path = 'python' "for YouCompleteMe

"
"
"
"END VUNDLE PLUGINS SECTION

"Loads plugins
execute pathogen#infect()

"Let plugins detect type of file and aplpy identation accordingly
filetype plugin indent on

let mapleader = "," " Sets the leader to be ,

set number	        " Numbers lines

set relativenumber  " Numbers lines relatively. Makes current line 0
                    " And starts counting upwards and downwards

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

syntax on           " Turns on syntax highlighting

set visualbell      " Blink screen on error instead of beeping

set noerrorbells    "Doesn't ring error bell"

set encoding=utf-8  " Sets encoding to utf-8 to not have problems with languages

set laststatus=2    " Sets the status bar to show more info, like filename

set ttyfast         " Improves scrolling speed

set ignorecase      " Ignores cases when searching (set for smartcase)

set smartcase       " Ignore case unless there is capital letter in search

set hlsearch        " Highlight matches when searching

set incsearch       " Search as characters are entered

set autoread        " Reload files if changed externally

set showcmd         " Shows partial command on bottom of screen

set showmode        " Shows the current mode

set autoindent      " Indents next line according to previous indentation

set smartindent     " Complements autoindent

set copyindent      " Copies the exact indent characters (same number of spaces or tabs)

set lazyredraw      "Redraws lazily (doesn't redraw in macros for example)

set path+=**        "When searching for file, search in every subdirectory"

set wildmenu        "Show menu of possible hits when looking for a file"

set hidden          "Shows hidden buffers"

set nowrap          "Don't wrap lines"

set updatetime=100  "Updates things in 100ms. Specially useful for gitgutter"

"Removes highlight with leader + space
nnoremap <leader><space> :nohlsearch<CR>

"Remaps : to ;. Now to use : commands I can use ; instead
nnoremap ; :

"To move trough windows, instead of using CTRL+w+h, is CTRL+h
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"Toggle NERDTree with F2
map <F2> :NERDTreeToggle<CR>

"Toggle tagbar with F8
nmap <F8> :TagbarToggle<CR>

"Remap escape to jk or kj (must type it fast to take effect)
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>

"Autotabularize
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

"Strip whitespace on save
let g:strip_whitespace_on_save=1

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

