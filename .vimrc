"" vundle specific
filetype off " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
"  " required!
Bundle 'gmarik/vundle'

" Ruby on Rails power tools
Bundle 'tpope/vim-rails'
" Vim Cucumber runtime files
Bundle 'tpope/vim-cucumber'
" Vim runtime files for Haml, Sass, and SCSS
Bundle 'tpope/vim-haml'
" wisely add "end" in ruby, endfunction/endif/more in vim script
Bundle 'tpope/vim-endwise'
" quoting/parenthesizing made simple
Bundle 'tpope/vim-surround'
" pairs of handy bracket mappings
Bundle 'tpope/vim-unimpaired'
" easily search for, substitute, and abbreviate multiple variants of a word
Bundle 'tpope/vim-abolish'
" enable repeating supported plugin maps with "."
Bundle 'tpope/vim-repeat'
" Provides database access to many dbms (Oracle, Sybase, Microsoft, MySQL, DBI,..)
Bundle 'vim-scripts/dbext.vim'
" Lightweight support for Ruby's Bundler
Bundle 'tpope/vim-bundler'
" A tree explorer plugin for vim
Bundle 'scrooloose/nerdtree'
" plugin for intensely orgasmic commenting
Bundle 'scrooloose/nerdcommenter'
" neocomplcache complete snippets source
Bundle 'Shougo/neocomplcache-snippets-complete'
" Ultimate auto-completion system for Vim
Bundle 'Shougo/neocomplcache'

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
set tabstop=4       " tabs count as 4 spaces
set smarttab
set shiftwidth=4    " number of spaces to use in autoindent
set autoindent
set expandtab       " use spaces instead of tabs

"" ruby
au FileType ruby set tabstop=2 shiftwidth=2 expandtab

"" bash
au FileType bash set tabstop=2 shiftwidth=2 expandtab

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
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
