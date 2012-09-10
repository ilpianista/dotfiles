"" vundle specific
filetype off " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
"  " required!
Bundle 'gmarik/vundle'

"" plugins
" Ruby on Rails power tools
Bundle 'tpope/vim-rails'
" Vim Cucumber runtime files
Bundle 'tpope/vim-cucumber'
" Vim runtime files for Haml, Sass, and SCSS
Bundle 'tpope/vim-haml'
" wisely add "end" in ruby, endfunction/endif/more in vim script
Bundle 'tpope/vim-endwise'
" a Git wrapper so awesome, it should be illegal
Bundle 'tpope/vim-fugitive'
" quoting/parenthesizing made simple
Bundle 'tpope/vim-surround'
" pairs of handy bracket mappings
Bundle 'tpope/vim-unimpaired'
" switch Ruby versions from inside Vim
Bundle 'tpope/vim-rvm'
" easily search for, substitute, and abbreviate multiple variants of a word
Bundle 'tpope/vim-abolish'
" Lightweight support for Ruby's Bundler
Bundle 'tpope/vim-bundler'
" Provides database access to many dbms (Oracle, Sybase, Microsoft, MySQL, DBI,..)
Bundle 'vim-scripts/dbext.vim'
" The ultimate vim statusline utility
Bundle 'Lokaltog/vim-powerline'
" A tree explorer plugin for vim
Bundle 'scrooloose/nerdtree'
" plugin for intensely orgasmic commenting
Bundle 'scrooloose/nerdcommenter'

"" color schemes
" Molokai color scheme for Vim
Bundle 'tomasr/molokai'
" Dark and light color scheme
Bundle 'vim-scripts/Lucius'
" The original IR_Black color scheme for vim
Bundle 'twerth/ir_black'

"" general stuff
set nocompatible   " Use Vim defaults instead of 100% vi compatibility
set encoding=utf-8 " necessary to show unicode glyphs
set showcmd        " display incomplete commands
set number         " turn line numbering on
set cursorline     " highlight the cursor line
set cursorcolumn   " highlight the cursor column
set backspace=indent,eol,start " more powerful backspacing
set history=50     " keep 50 lines of command line history
set ruler          " show the cursor position all the time
set laststatus=2    " always show the status line
filetype plugin indent on " turn on filetype detection, filetype plugins, and autoindent

"" color stuffs
syntax on           " turn syntax highlighting on
set t_Co=256        " Explicitly tell vim that the terminal supports 256 colors
colorscheme lucius  " because we prefer a non default colorscheme

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

"" ruby
au FileType ruby set tabstop=2 shiftwidth=2 expandtab

"" bash
au FileType bash set tabstop=2 shiftwidth=2 expandtab

"" java
au FileType java set tabstop=4 shiftwidth=4

" Import the class under the cursor with <leader>i (:h mapleader)
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
" Search for the javadocs of the element under the cursor with <leader>d
nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
" Perform a context sensitive search of the element under the cursor with <enter>
nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
