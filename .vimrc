" Needed on some linux distros.
" " see
" http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
filetype off
call pathogen#helptags()
call pathogen#incubate()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


" Disable the splash screen
:set shortmess +=I


if has( 'gui_running' )
  set transparency=0
  set background=dark
  colorscheme solarized
else
  set background=dark
  colorscheme solarized
endif

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
let mapleader=","

let g:vim_markdown_folding_disabled=1

" ================ Search Settings  =================

set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set viminfo='100,f1  "Save up to 100 marks, enable capital marks

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Word Processor Mode ==============
func! WordProcessorMode()
    setlocal formatoptions=t1
    setlocal noexpandtab
    setlocal textwidth=80
    map j gj
    map k gk
    setlocal smartindent
    setlocal spell spelllang=en_us
    set thesaurus+=/Users/tylerhannan/.vim/thesaurus/mthesaur.txt
    set complete+=s
    set formatprg=par
    setlocal wrap
    setlocal linebreak
endfu
com! WP call WordProcessorMode()



set clipboard=unnamed
