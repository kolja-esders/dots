set nocompatible
set encoding=utf-8 " Displayed encoding
set fileencoding=utf-8 " File encoding
scriptencoding utf-8
"
" Enable mouse support for scrolling
set mouse=a

" Make sure <C-q> and <C-s> reach vim
silent !stty -ixon > /dev/null 2>/dev/null 

let s:vimdir = expand("~") . '/.vim'
let s:nvimdir = expand("~") . '/.local/share/nvim'
let s:has_ag = executable('ag')
let s:plugdir = s:nvimdir . '/site/autoload/plug.vim'

" - Plugins <3 ################################################################

" Automatically install vim-plug in case it is missing
if empty(glob(s:plugdir))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Helper function to have prettier conditionals
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Actually specify the plugins
call plug#begin(has('nvim') ? s:nvimdir . "/plugged" : s:vimdir)

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'altercation/vim-colors-solarized'
Plug 'dolph/vim-colors-solarized-black'

Plug 'terryma/vim-expand-region'
Plug 'Townk/vim-autoclose'
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-obsession'
Plug 'leafgarland/typescript-vim'
Plug 'posva/vim-vue'

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'

Plug 'rhysd/vim-clang-format'
Plug 'mxw/vim-jsx' " Syntax highlighting for JSX
Plug 'w0rp/ale'

call plug#end() 

" - General ###################################################################

" Makes sure to create no backup files (filename~)
set nobackup

" Use Ag over Grep
if s:has_ag
  let &grepprg= "ag --smart-case --nogroup --nocolor"
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = 'find %s -type f'
endif

set dictionary=/usr/share/dict/words

" Store swapfiles in a central location
set directory=~/.vim/tmp/swap//
if !isdirectory(s:vimdir . '/tmp/swap')
  call mkdir(s:vimdir . '/tmp/swap', 'p')
endif

set tags=./tags;

" - Visuals ###################################################################
" --- Colors
syntax on " Color syntax highlighting
set background=dark
colorscheme solarized
filetype on
filetype plugin on
filetype indent on

" The background color should depend on the iTerm profile
let iterm_profile = $ITERM_PROFILE
if empty(iterm_profile) || iterm_profile == "dark"
  set background=dark
else
  set background=light
endif

" --- Powerline stuff
let g:airline_powerline_fonts = 1 " Use powerline fonts
let g:Powerline_symbols = 'fancy' " Use fancy powerline symbols

" - Autocomplete ##############################################################
" --- Command
set wildmenu " Use <Left> and <Right> to navigate
set wildmode=longest:full,full " 1st tab will complete to longest common string, next tab cycles through wildmenu
set wildignore+=*/tmp/*,*/annotations/*,*.so,*.swp,*swo,*.zip,*.png,*.jpeg,*.jpg " Ignore those files in wildmenu

" Linting
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_sign_column_always = 1

" - Keys ######################################################################

let mapleader = "\<Space>"

" Windows navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
nmap <C-q> :q<CR>

" Disable direction keys during normal mode
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

" --- Normal Mode
nmap <Leader>n :NERDTreeFind<CR>  Find current file in NERDTree
nmap <Leader>m :NERDTreeToggle<CR> " Toggle NERDTree

" Formatting (clang-format)
"autocmd FileType c,cpp,objc,javascript nnoremap <buffer><Leader>f :<C-u>ClangFormat<CR>
"autocmd FileType c,cpp,objc,javascript vnoremap <buffer><Leader>f :ClangFormat<CR>

let g:clang_format#code_style = "google"

let g:clang_format#style_options = {"ColumnLimit" : 100}

" Select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

nmap <Leader>w :w<CR>| " Save file

" Copy & paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Enter visual line mode
nmap <Leader><Leader> V

" Jump to code declaration (based on ctags)
nnoremap <Leader>d <C-]>
nnoremap <Leader>z <C-T>

" Navigate buffers
nmap <Leader>l :bnext<CR>| " Next buffer 
nmap <Leader>h :bprevious<CR>| " Previous buffer
nmap <Leader>b :buffers!<CR>| " Show buffers
nmap <Leader>q :bdelete<CR>| " Delete current buffer

" Replace selection with buffer
vmap <Leader>r "_dP


" - Tagbar ####################################################################
let g:tagbar_width = 60

" - Misc ######################################################################

" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab

" Window flashing and beeping
set noerrorbells visualbell t_vb= " No beeping and window flashing
autocmd GUIEnter * set visualbell t_vb= " Flashing needs to be disabled after GUI startup

" Better search in files
set number
set rnu
set ignorecase
set smartcase
set incsearch
set gdefault

set laststatus=2

set path=$PWD/**

set autoread
set so=7
set cmdheight=1

set formatoptions+=j " Join comments if possible

set expandtab " Use spaces instead of tabs
set smarttab " Be smart when using tabs

" Turn off permanent search highlighting
set nohlsearch

" " Linebreak on 500 characters
set lbr

"set cindent
set wrap " Wrap lines

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent

" - General aesthetics ####################################################

highlight clear SignColumn


" - Package configurations ################################################

" --- CtrlP

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|DS_Store|dat|swp|swo)$',
\}
let g:ctrlp_root_markers = ['.root'] " Have a marker file for root detection
let g:ctrlp_working_path_mode = 'ra' " Use the nearest .git directory as the cwd

" --- fugitive

let g:fugitive_gitlab_domains = ['https://ids-git.fzi.de']

" --- vim-jsx

" Enable JSX syntax highlighting also for .js files
let g:jsx_ext_required = 0

" --- ALE
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'cpp': ['clang-format'],
\}
let g:airline#extensions#ale#enabled = 1

nmap <buffer><Leader>f :ALEFix<CR>

" --- fzf
nmap <leader>o :Files<cr>| " Open a new file (which is under version control)
nmap <leader>a :Ag<cr>| " Open a new file (which is under version control)
nmap <leader>y :Lines<cr>|
" Maybe also add :Commits?


" --- Buffergator
"nmap <leader>b :BuffergatorMruCyclePrev<cr> " Go to the previous buffer open
"nmap <leader>bn :BuffergatorMruCycleNext<cr> " Go to the next buffer open
"nmap <leader>b :BuffergatorToggle<CR>| " View the entire list of buffers open
"nmap <leader>bq :bp <BAR> bd #<CR> " Close the current buffer and move to the previous one
"let g:buffergator_viewport_split_policy = 'R' " Use the right side of the screen
"let g:buffergator_suppress_keymaps = 1 " I want my own keymappings...

" Multiple presses will extend visual region
vmap v <Plug>(expand_region_expand)
" Ctrl-v will shrink visual region
vmap <C-v> <Plug>(expand_region_shrink)

" --- Tagbar
nmap <Leader>t :TagbarToggle<CR>

"let g:neocomplete#enable_at_startup = 1
