" Link to organize vimrc:
" https://tuckerchapman.com/2020/05/09/vimrc_organization/
set nocompatible    " Disables vi compatibility

"loads python3 first instead of python2 for vim to use python3
if has('python3')
endif

"PLUG PLUGINS SECTION
"
"
"

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

"Deoplete, autocompletion
Plug 'shougo/deoplete.nvim'

"Neosnippets
if !has('nvim')
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

"neosnippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Ctrlp, fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'

" gitgutter, shows add, deleted and changed lines in git project
Plug 'airblade/vim-gitgutter'

" Class outline viewer for vim. Easy way to browse tags
Plug 'majutsushi/tagbar'

"Ack, search tool for substrings of code
Plug 'mileszs/ack.vim'

"Nerdcommenter, commenter tool
Plug 'scrooloose/nerdcommenter'

"Delete hidden buffers
Plug 'arithran/vim-delete-hidden-buffers'

"Repeats last action, even from plugins
Plug 'tpope/vim-repeat'

"auto-pairs. For example ( inputs ()
Plug 'jiangmiao/auto-pairs'

"Nerdtree. Interactive project tree management
Plug 'scrooloose/nerdtree'

"Vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Complete brackets (), [], {}, etc
Plug 'tpope/vim-surround'

"Goes to normal mode with jk or kj
Plug 'zhou13/vim-easyescape'

"Plug to see and remove trailing whitespaces
Plug 'ntpeters/vim-better-whitespace'

"git wrapper
Plug 'tpope/vim-fugitive'

"emmet, html helper tool
Plug 'mattn/emmet-vim'

Plug 'godlygeek/tabular'

"vim blade. Syntax for blade
Plug 'jwalton512/vim-blade'

"Dummy text generator
Plug 'vim-scripts/loremipsum'

"Latex plugin
Plug 'lervag/vimtex'

"Show indentation plugin
Plug 'Yggdroot/indentLine'

"Exchange two words
Plug 'tommcdo/vim-exchange'

"Vim sugar for the UNIX shell commands that need it the most
Plug 'tpope/vim-eunuch'

"A completion framework and language server client
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" VimWiki is a personal wiki for Vim -- a number of linked text files that have their own syntax highlighting.
Plug 'vimwiki/vimwiki'

" Syntax highlighting for javascript
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" Laravel wrapper and optional dependencies
Plug 'tpope/vim-dispatch'             "| Optional
Plug 'tpope/vim-projectionist'        "|
Plug 'noahfrederick/vim-composer'     "|
Plug 'noahfrederick/vim-laravel'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" visual increment vertical numbers
Plug 'triglav/vim-visual-increment'

" general syntax checker
Plug 'vim-syntastic/syntastic'

" syntax highlight for python
"Plug 'hdima/python-syntax'

" python ide functionality
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Readline key bindings for vim
Plug 'tpope/vim-rsi'

" Switch between single-line and multiline forms of code
" gS for single line to multiline
" gJ for multiline to single line
Plug 'AndrewRadev/splitjoin.vim'

" Pairs of handy bracket mappings (https://github.com/tpope/vim-unimpaired)
Plug 'tpope/vim-unimpaired'

" Asynchronous build and test dispatcher (https://github.com/tpope/vim-dispatch)
Plug 'tpope/vim-dispatch'

" Vim plugin for insert mode completion of words in adjacent tmux panes
Plug 'wellle/tmux-complete.vim'

call plug#end()
"END PLUG PLUGINS SECTION


let g:ycm_python_binary_path = '/usr/bin/python3' "for YouCompleteMe
let g:ycm_python_binary_path = 'python' "for YouCompleteMe

let g:deoplete#enable_at_startup = 1 " Use deoplete.
"
"
"
let mapleader = "," " Sets the leader to be ,
let maplocalleader = "," " Sets the localleader to be ,

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
"Don't ask for confirmation to remove whitespace
let g:strip_whitespace_confirm=0
"Highlight space characters that appear before or in-between tabs
let g:show_spaces_that_precede_tabs=1

"Copy from clipboard
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

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

" neosnippet Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

cnoreabbrev artisan Artisan

" syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
"let g:syntastic_python_checkers = ['pyflakes_with_warnings']
let g:syntastic_python_checkers = ['mypy']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_vue_checkers = ['eslint']

" python mode options
let g:pymode_options_colorcolumn = 0

