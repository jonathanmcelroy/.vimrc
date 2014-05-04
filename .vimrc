" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
" }

" Bundles {
" Vundle is short for "Vim Bundle" and is a Vim plugin manager
" To set up Vundle:
"   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" To install the plugins in this file:
"   Open vim
"   Execute ":BundleInstall

set nocompatible
filetype off

if has("user_commands")
    set rtp+=~/.vim/bundle/vundle
    runtime autoload/vundle.vim
endif
if exists("*vundle#rc()")
    call vundle#rc()

    " Vim package mangager
    Bundle 'gmarik/vundle'
    " Nice colors
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'jonathanfilip/vim-lucius'
    " File manager in vim
    Bundle 'scrooloose/nerdtree'
    " Awesome status bar
    Bundle 'bling/vim-airline'
    " Buffer manager and file search
    Bundle 'kien/ctrlp.vim'
    " Toggle Comments Easily
    Bundle 'scrooloose/nerdcommenter'
    " Python folding
    Bundle 'tmhedberg/SimpylFold'
    " Fancy start screen
    Bundle 'mhinz/vim-startify'
    " Smart Selection
    Bundle 'gcmt/wildfire.vim'
    if v:version >= 703
        " Auto completion
        Bundle 'Valloric/YouCompleteMe'
    else
        " Syntax Checker
        Bundle 'scrooloose/syntastic'
    endif
    " Moving around the screen
    Bundle 'Lokaltog/vim-easymotion'
    " Auto formating
    Bundle 'Chiel92/vim-autoformat'
endif
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

set undolevels=1000                 " Max number of changes to save
if has("persistant_undo")
    set undofile                        " Persistent undo
    set undodir=~/.vim/undo             " Where to place the undo files
    set undoreload=10000                " Max number of lines to save for undo on a buffer reload
endif

set backupdir=/tmp

"set autochdir                      " Change the terminal directory whenever I move buffers
autocmd BufEnter * silent! lcd %:p:h
set tabpagemax=10                   " Can open up to 10 tabs

"compilers {
"if executable("clang++")
"autocmd FileType cpp set makeprg=clang++\ %\ -g\ -I$HOME/.cppuseful/\ -o\ out\ -std=c++11\ -lGL\ -lGLU\ -lglut
"else
"autocmd FileType cpp set makeprg=g++\ %\ -g\ -I$HOME/.cppuseful/\ -o\ out\ -std=c++11
"endif
autocmd FileType cpp set makeprg=make\ -f\ $HOME/.cppuseful/makefile

autocmd FileType c set makeprg=make
if executable("clang")
    autocmd FileType c set makeprg=clang\ %\ -g\ -I$HOME/.cuseful\ -o\ out\ -std=c11
else
    autocmd FileType c set makeprg=gcc\ %\ -g\ -I$HOME/.cuseful\ -o\ out\ -std=c11
endi
" }

" }

" Vim UI {

" Set up the theme {
silent! colorscheme solarized
"silent! colorscheme lucius
" }

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

" Jump to next thing in the location list. This will be the next error from
" syntastic/youcompleteme
nnoremap <C-l> :lnext<CR>
nnoremap <C-h> :ll<CR>

" <F3>: compile current file to ./out
autocmd FileType cpp,c nnoremap <buffer> <F3> :make SOURCES=%<CR>
"autocmd FileType cpp,c nnoremap <buffer> <F3> :call MyMake(expand('%:p'))<CR>

" <F4>: compile all files in directory to ./out
autocmd FileType cpp,c nnoremap <buffer> <F4> :make<CR>
"autocmd FileType cpp,c nnoremap <buffer> <F4> :call MyMake("")<CR>

" <F5>: run precompiled file/script.
autocmd FileType cpp,c nnoremap <buffer> <F5> :!./out
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

" NerdTree {
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" }

" Syntastic {
"if executable("clang++")
"let g:syntastic_cpp_compiler = 'clang++'
""else
""let g:syntastic_cpp_compiler = 'g++'
""endif
""let g:syntastic_cpp_compiler_options = '-std=c++11 -I'.$HOME.'/.cppuseful/'
""let g:syntastic_cpp_check_header = 1

""if executable("clang")
""let g:syntastic_c_compiler = 'clang'
""else
""let g:syntastic_c_compiler = 'gcc'
""endi
""let g:syntastic_c_compiler_options = '-std=c11 -I'.$HOME.'/.cuseful/'
""let g:syntastic_c_check_header = 1

""let g:syntastic_always_populate_loc_list = 1
"" }

" Vim-Autoformat {

let g:formatprg_cpp = "astyle"
let g:formatprg_args_cpp = "--style=attach
            \ --pad-oper
            \ --indent-col1-comments
            \ --unpad-paren
            \ --align-pointer=type
            \ --align-reference=type
            \ --break-closing-brackets
            \ --convert-tabs 
            \ --suffix=none"
"\ --break-blocks

nnoremap <leader>f :Autoformat<CR><CR>
" }

" Vim-startify {
let g:startify_bookmarks = ['~/.vimrc', '~/.cppuseful']
let g:startify_files_number = 5
let g:startify_change_to_dir = 1
" }

" YouCompleteMe {
let g:ycm_global_ycm_extra_conf = '/home/jonathan/.cppuseful/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_show_diagnostics_ui = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_collect_identifiers_from_tags_files = 1
" }

" }

" My functions {

function MyMake(sources)
    echo a:sources
    if filereadable("makefile")
        make
    else
        echo "makefile doesn't exist"
        call CreateMakefile(fnamemodify(a:sources,":h"))
    endif
endfunction

function CreateMakefile(directory)
    let l:fileContents = ["CC        = clang++",
                \"CC_FLAGS  = -Wall -g -I $(HOME)/.cppuseful/ -std=c++11",
                \"CC_LINK   = -lGL -lGLU -lglut",
                \"EXEC		= out",
                \"ifndef SOURCES",
                \"ifndef SOURCES",
                \"SOURCES 	= $(wildcard *.cpp)",
                \"endif",
                \"OBJECTDIR   = objs",
                \"OBJECTS   	= $(addprefix $(OBJECTDIR)/, $(SOURCES:.cpp=.o))",
                \"",
                \"# Main target",
                \"all: $(EXEC)",
                \"",
                \"# all files",
                \"$(EXEC): $(OBJECTS)",
                \"	$(CC) $(OBJECTS) -o $(EXEC) $(CC_LINK)",
                \"",
                \"# To obtain object files",
                \"$(OBJECTDIR)/%.o: %.cpp",
                \"	$(CC) -c $(CC_FLAGS) $< -o $@",
                \"",
                \"# we need the directory before we can create the object files",
                \"$(OBJECTS): | $(OBJECTDIR)",
                \"",
                \"$(OBJECTDIR):",
                \"	mkdir $(OBJECTDIR)",
                \"",
                \"# To remove generated files",
                \"clean:",
                \"	rm -f $(EXEC) $(OBJECTS)"]
    call writefile(l:fileContents, a:directory."/makefile")
    "call append("$", "Hello World!")
endfunction

" }
