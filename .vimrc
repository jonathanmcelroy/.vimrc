" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
" }

" Bundles {
" Vundle is short for "Vim Bundle" and is a Vim plugin manager
" To set up Vundle:
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" To install the plugins in this file:
"   Open vim
"   Execute ":PluginInstall

filetype off

if has("user_commands")
    set rtp+=~/.nvim/bundle/vundle
    runtime autoload/vundle.vim
endif
if exists("*vundle#begin()")
    call vundle#begin()

    " Vim package mangager
    Plugin 'gmarik/vundle'

    " Nice colors
    Plugin 'altercation/vim-colors-solarized'
    "Plugin 'jonathanfilip/vim-lucius'

    " File manager in vim
    Plugin 'scrooloose/nerdtree'

    " Awesome status bar
    Plugin 'bling/vim-airline'

    " Buffer manager and file search
    Plugin 'kien/ctrlp.vim'

    " Toggle Comments Easily
    Plugin 'scrooloose/nerdcommenter'

    " Fancy start screen
    Plugin 'mhinz/vim-startify'

    " Smart Selection
    Plugin 'gcmt/wildfire.vim'

    " Syntax Checker
    Plugin 'scrooloose/syntastic'

    " Moving around the screen
    Plugin 'Lokaltog/vim-easymotion'

    " Auto formating
    if v:version >= 703
        Plugin 'Chiel92/vim-autoformat'
    endif

    " Haskell
    Plugin 'bitc/vim-hdevtools'

    " Edit surrounding things
    Plugin 'tpope/vim-surround'

    call vundle#end()
endif
" }

" General {

set background=dark                 " Dark background
filetype plugin indent on           " Automatically detect file types
syntax on                           " Syntax highlighting
scriptencoding utf-8

set virtualedit=onemore             " Allows the cursor beyond the last character
set history=1000                    " A lot of history

set hidden                          " Allow buffer switching without saving

set undolevels=1000                 " Max number of changes to save
if has("persistant_undo")
    set undofile                        " Persistent undo
    set undodir=~/.vim/undo             " Where to place the undo files
    set undoreload=10000                " Max number of lines to save for undo on a buffer reload
endif

set backupdir=/tmp

"set autochdir                      " Change the terminal directory whenever I move buffers
autocmd BufEnter * silent! lcd %:p:h

"compilers {
autocmd FileType cpp set makeprg=make\ -f\ $HOME/.cppuseful/makefile
autocmd FileType c set makeprg=make\ -f\ $HOME/.cuseful/makefile
autocmd FileType haskell set makeprg=ghc\ --make
autocmd FileType java set makeprg=javac
" }

" }

" Vim UI {

" Set up the theme {
silent! colorscheme solarized
"silent! colorscheme lucius
" }

set t_Co=256                        " The terminal uses 256 colors

set laststatus=2                    " always see the status line

"set number                          " line numbers
set showmatch                       " Show matching brackets/parentheses
set incsearch                       " incremental searching
set hlsearch                        " highlight search
set ignorecase                      " Lowercase matches both lower and upper
set smartcase                       " Uppercase only matches upper
set wildmenu                        " Auto completion menu for commands
set wildmode=list:longest,full      " List matches, then longest common part, then all

if has("colorcolumn")
    set colorcolumn=81                  " highlight everything past the 80th column
endif
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

" }

" Key (re)Mappings {

" change the leader key
let mapleader = ","

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

" Make Y do the same as D, but for yanking
nnoremap Y y$

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

" Jump to next thing in the location list. This will be the next error from
" syntastic/youcompleteme
nnoremap <C-l> :lnext<CR>
nnoremap <C-h> :ll<CR>

" <F3>: compile current file to ./out
autocmd FileType haskell nnoremap <buffer> <F3> :!ghc --make % -odir obj -hidir obj -o out<CR>
autocmd FileType cpp,c nnoremap <buffer> <F3> :make SOURCES=%<CR>
autocmd FileType cpp,c nnoremap <buffer> <leader>t :call ToggleCpp11()<CR>
autocmd FileType java nnoremap <buffer> <F3> :make %<CR>
autocmd FileType markdown nnoremap <buffer> <F3> :!pandoc -o "%:p:r".pdf %<CR>
autocmd FileType tex nnoremap <buffer> <F3> :!pdflatex %<CR>

" <F4>: compile all files in directory to ./out
autocmd FileType cpp,c,haskell nnoremap <buffer> <F4> :make<CR>

" <F5>: run precompiled file/script.
autocmd FileType cpp,c,haskell nnoremap <buffer> <F5> :!./out
autocmd FileType java nnoremap <buffer> <F5> :!java %:t:r<CR>
autocmd FileType python nnoremap <buffer> <F5> :!python %<CR>
autocmd FileType sh nnoremap <buffer> <F5> :!bash %<CR>

