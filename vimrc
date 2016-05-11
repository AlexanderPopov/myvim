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
Plug 'octol/vim-cpp-enhanced-highlight' " C++ syntax
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
colorscheme zenburn
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


" ================================= mappings =================================
" text navigation
noremap <silent> j gj
noremap <silent> k gk
noremap J }
noremap K {
noremap H ^
noremap L $
" " file omni-complete
inoremap <C-f> <C-x><C-f>
" " Отступы в визуальном моде. Оставляем выделение после отступа
vmap < <gv
vmap > >gv

syntax on   " Подсветка синтаксиса
filetype on
filetype plugin indent on

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
let NERDTreeIgnore = ['\.pyc$']

" Tagbar
" nmap <F3> :TagbarToggle<CR>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = 'no git repository'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0

let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_c = '%t'
let g:airline_section_z = ' %3.9(%l/%L%) :%3.3(%c%)  '


" ========================= filetype settings ================================
autocmd FileType javascript set tabstop=2
autocmd FileType javascript set shiftwidth=2
autocmd FileType javascript set expandtab
autocmd FileType javascript set smartindent 
autocmd FileType javascript set softtabstop=2 
autocmd FileType javascript set smarttab
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set expandtab
autocmd FileType python set smartindent 
autocmd FileType python set softtabstop=2 
autocmd FileType python set smarttab
autocmd FileType htmldjango set tabstop=2
autocmd FileType html set tabstop=2
autocmd FileType htmldjango set shiftwidth=2
autocmd FileType html set shiftwidth=2
autocmd FileType htmldjango set expandtab
autocmd FileType html set expandtab
autocmd FileType css set tabstop=2
autocmd FileType css set shiftwidth=2
autocmd FileType css set expandtab
autocmd FileType coffee set tabstop=2
autocmd FileType coffee set shiftwidth=2
autocmd FileType coffee set expandtab
autocmd FileType coffee set smartindent 


set nobackup
set noswapfile
set encoding=utf-8

" Shell ------------------------------------------------------------------- {{{
set shell=/bin/bash
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell 
