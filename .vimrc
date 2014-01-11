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
Bundle "tomtom/tlib_vim"
Bundle "MarcWeber/vim-addon-mw-utils"
" a concise vim script that implements some of TextMate's snippets
Bundle 'garbas/vim-snipmate'
" vim-snipmate default snippets
Bundle "honza/vim-snippets"
" quoting/parenthesizing made simple
Bundle 'tpope/vim-surround'
" pairs of handy bracket mappings
Bundle 'tpope/vim-unimpaired'
" Perform all your vim insert mode completions with Tab
"Bundle 'ervandew/supertab'
" lean & mean status/tabline for vim that's light as air
Bundle 'bling/vim-airline'
" A tree explorer plugin for vim
Bundle 'scrooloose/nerdtree'
" plugin for intensely orgasmic commenting
Bundle 'scrooloose/nerdcommenter'
" needed by gist-vim
Bundle 'mattn/webapi-vim'
" vimscript for gist
Bundle 'mattn/gist-vim'
" Vim plugin to list, select and switch between buffers
Bundle 'jeetsukumaran/vim-buffergator'
" Unite and create user interfaces
"Bundle 'Shougo/unite.vim'
" helpers for UNIX
Bundle 'tpope/vim-eunuch'
" a Git wrapper so awesome, it should be illegal
Bundle 'tpope/vim-fugitive'
" Vim plugin that displays tags in a window, ordered by class etc.
Bundle 'majutsushi/tagbar'
" Syntax checking hacks for vim
Bundle 'scrooloose/syntastic'
" A Vim plugin for visually displaying indent levels in code
Bundle 'nathanaelkane/vim-indent-guides'
" Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
Bundle 'Raimondi/delimitMate'

" Vim Markdown runtime files
Bundle 'tpope/vim-markdown'

"" HTML/CSS
" emmet for vim
Bundle 'mattn/emmet-vim'
" Highlight colors in css files" Highlight colors in css files
Bundle 'skammer/vim-css-color'
" vim syntax for LESS (dynamic CSS)
Bundle 'groenewege/vim-less'

" a vim plugin for Nanoc
Bundle 'timgreen/vim-nanoc'

" Improved PHP omnicompletion
"Bundle 'shawncplus/phpcomplete.vim'

"" Prolog
" Prolog Integration for Vim
"Bundle 'adimit/prolog.vim'

"" Ruby
" wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
Bundle 'tpope/vim-endwise'
" Vim runtime files for Haml, Sass, and SCSS
"Bundle 'tpope/vim-haml'
" Ruby on Rails power tools
"Bundle 'tpope/vim-rails'

" Enhanced javascript syntax file for Vim
Bundle 'jelera/vim-javascript-syntax'
" Vastly improved Javascript indentation and syntax support in Vim
Bundle 'pangloss/vim-javascript'
" A plugin that integrates JSHint with Vim
Bundle 'walm/jshint.vim'
" Tern plugin for Vim
Bundle 'marijnh/tern_for_vim'

" QML syntax highlighting for VIM
Bundle 'peterhoeg/vim-qml'

" PGSQL syntax
"Bundle 'exu/pgsql.vim'

"" color schemes
" Molokai color scheme for Vim
"Bundle 'tomasr/molokai'
" Dark and light color scheme
"Bundle 'vim-scripts/Lucius'
" precision colorscheme for the vim text editor
Bundle 'altercation/vim-colors-solarized'

"" general stuff
set encoding=utf-8 " necessary to show unicode glyphs
set showcmd        " display incomplete commands
set number         " turn line numbering on
"set cursorline     " highlight the cursor line
"set cursorcolumn   " highlight the cursor column
set history=50     " keep 50 lines of command line history
set ruler          " show the cursor position all the time
set laststatus=2   " always show the status line
filetype plugin indent on " turn on filetype detection, filetype plugins, and autoindent

"" color stuffs
syntax on           " turn syntax highlighting on
set t_Co=256        " explicitly tell vim that the terminal supports 256 colors
colorscheme solarized " because we prefer a non default colorscheme
"highlight clear
highlight Pmenu guibg=brown gui=bold

"" whitespace
set nowrap          " lines longer than the width of the window will not wrap
set tabstop=2       " tabs count as 2 spaces
set shiftwidth=2    " number of spaces to use in autoindent
set expandtab       " use spaces instead of tabs
"set list            " show invisible characters
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

" Enable intent-guides
au VimEnter * :IndentGuidesEnable
let g:indent_guides_guide_size = 1

" use patched powerline fonts
"let g:airline_powerline_fonts = 1

" This does what it says on the tin. It will check your file on open too, not just on save.
let g:syntastic_check_on_open = 1

" Enable emmet just for HTML/CSS
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" gist-vim
let g:github_user = 'andreascarpino'
let g:gist_detect_filetype = 1

" automatically start NERDTree when vim starts up with no files specified
autocmd vimenter * if !argc() | NERDTree | endif

" Buffergator
nnoremap <F7> :BuffergatorToggle<CR>

" TagBar
nnoremap <F8> :TagbarToggle<CR>

" NERDTree
nnoremap <F9> :NERDTreeToggle<CR>

" Tern
let g:tern#command = ['node', '/usr/bin/tern', '--no-port-file']
let g:tern_show_argument_hints = "on_move"
nnoremap K :TernDoc<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Hide serach results
nnoremap <F3> :set hlsearch!<CR>

" use jk as <Esc> alternative
inoremap jk <Esc>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" highlight trailing spaces
match Error /\s\+$/

" pgsql syntax highlight
au BufNewFile,BufRead *.pgsql setf pgsql
au BufNewFile,BufRead *.plpgsql setf pgsql
