set nocompatible

source ~/.vim/functions.vim

filetype plugin on
filetype indent on
syntax on

set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set incsearch
set showmatch
set hlsearch
set paste
set number
set backup
set backupdir=~/.vim/backup

set textwidth=80
set wrap

set viminfo='10,\"100,:20,%,n~/.viminfo

set mouse-=a

colorscheme dante

set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/qt

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

set completeopt=menuone,menu,longest,preview

:inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
:inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
au BufNewFile,BufRead,BufEnter *.java set omnifunc=javacomplete#CompleteParamsInfo
