"" vundle specific
set nocompatible   " be iMproved
filetype off       " required!

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'dense-analysis/ale'

" A tree explorer plugin for vim
Plug 'preservim/nerdtree'
" fzf loves vim
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" A solid language pack for Vim
Plug 'sheerun/vim-polyglot'
" commentary.vim: comment stuff out
Plug 'tpope/vim-commentary'
" quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/reverts hunks.
Plug 'airblade/vim-gitgutter'

" Vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar'

"" Python
" A nicer Python indentation style for vim
"Plug 'Vimjas/vim-python-pep8-indent'

"" Rust
" Vim configuration for Rust
Plug 'rust-lang/rust.vim'

"" Go
" Go development plugin for Vim
Plug 'fatih/vim-go'

"" Ruby
" Vim/Ruby Configuration Files
"Plug 'vim-ruby/vim-ruby'
" wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
"Plug 'tpope/vim-endwise'
" Vim runtime files for Haml, Sass, and SCSS
"Plug 'tpope/vim-haml'
" Ruby on Rails power tools
"Plug 'tpope/vim-rails'
" Run Rspec specs from Vim
"Plug 'thoughtbot/vim-rspec'

" basic vim/vagrant integration
Plug 'markcornick/vim-vagrant'

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
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
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
set directory^=~/.vim/_temp/      " where to put swap files.

let mapleader=","

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
"set showmode

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Toggle Tagbar
nmap <F8> :TagbarToggle<CR>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" use patched powerline fonts
let g:airline_powerline_fonts = 1
" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" automatically format and also rewrite your import declarations
let g:go_fmt_command = "goimports"

" Allow vim-terraform to automatically format *.tf and *.tfvars files
let g:terraform_fmt_on_save=1

" make it easier to jump between errors in quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>r  <Plug>(go-run)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" Disable location list
let g:go_list_type = "quickfix"

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
"let g:rustfmt_autosave = 1

" check file change every 4 seconds ('CursorHold') and reload the buffer upon detecting change
set autoread
au CursorHold * checktime

" ghc-mod Reload
"map <silent> tu :call GHC_BrowseAll()<CR>
" ghc-moc Type Lookup
"map <silent> tw :call GHC_ShowType(1)<CR>

let g:tagbar_type_ansible = {
	\ 'ctagstype' : 'ansible',
	\ 'kinds' : [
		\ 't:tasks'
	\ ],
	\ 'sort' : 0
\ }

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
\ }

let g:rust_use_custom_ctags_defs = 1  " if using rust.vim
let g:tagbar_type_rust = {
  \ 'ctagsbin' : '/usr/bin/ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }

" Disable conflicts with YouCompleteMe
let g:go_code_completion_enabled = 0
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Create missing directories on save
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
