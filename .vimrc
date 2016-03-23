" Modeline and Notes {{{
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
" }}}

" Plugins Init {{{

" Plug is a Vim plugin manager
" To install Plug:
"   mkdir -p ~/.vim/autoload
"   curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" To install the plugins in this file:
"   Open vim or nvim
"   Execute :PlugInstall

let s:plugins=filereadable(expand("~/.vim/autoload/plug.vim", 1))

if !s:plugins "{{{
    function! InstallPlug() "bootstrap plug.vim on new systems
        silent call mkdir(expand("~/.vim/autoload", 1), 'p')
        exe '!curl -fLo '.expand("~/.vim/autoload/plug.vim", 1).' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        " Line 889 is a bug. Replace with "if 1"
    endfunction
    "}}}
else "{{{
    call plug#begin('~/.vim/plugged')

    " UI {{{

    " Nice colors
    Plug 'altercation/vim-colors-solarized'
    Plug 'jonathanfilip/vim-lucius'
    Plug 'junegunn/seoul256.vim'
    Plug 'john2x/flatui.vim'

    " Fancy start screen
    Plug 'mhinz/vim-startify'

    " Awesome status bar
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " }}}

    " Files {{{

    " File manager in vim
    Plug 'scrooloose/nerdtree'

    " Buffer manager and file search
    Plug 'kien/ctrlp.vim'

    " }}}

    " General Code {{{

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Syntax Checker
    Plug 'scrooloose/syntastic'

    " Moving around the screen
    Plug 'Lokaltog/vim-easymotion'

    " Auto formating
    Plug 'Chiel92/vim-autoformat'

    " Smart Selection
    Plug 'gcmt/wildfire.vim'

    " Snippets
    "Plug 'msanders/snipmate.vim'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " Toggle Comments Easily
    Plug 'scrooloose/nerdcommenter'

    " Edit surrounding things
    Plug 'tpope/vim-surround'

    " Show tags in a window
    "Plug 'majutsushi/tagbar'

    " Code completion
    "Plug 'Valloric/YouCompleteMe'

    " Code searching
    Plug 'mileszs/ack.vim'

    " Undo Tree
    Plug 'sjl/gundo.vim'

    " Align text
    Plug 'godlygeek/tabular'

    " Latex
    "Plug 'vim-latex/vim-latex', { 'for' : 'tex' }

    " }}}

    " Languages {{{

    " Haskell syntax checking
    Plug 'bitc/vim-hdevtools', { 'for' : 'haskell' }
    
    " Javascript syntax checking
    Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }

    " Rust syntax checking
    Plug 'rust-lang/rust.vim'

    " }}}

    " Close surrounding things automagically
    Plug 'docunext/closetag.vim', { 'for' : 'html' }

    "Mine :)
    Plug '~/Documents/neovimGTK'

    call plug#end()
endif
" }}}

" }}}

" General {{{

set background=dark                 " Dark background
filetype plugin indent on           " Automatically detect file types
syntax on                           " Syntax highlighting
scriptencoding utf-8

set virtualedit=onemore             " Allows the cursor beyond the last character
set history=1000                    " A lot of history

set hidden                          " Allow buffer switching without saving

set backspace=indent,eol,start      " Backspace should work like a text editor

set undolevels=1000                 " Max number of changes to save
if has("persistant_undo")
    set undofile                    " Persistent undo
    set undodir=~/.vim/undo         " Where to place the undo files
    set undoreload=10000            " Max number of lines to save for undo on a buffer reload
endif

set backupdir=/tmp

"set autochdir                      " Change the terminal directory whenever I move buffers
"autocmd BufEnter * silent! lcd %:p:h

set shell=/bin/bash

"compilers {{{
autocmd FileType cpp set makeprg=make\ -f\ $HOME/.cppuseful/makefile
autocmd FileType c set makeprg=make\ -f\ $HOME/.cuseful/makefile
autocmd FileType haskell set makeprg=ghc\ --make
autocmd FileType java set makeprg=javac
" }}}