" <F6>: run the precompiled file in memory checking mode
autocmd FileType cpp,c nnoremap <buffer> <F6> :!valgrind --tool=memcheck ./out
autocmd FileType python nnoremap <buffer> <F6> :!python %<CR>
autocmd FileType sh nnoremap <buffer> <F6> :!bash %<CR>

" }

"Plugins {

" Airline {
"let g:airline_theme = 'solarized'
let g:airline_theme = 'luna'
"let g:airline_theme = 'sol'
let g:airline#extensions#tabline#enabled = 1
" }

" Ctags {
" Run ctags in current directory
nnoremap <C-F12> :!ctags -R .<CR>:echo "Tagged all files in the project"<CR>
nnoremap <C-\> :vsplit<CR>:exec("tag ".expand("<cword>"))<CR>
" }

" Ctrl-p {
" }

" Eclim {
autocmd FileType java nnoremap <buffer> <leader>3 :JavaCorrect<CR>
" }

" NerdTree {
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" }

" Syntastic {
if executable("clang++")
    let g:syntastic_cpp_compiler = 'clang++'
else
    let g:syntastic_cpp_compiler = 'g++'
endif
let g:syntastic_cpp_compiler_options = '-Wall -pedantic -std=c++11 -I'.$HOME.'/.cppuseful/'
let g:syntastic_cpp_check_header = 1

if executable("clang")
    let g:syntastic_c_compiler = 'clang'
else
    let g:syntastic_c_compiler = 'gcc'
endi
let g:syntastic_c_compiler_options = '-Wall -pedantic -std=c11 -I'.$HOME.'/.cuseful/'
let g:syntastic_c_check_header = 1

let g:syntastic_haskell_hdevtools_args = '-g -Wall --make'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_jump = 1
let g:syntastic_mode_map = { "mode": "passive" }

command Ww w <BAR> SyntasticCheck
command WW Ww
"" }

" Vim-Autoformat {

let g:formatprg_cpp = "astyle"
let g:formatprg_args_cpp = "--style=java --pad-oper --indent-col1-comments --unpad-paren --align-pointer=type --break-closing-brackets --convert-tabs --suffix=none"
"\ --break-blocks
"
let g:formatprg_c = "astyle"
let g:formatprg_args_c = "--style=java --pad-oper --indent-col1-comments --unpad-paren --align-pointer=type --break-closing-brackets --convert-tabs --suffix=none"

let g:formatprg_java = "astyle"
let g:formatprg_args_java = "--style=java --pad-oper --indent-col1-comments --unpad-paren --align-pointer=type --break-closing-brackets --convert-tabs --suffix=none"

nnoremap <leader>f :Autoformat<CR><CR>
" }

" Vim-Hdevtools {
au FileType haskell nnoremap <buffer> gt :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> gc :HdevtoolsClear<CR>
" }

" Vim-startify {
let g:startify_bookmarks = ['~/.nvimrc', '~/.vimrc', '~/.cppuseful']
let g:startify_files_number = 5
let g:startify_change_to_dir = 1
" }

" YouCompleteMe {
"let g:ycm_global_ycm_extra_conf = '/home/jonathan/.cppuseful/.ycm_extra_conf.py'
"let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_show_diagnostics_ui = 1
"let g:ycm_always_populate_location_list = 1
"let g:ycm_collect_identifiers_from_tags_files = 1
" }

" }

"Functions {

function EasyToCpp11()
    " I don't like using parens around control statments

    " If
    %substitute/\(\<if\>\s*(.*)\s*{\)\@!\<if\>\s*\(.\{-}\)\s*{/if(\2) {/gce
    %substitute/\(\<while\>\s*(.*)\s*{\)\@!\<while\>\s*\(.\{-}\)\s*{/while(\2) {/gce
endfunction

function ForEachToFor()
    %substitute/\<for\>\s*(\s*\(\w\+\)\s*\(\w\+\)\s*:\s*\(\w\+\)\s*)\s*{/for(\1 \2 = \3.begin(); \2 != \3.end(); \2++) {/gce
endfunction

let cpp11 = 1
function! ToggleCpp11()
    if g:cpp11
        nnoremap <buffer> <F3> :make SOURCES=% CPP11=<CR>
        nnoremap <buffer> <F4> :make CPP11=<CR>
        let g:syntastic_cpp_compiler_options = '-Wall -pedantic -I'.$HOME.'/.cppuseful/'
        let g:syntastic_c_compiler_options = '-Wall -pedantic -std=c99 -I'.$HOME.'/.cuseful/'
        let g:cpp11 = 0
    else
        nnoremap <buffer> <F3> :make SOURCES=%<CR>
        nnoremap <buffer> <F4> :make<CR>
        let g:syntastic_cpp_compiler_options = '-Wall -pedantic -std=c++11 -I'.$HOME.'/.cppuseful/'
        let g:syntastic_c_compiler_options = '-Wall -pedantic -std=c11 -I'.$HOME.'/.cuseful/'
        let g:cpp11 = 1
    endif
endfunction

"}
