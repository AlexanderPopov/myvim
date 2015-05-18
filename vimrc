call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'kchmck/vim-coffee-script'
Plug 'davidhalter/jedi-vim'
Plug 'kshenoy/vim-signature'
Plug 'pangloss/vim-javascript'
Plug 'mhinz/vim-signify'
Plug 'majutsushi/tagbar'
" Plug 'Shougo/neocomplete.vim'

" http://superuser.com/questions/343443/are-there-any-autocompletion-plugins-for-vim
" Надо посмотреть, что чувак пишет про автокомплит
call plug#end()

set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set smartindent
let python_highlight_all=1
set t_Co=256
colorscheme zenburn
set nonumber
set guifont=consolas:h12
set foldcolumn=1
set matchpairs+=<:> " показывать совпадающие скобки для HTML-тегов
set showmatch " показывать первую парную скобку после ввода второй
set autoread " перечитывать измененные файлы автоматически
set laststatus=2
set whichwrap=b,<,>,[,],l,h "перемещать курсор на новую строку
set visualbell
set wildmode=list:longest,full
set wildmenu
set title
set showcmd
set cursorline
set guicursor=
set colorcolumn=80
set hidden

syntax on
filetype on 
filetype plugin indent on

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


" Plugins


" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" NERDTree 
nmap <silent> <F2> : NERDTreeToggle<CR>
imap <silent> <F2> : NERDTreeToggle <CR>
let NERDTreeIgnore = ['\.pyc$']
let g:nerdtree_tabs_open_on_console_startup = 1

" Tagbar
nmap <F3> :TagbarToggle<CR>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Neocomplcache
let g:neocomplcache_enable_at_startup = 1

" airline
" Приводим в порядок status line

function! FileSize()
let bytes = getfsize(expand("%:p"))
if bytes <= 0
return ""
endif
if bytes < 1024
return bytes . "B"
else
return (bytes / 1024) . "K"
endif
endfunction

function! CurDir()
return expand('%:p:~')
endfunction

" set laststatus=2
" set statusline=\ 
" set statusline+=%n:\ " buffer number
" set statusline+=%t " filename with full path
" set statusline+=%m " modified flag
" set statusline+=\ \ 
" set statusline+=%{&paste?'[paste]\ ':''}
" set statusline+=%{&fileencoding}
" set statusline+=\ \ %Y " type of file
" set statusline+=\ %3.3(%c%) " column number
" set statusline+=\ \ %3.9(%l/%L%) " line / total lines
" set statusline+=\ \ %{FileSize()}
" set statusline+=%< " where truncate if line too long
" set statusline+=\ \ CurDir:%{CurDir()}
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_b = '%t'
let g:airline_section_z = ' %3.9(%l/%L%) :%3.3(%c%)  '
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0


" autocmd FileType javascript set tabstop=2
" autocmd FileType javascript set shiftwidth=2
" autocmd FileType javascript set expandtab
" autocmd FileType javascript set smartindent 
" autocmd FileType javascript set softtabstop=2 
" autocmd FileType javascript set smarttab
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

" FIXME, TODO comments
map <F6> :vimgrep /FIXME\\|TODO/j *.py<CR>:cw<CR>


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
