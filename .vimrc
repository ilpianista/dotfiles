"" vundle specific
filetype off " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
"  " required!
Bundle 'gmarik/vundle'

"" plugins
" dependencies for snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"
" a concise vim script that implements some of TextMate's snippets
Bundle 'garbas/vim-snipmate'
" a Git wrapper so awesome, it should be illegal
" Bundle 'tpope/vim-fugitive'
" quoting/parenthesizing made simple
Bundle 'tpope/vim-surround'
" pairs of handy bracket mappings
Bundle 'tpope/vim-unimpaired'
" easily search for, substitute, and abbreviate multiple variants of a word
Bundle 'tpope/vim-abolish'
" needed by vim-session
Bundle 'xolox/vim-misc'
" Extended session management for Vim
Bundle 'xolox/vim-session'
" Perform all your vim insert mode completions with Tab
Bundle 'ervandew/supertab'
" The ultimate vim statusline utility
Bundle 'Lokaltog/vim-powerline'
" A tree explorer plugin for vim
Bundle 'scrooloose/nerdtree'
" plugin for intensely orgasmic commenting
Bundle 'scrooloose/nerdcommenter'
" Allows Vim to use multiple cursors simultaneously
Bundle 'paradigm/vim-multicursor'
" needed by gist-vim
Bundle 'mattn/webapi-vim'
" vimscript for gist
Bundle 'mattn/gist-vim'

" support for expanding abbreviation like zen-coding(emmet)
Bundle 'mattn/zencoding-vim'
" A parser for a condensed HTML format (mirror repo)
Bundle 'tristen/vim-sparkup'

" a vim plugin for Nanoc
Bundle 'timgreen/vim-nanoc'

" Scala stuff
"Bundle 'derekwyatt/vim-scala'
" Scala snippets for Vim's snipMate plugin (manually run make install to install)
"Bundle 'tommorris/scala-vim-snippets'
" Play20 framework vim plugin
"Bundle 'gre/play2vim'

" Prolog Integration for Vim
Bundle 'adimit/prolog.vim'

"" color schemes
" Molokai color scheme for Vim
Bundle 'tomasr/molokai'
" Dark and light color scheme
Bundle 'vim-scripts/Lucius'
" precision colorscheme for the vim text editor
Bundle 'altercation/vim-colors-solarized'

"" general stuff
set nocompatible   " disable vi compatibility
set encoding=utf-8 " necessary to show unicode glyphs
set showcmd        " display incomplete commands
set number         " turn line numbering on
set cursorline     " highlight the cursor line
set cursorcolumn   " highlight the cursor column
set backspace=indent,eol,start " more powerful backspacing
set history=50     " keep 50 lines of command line history
set ruler          " show the cursor position all the time
set laststatus=2   " always show the status line
filetype plugin indent on " turn on filetype detection, filetype plugins, and autoindent

"" color stuffs
syntax on           " turn syntax highlighting on
set t_Co=256        " explicitly tell vim that the terminal supports 256 colors
colorscheme solarized " because we prefer a non default colorscheme
highlight clear

if has("gui_running")
  set background=dark
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
endif

"" whitespace
set nowrap          " lines longer than the width of the window will not wrap
set tabstop=4       " tabs count as 4 spaces
set smarttab        " a <Tab> in front of a line inserts blanks
set shiftwidth=4    " number of spaces to use in autoindent
set autoindent      " copy indent from current line when starting a new line
set expandtab       " use spaces instead of tabs

set hlsearch        " highlight all matches in the previous search
set ignorecase      " ignore case in search patterns
set incsearch       " show there the pattern is as it's typed

set wildmode=full  
set wildmenu        " command-line completion operates in an enhanced mode
set completeopt=longest,menuone " completion popup menu work just like in an IDE

" vim-powerline
let g:Powerline_symbols = 'fancy'

" vim-session
let g:session_autosave = 'no'

" gist-vim
let g:github_user = 'scarpin0'
