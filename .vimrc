"" vundle specific
set nocompatible   " be iMproved
filetype off       " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
"  " required!
Plugin 'gmarik/vundle'

"" plugins
" Some utility functions for VIM (needed by snipmate)
Plugin 'tomtom/tlib_vim'
" interpret a file by function and cache file automatically (needed by snipmate)
Plugin 'MarcWeber/vim-addon-mw-utils'
" a concise vim script that implements some of TextMate's snippets
Plugin 'garbas/vim-snipmate'
" vim-snipmate default snippets
Plugin 'honza/vim-snippets'
" quoting/parenthesizing made simple
Plugin 'tpope/vim-surround'
" pairs of handy bracket mappings
Plugin 'tpope/vim-unimpaired'
" Perform all your vim insert mode completions with Tab
"Plugin 'ervandew/supertab'
" lean & mean status/tabline for vim that's light as air
Plugin 'bling/vim-airline'
" A tree explorer plugin for vim
Plugin 'scrooloose/nerdtree'
" plugin for intensely orgasmic commenting
Plugin 'scrooloose/nerdcommenter'
" Vim plugin to list, select and switch between buffers
Plugin 'jeetsukumaran/vim-buffergator'
" Next generation completion framework after neocomplcache
Plugin 'Shougo/neocomplete.vim'
" Fuzzy file, buffer, mru, tag, etc finder
Plugin 'kien/ctrlp.vim'
" helpers for UNIX
Plugin 'tpope/vim-eunuch'
" a Git wrapper so awesome, it should be illegal
Plugin 'tpope/vim-fugitive'
" A Vim plugin which shows a git diff in the gutter (sign column) and stages/reverts hunks.
Plugin 'airblade/vim-gitgutter'
" Vim plugin that displays tags in a window, ordered by class etc.
Plugin 'majutsushi/tagbar'
" Syntax checking hacks for vim
Plugin 'scrooloose/syntastic'
" A Vim plugin for visually displaying indent levels in code
Plugin 'nathanaelkane/vim-indent-guides'
" Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
Plugin 'Raimondi/delimitMate'
" Miscellaneous auto-load Vim scripts (needed by vim-session)
Plugin 'xolox/vim-misc'
" Extended session management for Vim
Plugin 'xolox/vim-session'
" Vim plugin for the Perl module / CLI script 'ack'
Plugin 'mileszs/ack.vim'

" Vim Markdown runtime files
Plugin 'tpope/vim-markdown'

"" HTML/CSS
" emmet for vim
Plugin 'mattn/emmet-vim'
" Highlight colors in css files" Highlight colors in css files
Plugin 'ap/vim-css-color'
" vim syntax for LESS (dynamic CSS)
Plugin 'groenewege/vim-less'

" Vim support for Rust file detection and syntax highlighting
"Plugin 'wting/rust.vim'

" vim2hs :: Vim -> Haskell
Plugin 'dag/vim2hs'
" Interactive command execution in Vim. (needed by ghcmod-vim)
Plugin 'Shougo/vimproc.vim'
" Happy Haskell programming on Vim, powered by ghc-mod
Plugin 'eagletmt/ghcmod-vim'
" Vim plugin for Haskell development
Plugin 'bitc/vim-hdevtools'

"" Prolog
" Prolog Integration for Vim
"Plugin 'adimit/prolog.vim'

"" Ruby
" wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
"Plugin 'tpope/vim-endwise'
" Vim runtime files for Haml, Sass, and SCSS
"Plugin 'tpope/vim-haml'
" Ruby on Rails power tools
"Plugin 'tpope/vim-rails'

" Enhanced javascript syntax file for Vim
Plugin 'jelera/vim-javascript-syntax'
" Vastly improved Javascript indentation and syntax support in Vim
Plugin 'pangloss/vim-javascript'
" A plugin that integrates JSHint with Vim
Plugin 'walm/jshint.vim'
" Tern plugin for Vim
Plugin 'marijnh/tern_for_vim'

" QML syntax highlighting for VIM
Plugin 'peterhoeg/vim-qml'

" Integration of Scala into Vim
Plugin 'derekwyatt/vim-scala'

" PGSQL syntax
"Plugin 'exu/pgsql.vim'

"" color schemes
" Molokai color scheme for Vim
"Plugin 'tomasr/molokai'
" Dark and light color scheme
"Plugin 'vim-scripts/Lucius'
" precision colorscheme for the vim text editor
"Plugin 'altercation/vim-colors-solarized'
" Base16 for Vim
Plugin 'chriskempson/base16-vim'

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
set background=dark
colorscheme base16-default " because we prefer a non default colorscheme
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
set backupdir^=~/.vim/_backup/    " where to put backup files.
set directory^=~/.vim/_temp/      " where to put swap files.

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Enable intent-guides
au VimEnter * :IndentGuidesEnable
let g:indent_guides_guide_size = 1

" use patched powerline fonts
"let g:airline_powerline_fonts = 1
" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" This does what it says on the tin. It will check your file on open too, not just on save.
let g:syntastic_check_on_open = 1

" Enable emmet just for HTML/CSS
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" vim-session
let g:session_autoload = 'no'
let g:session_autosave = 'no'

" automatically start NERDTree when vim starts up with no files specified
"autocmd vimenter * if !argc() | NERDTree | endif

" Buffergator
nnoremap <F7> :BuffergatorToggle<CR>

" NERDTree
nnoremap <F8> :NERDTreeToggle<CR>

" TagBar
nnoremap <F9> :TagbarToggle<CR>

" Tern
let g:tern#command = ['tern', '--no-port-file']
let g:tern_show_argument_hints = "on_hold"
set updatetime=1000
nnoremap K :TernDoc<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Shorcut to toggle indent guides
nmap <leader>g :IndentGuidesToggle<CR>

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

" Reformat XML file
au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"

" ghc-mod Reload
map <silent> tu :call GHC_BrowseAll()<CR>
" ghc-moc Type Lookup
map <silent> tw :call GHC_ShowType(1)<CR>
