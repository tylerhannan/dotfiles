execute pathogen#infect()

"Features
set autoindent smartindent
set scrolloff=5
set nocompatible
set number

"Turn off the noises
set visualbell
set t_vb=
set noerrorbells

" Appearance
syntax enable
set ruler
set background=dark

if has( 'gui_running' )
  set transparency=0
  colorscheme solarized
else
  colorscheme solarized
endif

"Editor configuration
set shiftwidth=2
set softtabstop=2
set expandtab
set expandtab
set copyindent
filetype indent plugin on

set clipboard=unnamed
