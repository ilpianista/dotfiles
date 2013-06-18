"" vundle specific
set nocompatible   " be iMproved
filetype off       " required!

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
" Perform all your vim insert mode completions with Tab
Bundle 'ervandew/supertab'
" The ultimate vim statusline utility
Bundle 'Lokaltog/vim-powerline'
" A tree explorer plugin for vim
Bundle 'scrooloose/nerdtree'
" plugin for intensely orgasmic commenting
Bundle 'scrooloose/nerdcommenter'
" needed by gist-vim
Bundle 'mattn/webapi-vim'
" vimscript for gist
Bundle 'mattn/gist-vim'
" Vim plugin for the Perl module / CLI script 'ack'
Bundle 'mileszs/ack.vim'
" Vim plugin to list, select and switch between buffers
Bundle 'jeetsukumaran/vim-buffergator'
" Fuzzy file, buffer, mru, tag, etc finder
Bundle 'kien/ctrlp.vim'
" helpers for UNIX
Bundle 'tpope/vim-eunuch'
" a Git wrapper so awesome, it should be illegal
Bundle 'tpope/vim-fugitive'
" Vim Markdown runtime files
Bundle 'tpope/vim-markdown'

"" HTML/CSS
" support for expanding abbreviation like zen-coding(emmet)
"Bundle 'mattn/zencoding-vim'
" A parser for a condensed HTML format (mirror repo)
"Bundle 'tristen/vim-sparkup'
" Highlight colors in css files" Highlight colors in css files
Bundle 'ap/vim-css-color'

" a vim plugin for Nanoc
Bundle 'timgreen/vim-nanoc'

"" Scala
"Bundle 'derekwyatt/vim-scala'
" Scala snippets for Vim's snipMate plugin (manually run make install to install)
"Bundle 'tommorris/scala-vim-snippets'
" Play20 framework vim plugin
"Bundle 'gre/play2vim'

"" Prolog
" Prolog Integration for Vim
Bundle 'adimit/prolog.vim'

"" Ruby
" wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
Bundle 'tpope/vim-endwise'
" Vim runtime files for Haml, Sass, and SCSS
"Bundle 'tpope/vim-haml'
" Ruby on Rails power tools
"Bundle 'tpope/vim-rails'

"" color schemes
" Molokai color scheme for Vim
Bundle 'tomasr/molokai'
" Dark and light color scheme
Bundle 'vim-scripts/Lucius'
" precision colorscheme for the vim text editor
Bundle 'altercation/vim-colors-solarized'

"" general stuff
set encoding=utf-8 " necessary to show unicode glyphs
set showcmd        " display incomplete commands
set number         " turn line numbering on
set cursorline     " highlight the cursor line
set cursorcolumn   " highlight the cursor column
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
set tabstop=2       " tabs count as 2 spaces
set shiftwidth=2    " number of spaces to use in autoindent
set expandtab       " use spaces instead of tabs
set list            " show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

set autoindent      " copy indent from current line when starting a new line

set hlsearch        " highlight all matches in the previous search
set incsearch       " incremental searching
set ignorecase      " searches are case insensitive...
set smartcase       " ... unless they contain at least one capital letter 

set wildmode=full
set wildmenu        " command-line completion operates in an enhanced mode
set completeopt=longest,menuone " completion popup menu work just like in an IDE

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Disable temp and backup files
set wildignore+=*.swp,*~,._*

"" Backup and swap files
set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files.

" vim-powerline
let g:Powerline_symbols = 'fancy'

" gist-vim
let g:github_user = 'scarpin0'

