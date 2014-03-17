" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" }

" Bundles {
    set nocompatible
    filetype off

    set rtp+=~/.vim/bundle/vundle
    call vundle#rc()

    " Vim package mangager
    Bundle 'gmarik/vundle'
    " Nice colors
    Bundle 'altercation/vim-colors-solarized'
    " File manager in vim
    Bundle 'scrooloose/nerdtree'
    " Awesome status bar
    Bundle 'bling/vim-airline'
    " Buffer manager and file search
    Bundle 'kien/ctrlp.vim'
    " Syntax Checker
    Bundle 'scrooloose/syntastic'
    " Toggle Comments Easily
    Bundle 'scrooloose/nerdcommenter'
    " Python folding
    Bundle 'tmhedberg/SimpylFold'
    " Fancy start screen
    Bundle 'mhinz/vim-startify'
" }

" General {

set background=dark                 " Dark background
filetype plugin indent on           " Automatically detect file types
syntax on                           " Syntax highlighting
scriptencoding utf-8

set virtualedit=onemore             " Allows the cursor beyond the last character
set history=1000                    " A lot of history

set spell spelllang=en_us           " spelling check
set hidden                          " Allow buffer switching without saving

set undofile                        " Persistent undo
set undolevels=1000                 " Max number of changes to save
set undoreload=10000                " Max number of lines to save for undo on a buffer reload

set autochdir                       " Change the terminal directory whenever I open a file

" }

" Vim UI {

" Set up the solaraized theme {
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
colorscheme solarized
" }

set laststatus=2                    " always see the status line

set number                          " line numbers
set showmatch                       " Show matching brackets/parentheses
set incsearch                       " incremental searching
set hlsearch                        " highlight search
set ignorecase                      " Lowercase matches both lower and upper
set smartcase                       " Uppercase only matches upper
set wildmenu                        " Auto completion menu for commands
set wildmode=list:longest,full      " List matches, then longest common part, then all

set colorcolumn=81                  " highlight everything past the 80th column
set foldmethod=syntax               " fold by syntax

" }

" Formating {

set autoindent                      " indent at the same level as the previous line
set shiftwidth=4                    " the number of spaces for auto indent
set expandtab                       " new tabs are spaces
set tabstop=4                       " the number of columns when tab is pressed
set softtabstop=4                   " Let backspace delete indent

set splitright                      " new vsplits are to the right
set splitbelow                      " new hsplits are below

set pastetoggle=<F12>               " Sane insertion

set complete+=kspell                " auto complete in comments

" }

" Key (re)Mappings {

" Shift key fixes {
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>
command! -bang QA qa<bang>
" }

" toggle search highlighting
nnoremap <silent> <leader>/ :set invhlsearch<CR>

" Visual shifting
vnoremap < <gv
vnoremap > >gv

" Switch between buffers
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprev<CR>

" Space toggles folds
nnoremap <space> za

" Move by row, not line
nnoremap j gj
nnoremap k gk

" <F4>: compile current file to ./out
autocmd FileType cpp nnoremap <buffer> <F4> :!clang++ % -g -I /home/jonathan/.cppuseful/ -o out -std=c++11<CR>
autocmd FileType c nnoremap <buffer> <F4> :!clang % -g -o -out -std=c11<CR>
" <F5>: run precompiled file/script.
autocmd FileType cpp,c nnoremap <buffer> <F5> :!./out
autocmd FileType python nnoremap <buffer> <F5> :!python %<CR>
" <F6>: run the precompiled file in memory checking mode
autocmd FileType cpp,c nnoremap <buffer> <F6> :!valgrind --tool=memcheck ./out 
autocmd FileType python nnoremap <buffer> <F6> :!python %<CR>

" }

"Plugins {

" Airline {
    let g:airline_theme = 'powerlineish'
    let g:airline#extensions#tabline#enabled = 1
    "let g:airline#extensions#tabline#left_sep = ' '
    "let g:airline#extensions#tabline#left_alt_sep = '>'
" }

" Ctags {
    " Run ctags in current directory
    nnoremap <C-F12> :!ctags -R .<CR>:echo "Tagged all files in the project"<CR>
    nnoremap <C-\> :vsplit<CR>:exec("tag ".expand("<cword>"))<CR>
" }

" NerdTree {
    map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" }

" Syntastic {
    let g:syntastic_cpp_compiler = 'clang++'
    let g:syntastic_cpp_compiler_options = ' -std=c++11 -I /home/jonathan/.cppuseful/'
" }

" }
