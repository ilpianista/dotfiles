"" vundle specific
set nocompatible   " be iMproved
filetype off       " required!

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

"" General plugins
" Some utility functions for VIM (needed by snipmate)
"Plug 'tomtom/tlib_vim'
" interpret a file by function and cache file automatically (needed by snipmate)
"Plug 'MarcWeber/vim-addon-mw-utils'
" a concise vim script that implements some of TextMate's snippets
"Plug 'garbas/vim-snipmate'
" vim-snipmate default snippets
"Plug 'honza/vim-snippets'
" A code-completion engine for Vim
Plug 'Valloric/YouCompleteMe'
" lean & mean status/tabline for vim that's light as air
Plug 'bling/vim-airline'
" provides insert mode auto-completion for quotes, parens, brackets, etc
Plug 'Raimondi/delimitMate'
" A tree explorer plugin for vim
"Plug 'scrooloose/nerdtree'
" plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter'
" Vim plugin to list, select and switch between buffers
Plug 'jeetsukumaran/vim-buffergator'
" Delete buffers and close files in Vim without closing your windows or messing up your layout
Plug 'moll/vim-bbye'
" Fuzzy file, buffer, mru, tag, etc finder
Plug 'kien/ctrlp.vim'
" helpers for UNIX
Plug 'tpope/vim-eunuch'
" a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
" A Vim plugin which shows a git diff in the gutter (sign column) and stages/reverts hunks.
Plug 'airblade/vim-gitgutter'
" Vim plugin that displays tags in a window, ordered by class etc.
Plug 'majutsushi/tagbar'
" Syntax checking hacks for vim
Plug 'scrooloose/syntastic'
" Automated tag file generation and syntax highlighting of tags in Vim
Plug 'xolox/vim-easytags'
" Miscellaneous auto-load Vim scripts (needed by vim-session)
Plug 'xolox/vim-misc'
" Extended session management for Vim
Plug 'xolox/vim-session'
" Vim plugin for the Perl module / CLI script 'ack'
Plug 'mileszs/ack.vim'

" Vim Markdown runtime files
Plug 'tpope/vim-markdown'

"" HTML/CSS
" emmet for vim
Plug 'mattn/emmet-vim'
" HTML5 omnicomplete and syntax
Plug 'othree/html5.vim'
" Highlight colors in css files" Highlight colors in css files
"Plug 'ap/vim-css-color'
" vim syntax for LESS (dynamic CSS)
Plug 'groenewege/vim-less'
" Vim syntax file for scss (Sassy CSS)
Plug 'cakebaker/scss-syntax.vim'

"" Rust
" Vim configuration for Rust
Plug 'rust-lang/rust.vim'

"" Haskell
" vim2hs :: Vim -> Haskell
"Plug 'dag/vim2hs'
" A completion plugin for Haskell, using ghc-mod
"Plug 'eagletmt/neco-ghc'
" Interactive command execution in Vim. (needed by ghcmod-vim)
"Plug 'Shougo/vimproc.vim'
" Happy Haskell programming on Vim, powered by ghc-mod
"Plug 'eagletmt/ghcmod-vim'
" Create ctags compatible tags files for Haskell programs
"Plug 'bitc/lushtags'

" PHP
" Up-to-date PHP syntax file (5.3 – 7.1 support)
"Plug 'StanAngeloff/php.vim'

" PowerShell
" A Vim plugin for Windows PowerShell support
Plug 'PProvost/vim-ps1'

"" Ruby
" Vim/Ruby Configuration Files
Plug 'vim-ruby/vim-ruby'
" wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
Plug 'tpope/vim-endwise'
" Vim runtime files for Haml, Sass, and SCSS
Plug 'tpope/vim-haml'
" Ruby on Rails power tools
Plug 'tpope/vim-rails'
" Run Rspec specs from Vim
Plug 'thoughtbot/vim-rspec'

"" JavaScript
" Vastly improved Javascript indentation and syntax support in Vim
Plug 'pangloss/vim-javascript'
" Syntax for JavaScript libraries
Plug 'othree/javascript-libraries-syntax.vim'
" Tern plugin for Vim
Plug 'ternjs/tern_for_vim'
" vim plugin which formated javascript files by js-beautify
Plug 'maksimr/vim-jsbeautify'
" CoffeeScript support for vim
Plug 'kchmck/vim-coffee-script'
" Typescript syntax files for Vim
Plug 'leafgarland/typescript-vim'

" Vim plugin for the Elm programming language
"Plug 'lambdatoast/elm.vim'

"" Qt
" QML syntax highlighting for VIM
Plug 'peterhoeg/vim-qml'
" qmake project highlighting support for the Vim editor
Plug 'artoj/qmake-syntax-vim'

" Vim syntax file & snippets for Docker's Dockerfile
Plug 'ekalinin/Dockerfile.vim'

" basic vim/vagrant integration
Plug 'markcornick/vim-vagrant'

" A vim plugin for syntax highlighting Ansible's common filetypes
Plug 'pearofducks/ansible-vim'