" }}}

" Vim UI {{{

" Set up the theme {{{
"silent! colorscheme solarized
"silent! colorscheme lucius
silent! colorscheme seoul256
" }}}

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

"if has("colorcolumn")
"set colorcolumn=81                  " highlight everything past the 80th column
"endif
set foldmethod=syntax               " fold by syntax

" }}}

" Formating {{{

set autoindent                      " indent at the same level as the previous line
set shiftwidth=4                    " the number of spaces for auto indent
set expandtab                       " new tabs are spaces
set tabstop=4                       " the number of columns when tab is pressed
set softtabstop=4                   " Let backspace delete indent

set splitright                      " new vsplits are to the right
set splitbelow                      " new hsplits are below

set pastetoggle=<F12>               " Sane insertion

" Folding for java
syn region foldJavadoc start=,/\*\*, end=,\*/, transparent fold keepend

" }}}

" Key (re)Mappings {{{

" change the leader key
let mapleader = ","

" Shift key fixes {{{
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang Qa qa<bang>
command! -bang QA qa<bang>
" }}}

" toggle search highlighting
nnoremap <silent> <leader>/ :set invhlsearch<CR>

" Exit insert mode
inoremap jk <Esc>
inoremap kj <Esc>

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
"autocmd FileType java nnoremap <buffer> <F3> :make %<CR>
autocmd FileType markdown nnoremap <buffer> <F3> :!pandoc -o "%:p:r".pdf %<CR>
autocmd FileType tex nnoremap <buffer> <F3> :!pdflatex %<CR>

" <F4>: compile all files in directory to ./out
autocmd FileType cpp,c nnoremap <buffer> <F4> :make<CR>
autocmd FileType haskell nnoremap <buffer> <F4> :!ghc --make % -odir obj -hidir obj -o out<CR>

" <F5>: run precompiled file/script.
autocmd FileType cpp,c,haskell nnoremap <buffer> <F5> :!./out
"autocmd FileType java nnoremap <buffer> <F5> :!java %:t:r<CR>
autocmd FileType python nnoremap <buffer> <F5> :!python %<CR>
autocmd FileType sh nnoremap <buffer> <F5> :!bash %<CR>

" <F6>: run the precompiled file in memory checking mode
autocmd FileType cpp,c nnoremap <buffer> <F6> :!valgrind --tool=memcheck ./out
autocmd FileType python nnoremap <buffer> <F6> :!python %<CR>
autocmd FileType sh nnoremap <buffer> <F6> :!bash %<CR>

" }}}

" Plugins {{{

" Airline {{{
"let g:airline_theme = 'solarized'
let g:airline_theme = 'luna'
"let g:airline_theme = 'sol'
let g:airline#extensions#tabline#enabled = 1
" }}}

" Ack {{{
let g:ackprg = 'ag --nogroup --nocolor --column'
" }}}

" Ctags {{{
" Run ctags in current directory
"nnoremap <C-F12> :!ctags -R .<CR>:echo "Tagged all files in the project"<CR>
nnoremap <leader>tag :!ctags . -R<CR>
nnoremap <C-\> :vsplit<CR>:exec("tag ".expand("<cword>"))<CR>
" }}}

" Ctrl-p {{{
" }}}

" Eclim {{{
autocmd FileType java nnoremap <buffer> <leader>3 :JavaCorrect<CR>
" }}}

" Git Gutter {{{
"call GitGutterEnable()
" }}}

" NerdTree {{{
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" }}}

" Syntastic {{{

" C++
if executable("clang++")
    let g:syntastic_cpp_compiler = 'clang++'
else
    let g:syntastic_cpp_compiler = 'g++'
