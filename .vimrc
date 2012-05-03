"" vundle specific
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" A tree explorer plugin for vim
Bundle 'scrooloose/nerdtree'
" Run commands quickly
Bundle 'thinca/vim-quickrun'
" Extended session management for Vim
Bundle 'xolox/vim-session'
" Ruby on Rails power tools
Bundle 'tpope/vim-rails'
" plugin for intensely orgasmic commenting
Bundle 'scrooloose/nerdcommenter'
" auto-completion system
Bundle 'Shougo/neocomplcache'
" statusline utility
Bundle 'Lokaltog/vim-powerline'
" a git wrapper
Bundle 'tpope/vim-fugitive'
" Syntax checking hacks for vim
Bundle 'scrooloose/syntastic'
" Fuzzy file, buffer, mru and tag finder
Bundle 'kien/ctrlp.vim'
" vimscript for gist
Bundle 'mattn/gist-vim'
" Elegant buffer explorer
Bundle 'fholgado/minibufexpl.vim'

"" vim-scripts repos
" Colorsheme Scroller, Chooser, and Browser
Bundle 'ScrollColors'
" auto convert gui colorschemes to 88/256 for terminal
Bundle 'guicolorscheme.vim'

"" general stuff
set encoding=utf-8 " necessary to show unicode glyphs
set showcmd        " display incomplete commands
set number         " turn line numbering on
set cursorline     " highlight the cursor line
set cursorcolumn   " highlight the cursor column
filetype plugin indent on " turn on filetype detection, filetype plugins, and autoindent

"" color stuffs
syntax on           " turn syntax highlighting on
set t_Co=256        " Explicitly tell vim that the terminal supports 256 colors
colorscheme lucius  " because we prefer a non default colorscheme

"" whitespace
set tabstop=4    " tabs count as 4 spaces
set shiftwidth=4 " number of spaces to use in autoindent
set expandtab    " use spaces instead of tabs
set nopaste      " disable paste mode for plugins compatibility
set textwidth=80 " maximum width of text that is being inserted
set wrap         " lines longer than the width of the window will wrap
set showmatch  " when a bracket is inserted, briefly jump to the matching one

set viminfo='10,\"100,:20,%,n~/.viminfo
set nobackup     " do not make a backup before overwriting a file

"" search
set hlsearch   " highlight matches
set incsearch  " incremental search
set ignorecase " ignore case in search pattern
set smartcase  " override ignorecase if there are uppercase letters in the search pattern

"" ruby
au FileType ruby set tabstop=2 shiftwidth=2 expandtab

"" bash
au FileType bash set tabstop=2 shiftwidth=2 expandtab

nmap <F9> :QuickRun<cr> " for vim quickrun

set foldmethod=marker " use {{{ and }}} to specify a region, useful for large blocks of trivial functions

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" powerline stuff
set laststatus=2   " Always show the statusline

" Open NERDTree automatically when vim starts up
"autocmd vimenter * NERDTree