" Vim syntax for i3 window manager config
Plug 'PotatoesMaster/i3-vim-syntax'

"" color schemes
" Base16 for Vim
Plug 'chriskempson/base16-vim'

call plug#end()

" Load KDE settings
source /home/andrea/projects/KDE/kde-dev-scripts/kde-devel-vim.vim

"" general stuff
set encoding=utf-8 " necessary to show unicode glyphs
set showcmd        " display incomplete commands
"set number         " turn line numbering on
set relativenumber " turn relative numbering on
"set cursorline     " highlight the cursor line
"set cursorcolumn   " highlight the cursor column
set colorcolumn=80 " show 80th column
set history=50     " keep 50 lines of command line history
set ruler          " show the cursor position all the time
set laststatus=2   " always show the status line
filetype plugin indent on " turn on filetype detection, filetype plugins, and autoindent

"" color stuffs
syntax on           " turn syntax highlighting on
set background=dark
let base16colorspace=256   " workaround needed with some 256 colors terminal
colorscheme base16-default-dark " because we prefer a non default colorscheme
highlight Pmenu guibg=brown gui=bold

"" whitespace
set nowrap          " lines longer than the width of the window will not wrap
set tabstop=2       " tabs count as 4 spaces
set softtabstop=2   " tabs count as 4 spaces in insert mode
set shiftwidth=2    " number of spaces to use in autoindent
set expandtab       " use spaces instead of tabs
"set list            " show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

set autoindent      " copy indent from current line when starting a new line

set hlsearch        " highlight all matches in the previous search
set incsearch       " incremental searching
set ignorecase      " searches are case insensitive...
set smartcase       " ... unless they contain at least one capital letter

"set modelines=0     " https://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html
set lazyredraw      " redraw only when needed, means faster macros

set wildmode=full
set wildmenu        " command-line completion operates in an enhanced mode
set completeopt=longest,menuone " completion popup menu work just like in an IDE

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.so
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.jar,*.war
" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Disable temp and backup files
set wildignore+=*.swp,*~,._*

"" Backup and swap files
set backupdir^=~/.vim/_backup/    " where to put backup files.
set directory^=~/.vim/_temp/      " where to put swap files.

let mapleader=","

" exclude files and directories from CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](node_modules|build|vendor|dist)$',
  \ }

" use patched powerline fonts
let g:airline_powerline_fonts = 1
" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" This does what it says on the tin. It will check your file on open too, not just on save.
let g:syntastic_check_on_open = 0
let g:syntastic_javascript_checkers = ['jshint']

" Path to Rust source files
let g:ycm_rust_src_path = "/usr/src/rust/src"

nnoremap K :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Enable emmet just for HTML/CSS
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" vim-session
let g:session_autoload = 'no'
let g:session_autosave = 'no'

" automatically start NERDTree when vim starts up with no files specified
"autocmd vimenter * if !argc() | NERDTree | endif

" Buffergator
nmap <F7> :BuffergatorToggle<CR>

" TagBar
nmap <F8> :TagbarToggle<CR>

" NERDTree
"nmap <F9> :NERDTreeToggle<CR>

" Tern
"let g:tern#command = ['tern', '--no-port-file']
"let g:tern_show_argument_hints = "on_hold"
"set updatetime=1000
"nnoremap K :TernDoc<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Hide serach results
nnoremap <F3> :set hlsearch!<CR>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" highlight trailing spaces
match Error /\s\+$/

" pgsql syntax highlight
"au BufNewFile,BufRead *.pgsql setf pgsql
"au BufNewFile,BufRead *.plpgsql setf pgsql

" Reformat XML file
"au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"

" Automatically removing all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Enable automatic running of :RustFmt
let g:rustfmt_autosave = 1

" check file change every 4 seconds ('CursorHold') and reload the buffer upon detecting change
set autoread
au CursorHold * checktime

" ghc-mod Reload
"map <silent> tu :call GHC_BrowseAll()<CR>
" ghc-moc Type Lookup
"map <silent> tw :call GHC_ShowType(1)<CR>

" CTags
set tags=./tags;/,/usr/src/rust/src/tags
let g:easytags_dynamic_files = 1
let g:easytags_events = ['CursorHold', 'CursorHoldI']

"autocmd BufWrite *.rs :silent exec "!rusty-tags vi --start-dir=" . expand('%:p:h') . "&"

let g:tagbar_type_ansible = {
    \ 'ctagstype' : 'ansible',
    \ 'kinds' : [
        \ 't:tasks'
    \ ],
    \ 'sort' : 0
\ }

let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \ 'T:types,type definitions',
        \ 'f:functions,function definitions',
        \ 'g:enum,enumeration names',
        \ 's:structure names',
        \ 'm:modules,module names',
        \ 'c:consts,static constants',
        \ 't:traits,traits',
        \ 'i:impls,trait implementations',
    \ ]
\ }

let g:easytags_languages = {
    \ 'javascript': {
      \ 'cmd': 'jsctags',
      \ 'args': ['-f']
    \ }
\ }

" Use ag instead of ack
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

let g:used_javascript_libs = 'angularjs'