endif
let g:syntastic_cpp_compiler_options = '-Wall -pedantic -std=c++11 -I'.$HOME.'/.cppuseful/'
let g:syntastic_cpp_check_header = 1

" C
if executable("clang")
    let g:syntastic_c_compiler = 'clang'
else
    let g:syntastic_c_compiler = 'gcc'
endi
let g:syntastic_c_compiler_options = '-Wall -pedantic -std=c99 -I'.$HOME.'/.cuseful/'
let g:syntastic_c_check_header = 1

" Haskell
let g:syntastic_haskell_hdevtools_args = '-g -Wall -g --make'

" Java
let g:syntastic_java_javac_classpath = 'src'

" Everything
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_balloons = 1
let g:syntastic_auto_jump = 1
let g:syntastic_mode_map = { "mode": "passive" }

command Ww w <BAR> SyntasticCheck
command WW Ww

"" }}}

" Tagbar {{{
let g:tagbar_type_haskell = {
            \ 'ctagsbin'  : 'hasktags',
            \ 'ctagsargs' : '-x -c -o-',
            \ 'kinds'     : [
            \  'm:modules:0:1',
            \  'd:data: 0:1',
            \  'd_gadt: data gadt:0:1',
            \  't:type names:0:1',
            \  'nt:new types:0:1',
            \  'c:classes:0:1',
            \  'cons:constructors:1:1',
            \  'c_gadt:constructor gadt:1:1',
            \  'c_a:constructor accessors:1:1',
            \  'ft:function types:1:1',
            \  'fi:function implementations:0:1',
            \  'o:others:0:1'
            \ ],
            \ 'sro'        : '.',
            \ 'kind2scope' : {
            \ 'm' : 'module',
            \ 'c' : 'class',
            \ 'd' : 'data',
            \ 't' : 'type'
            \ },
            \ 'scope2kind' : {
            \ 'module' : 'm',
            \ 'class'  : 'c',
            \ 'data'   : 'd',
            \ 'type'   : 't'
            \ }
            \ }
" }}}

" Ultisnips {{{
let g:UltiSnipsExpandTrigger = "<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-a>"
let g:UltiSnipsJumpBackwardTrigger="<c-s>"
" }}}

" Vim-Autoformat {{{

let g:formatprg_cpp = "astyle"
let g:formatprg_args_cpp = "--style=java --pad-oper --indent-col1-comments --unpad-paren --align-pointer=type --break-closing-brackets --convert-tabs --suffix=none"
"\ --break-blocks
"
let g:formatprg_c = "astyle"
let g:formatprg_args_c = "--style=java --pad-oper --indent-col1-comments --unpad-paren --align-pointer=type --break-closing-brackets --convert-tabs --suffix=none"

let g:formatprg_java = "astyle"
let g:formatprg_args_java = "--style=java --pad-oper --indent-col1-comments --unpad-paren --align-pointer=type --break-closing-brackets --convert-tabs --suffix=none"

nnoremap <leader>f :Autoformat<CR><CR>
" }}}

" Vim-Hdevtools {{{
au FileType haskell nnoremap <buffer> gt :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> gc :HdevtoolsClear<CR>
" }}}

" Vim-startify {{{
let g:startify_bookmarks = ['~/.vimrc', '~/.cppuseful']
let g:startify_files_number = 5
let g:startify_change_to_dir = 1
" }}}

" YouCompleteMe {{{
let g:ycm_register_as_syntastic_checker = 1

"YCM will put icons in Vim's gutter on lines that have a diagnostic set.
"Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1 "default 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_collect_identifiers_from_tags_files = 1 "default 0
let g:ycm_path_to_python_interpreter = '' "default ''

let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info

let g:ycm_global_ycm_extra_conf = $HOME.'/.cppuseful/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 1

let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }
"let g:ycm_key_invoke_completion = '<C-Space>'

"let g:ycm_add_preview_to_completeopt = 1
" }}}

" }}}

"Functions {{{

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

" }}}
