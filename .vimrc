"" vundle specific
filetype off " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
"  " required!
Bundle 'gmarik/vundle'

"" plugins
" dependencies for snipmate by garbas
Bundle "vim-scripts/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
" a concise vim script that implements some of TextMate's snippets
Bundle 'garbas/vim-snipmate'
" Original snipmate repo (outdated)
"Bundle 'msanders/snipmate.vim'
" a Git wrapper so awesome, it should be illegal
Bundle 'tpope/vim-fugitive'
" quoting/parenthesizing made simple
Bundle 'tpope/vim-surround'
" pairs of handy bracket mappings
Bundle 'tpope/vim-unimpaired'
" easily search for, substitute, and abbreviate multiple variants of a word
Bundle 'tpope/vim-abolish'
" Extended session management for Vim
Bundle 'xolox/vim-session'
" Provides database access to many dbms (Oracle, Sybase, Microsoft, MySQL, DBI,..)
Bundle 'vim-scripts/dbext.vim'
" A parser for a condensed HTML format
Bundle 'rstacruz/sparkup'
" HTML5 omnicomplete and syntax
Bundle 'othree/html5.vim'
" The ultimate vim statusline utility
Bundle 'Lokaltog/vim-powerline'
" A tree explorer plugin for vim
Bundle 'scrooloose/nerdtree'
" plugin for intensely orgasmic commenting
Bundle 'scrooloose/nerdcommenter'
" Ultimate auto-completion system for Vim
Bundle 'Shougo/neocomplcache'
" neocomplcache complete snippets source
Bundle 'Shougo/neocomplcache-snippets-complete'

" Ruby stuff
" Ruby on Rails power tools
Bundle 'tpope/vim-rails'
" vim syntax for LESS (dynamic CSS)
Bundle 'groenewege/vim-less'
" Vim runtime files for Haml, Sass, and SCSS
Bundle 'tpope/vim-haml'

" Java stuff
" eclipse + vim (manually run 'ant' to install)
Bundle 'ervandew/eclim'

" Scala stuff
Bundle 'derekwyatt/vim-scala'
" Scala snippets for Vim's snipMate plugin (manually run make install to install)
Bundle 'tommorris/scala-vim-snippets'
" Play20 framework vim plugin
Bundle 'gre/play2vim'

"" color schemes
" Molokai color scheme for Vim
Bundle 'tomasr/molokai'
" Dark and light color scheme
Bundle 'vim-scripts/Lucius'

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
colorscheme lucius " because we prefer a non default colorscheme
LuciusBlack

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

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Plugin key-mappings.
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"" Eclim settings
" 2 means Errors
let g:EclimLogLevel=2
" a project tree window will be auto opened for new Vim sessions
let g:EclimProjectTreeAutoOpen=1
" the path of the current file will be expanded in the project tree
let g:EclimProjectTreeExpandPathOnOpen=1
" list of mappings which link file patterns to the available actions
let g:EclimProjectTreeActions = [
    \ {'pattern': '.*', 'name': 'Split', 'action': 'split'},
    \ {'pattern': '.*', 'name': 'Tab', 'action': 'tabnew'},
    \ {'pattern': '.*', 'name': 'Edit', 'action': 'edit'},
  \ ]
" defines the regex pattern used to identify todo or fixme entries
let g:EclimTodoSearchPattern = '\(\<fixme\>\|\<todo\>\)\c'
" defines a list of file extensions that will be searched for the todo / fixme entries
let g:EclimTodoSearchExtensions = ['java', 'jsp', 'xml', 'html']
" the validation results will be sorted by severity (errors > warnings > info > etc.)
let g:EclimValidateSortResults = 'severity'

" eclim shortcuts
map <C-S-T> :ProjectTodo<CR>
map <C-S-P> :ProjectProblems<CR>

" nerdtree shortcuts
nmap <leader>ne :NERDTree<CR>

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

