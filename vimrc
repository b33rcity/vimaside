set nocompatible              " required
filetype off                  " required
set encoding=utf-8
set nu			      "Turns on line numbering

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"" nvim compatibility layer (needed for deoplete)
Plugin 'roxma/nvim-yarp'
Plugin 'roxma/vim-hug-neovim-rpc'

"" Interface plugins
""" Aesthetics and status lines
Plugin 'flazz/vim-colorschemes'
Plugin 'jnurmine/Zenburn'

""" IDE-like plugins
"""" Linting
Plugin 'w0rp/ale'

"""" Project browsing
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'

"""" Completion
Plugin 'Shougo/deoplete.nvim'

""" Python-oriented plugins (to-do: set up some conditional logic to load these
""" only in .py files or files with a python shebang?)
    " Python-specific linting. 
Plugin 'nvie/vim-flake8'
    " PEP8-compliant indenting (can probably get that with native vim stuff)
Plugin 'vim-scripts/indentpython.vim'
    " Autocompletion binding used by Deoplete
Plugin 'davidhalter/jedi-vim'

""" C oriented plugins
Plugin 'zchee/deoplete-clang'
    " Completion candidates from C header files
Plugin 'Shougo/neoinclude.vim'

"" Misc
"Plugin 'tmhedberg/SimplyFold'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Global Options
syntax on
set showcmd
"" Tab behavior
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
"" Ostensibly this speeds up Deoplete load time by 20ms
let g:python3_host_prog = '/usr/bin/python3'
"" Compile C programs with F5 (must set makeprg first--au cmds at bottom
"" handle this for .py and .c files only)
nnoremap <F5> :w<CR> :make<CR>
au QuickFixCmdPost :make :cw<CR>

" ALE configuration
"" Wait, ALE his its own completion?? jesus 
"let g:ale_completion_enabled = 1
let g:ale_pattern_options = {
\			    '\.c$': { 'ale_linters': ['clang'] }
\}
"let g:ale_list_vertical = 1

" Deoplete configuration
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete_delay', 8)
call deoplete#custom#option('yarp', 'true') 
" Oddly enough, at least on Cygwin, NOT setting these paths results in
" expected functionality and doesn't throw errors. The python scripts that
" use these values do try to scan the default path for these
" files/directories...
"let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.dll.a'
"let g:deoplete#source#clang#clang_header = '/lib/clang'

" NERDTree Configuration
""Ignore .pyc files in NerdTree
let NERDTreeIgnore=['\.pyc$', '\~$'] 
"" Open the browser with CTRL-n in normal mode
nnoremap <C-n> :NERDTree<CR>

" Enable folding with the spacebar
"set foldmethod=indent
"set foldlevel=99
"nnoremap <space> za

"let g:SimplyFold_docstring_preview=1

" Color scheme selection
colorscheme ego 

""" PYTHON
let python_highlight_all=1

" PEP8 Indentation
au BufRead,BufNewFile *.py set makeprg=python3\ -q\ %
    "\ set textwidth=79
    "\ set fileformat=unix

""" C
" Use GCC for both :make and :Neomake by default in C source files
"au BufNewFile,BufRead *.c:
au FileType c set makeprg=gcc\ -o\ %<\ %

