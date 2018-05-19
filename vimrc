set nocompatible    " Disables vi compatibility

"Loads plugins
execute pathogen#infect()

"Let plugins detect type of file and aplpy identation accordingly
filetype plugin indent on

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

let mapleader = "," " Sets the leader to be ,

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

