" ========================== Plugins =========================================
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'scrooloose/syntastic' " Пока не работает. Надо с ним разобраться.
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'junegunn/vim-easy-align'
Plug 'pangloss/vim-javascript' " JS syntax
Plug 'octol/vim-cpp-enhanced-highlight' " C++ syntax

Plug 'ervandew/supertab'
" Plug 'valloric/youcompleteme'

" snippets libs
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

Plug 'KeitaNakamura/neodark.vim'
" Plug 'nightsense/vim-crunchbang'
" Plug 'exitface/synthwave.vim'
call plug#end()

" ======================== Base settings =====================================
" leader
let mapleader=","
let maplocalleader=";"
" indent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set smartindent
" styles
let python_highlight_all=1
set t_Co=256 " 256 цветов в терминале
" colorscheme zenburn

colorscheme neodark

set guifont=consolas:h12

set foldcolumn=1
set showmatch " показывать первую парную скобку после ввода второй
set autoread " перечитывать измененные файлы автоматически
set laststatus=2
set whichwrap=b,<,>,[,],l,h "перемещать курсор на новую строку
set visualbell
set wildmode=list:longest,full
set wildmenu
set title
set showcmd
set cursorline " подсветка текущей строки
set guicursor=
set colorcolumn=80
set hidden

syntax on   " Подсветка синтаксиса
filetype on
filetype plugin indent on


" ================================= mappings =================================
" text navigation
" noremap <silent> j gj
" noremap <silent> k gk
noremap J }
noremap K {
noremap H ^
noremap L $
" file omni-complete
inoremap <C-f> <C-x><C-f>
" Отступы в визуальном моде. Оставляем выделение после отступа
vmap < <gv
vmap > >gv

" Центрирование по курсору в переходах
noremap G Gzz
noremap n nzz
noremap N Nzz
noremap '' ''zz

" Номера строк
if v:version >= 704
    set relativenumber number " for hybrid relative number mode
    inoremap <C-c> <ESC>
    autocmd InsertEnter * :set nornu
    autocmd InsertLeave * :set rnu
endif

" Запоминать позицию курсора между сессиями
autocmd BufReadPost *
    \ if line("'\'") > 0 && line ("'\'") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
" Центрировать буфер на позиции курсора
autocmd BufRead * normal zz

" Search
" While typing a search command, show pattern matches as it is typed
" Only available when compiled with the +extra_search feature
set incsearch
" When there is a previous search pattern, highlight all its matches
" Only available when compiled with the +extra_search feature
set hlsearch
" Ignore case in search patterns
set ignorecase
" Override the 'ignorecase' if the search pattern contains upper case characters
set smartcase
" All matches in a line are substituted instead of one
set gdefault

" ======================== Plugins's settings ================================
" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" NERDTree 
nmap <silent> <F2> : NERDTreeToggle<CR>
nmap <silent> <leader>n : NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" Tagbar
" nmap <F3> :TagbarToggle<CR>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = 'no git repo'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⎇'

let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline_section_c = '%t'
let g:airline_section_z = ' %3.9(%l/%L%) :%3.3(%c%)  '

" vim-javascript
let g:javascript_plugin_jsdoc = 1 " Подсветка синтаксиса jsdoc
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END                         " Авто-фолдинг для js-файлов
set conceallevel=1
let g:javascript_conceal_function             = "ƒ" " Замена символов function
let g:javascript_conceal_arrow_function       = "⇒" " arrow-function


" ========================= filetype settings ================================
autocmd FileType javascript set tabstop=2
autocmd FileType javascript set shiftwidth=2
autocmd FileType javascript set expandtab
autocmd FileType javascript set smartindent 
autocmd FileType javascript set softtabstop=2 
autocmd FileType javascript set smarttab
autocmd FileType cpp set tabstop=3
autocmd FileType cpp set shiftwidth=3
autocmd FileType cpp set expandtab
autocmd FileType cpp set smartindent 
autocmd FileType cpp set softtabstop=3 
autocmd FileType cpp set smarttab
autocmd FileType sql set tabstop=3
autocmd FileType sql set shiftwidth=3
autocmd FileType sql set noexpandtab
autocmd FileType sql set smartindent 
autocmd FileType sql set softtabstop=3 
autocmd FileType sql set smarttab
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set expandtab
autocmd FileType python set smartindent 
autocmd FileType python set softtabstop=2 
autocmd FileType python set smarttab
autocmd FileType html set tabstop=2
autocmd FileType html set shiftwidth=2
autocmd FileType html set expandtab
autocmd FileType css set tabstop=2
autocmd FileType css set shiftwidth=2
autocmd FileType css set expandtab


set nobackup
set noswapfile
set encoding=utf-8
