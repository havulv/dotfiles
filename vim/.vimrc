" Adapted from Douglas Black's .vimrc
" Vi {{{
set nocompatible "Explicitly set non-Vi compatiability
" }}}
" Colors {{{
syntax enable           " enable syntax processing
colorscheme badwolf
" Font Settings{{{
if has("gui_running")
    set guioptions-=m   "remove menu bar
    set guioptions-=T   "remove Toolbar
    set guioptions-=r   "remove menu bar
    set guioptions-=L   "remove menu bar
    if has("gui_gtk2")
        set guifont=Inconsolata\ 10
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif
" }}}
" Pathogen {{{
execute pathogen#infect()
" }}}
" }}}
" Vimwiki, Clipboard, and Viminfo {{{
set backspace=indent,eol,start
let g:vimwiki_list = [{'path': '~/.wiki/'}]
set clipboard=unnamed
set viminfo+=n~/.dotfiles/vim/.viminfo
" }}}
" Spaces & Tabs {{{
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
set modelines=1
filetype indent on
filetype plugin on
set autoindent
" }}}
" UI Layout {{{
set number              " show line numbers
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set lazyredraw
set showmatch           " higlight matching parenthesis
" }}}
" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}
" Folding {{{
"=== folding ===
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10   " start with fold level of 1
" }}}
" Line Shortcuts {{{
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]
nnoremap E $
vnoremap E $
nnoremap B ^
vnoremap B ^
" }}}
" Leader Shortcuts {{{
let mapleader=","
nnoremap <leader>m :silent make\|redraw!\|cw<CR>
nnoremap <leader>h :A<CR>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>et :exec ":vsp $HOME/.wiki/Daily/" . strftime('%m-%d-%y') . ".wiki"<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>l :call <SID>ToggleNumber()<CR>
nnoremap <leader><space> :noh<CR>
nnoremap <leader>s :mksession<CR>
nnoremap <leader>a :Ag 
nnoremap <leader>c :SyntasticCheck<CR>:Errors<CR>
nnoremap <leader>1 :set number!<CR>
nnoremap <leader>d :GoDoc 
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>r :call <SID>RunFile()<CR>
nnoremap <leader>p :Goyo<CR>
vnoremap <leader>y "+y

" Pane Switching Remaps:
" tnoremap <Esc> <C-\><C-n>
" tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
tnoremap <C-W><C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-W><C-l> <C-\><C-N><C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
" }}}
" Powerline {{{
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:powerline_pycmd = "py3"
let g:Powerline_symbols = "fancy"
set laststatus=2
" }}}
" Avoid Esc {{{
inoremap jk <Esc>
inoremap kj <Esc>
" }}}

" CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'
" }}}
" Syntastic {{{
" Syntastic Python {{{
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_python_flake8_args='--ignore=E501,N813'
let g:syntastic_ignore_files = ['.java$']
let g:syntastic_python_python_exec = 'python3'
" }}}
" }}}
" AutoGroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.py setlocal tabstop=4
    autocmd BufEnter *.md setlocal ft=markdown
    autocmd BufEnter *.go setlocal noexpandtab
    autocmd BufEnter *.avsc setlocal ft=json
augroup END
" }}}
" Testing {{{
let test#strategy = 'neovim'
let test#python#runner = 'nose'
" }}}
" Backups {{{
if !has("gui_win32")
    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set backupskip=/tmp/*,/private/tmp/*
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set writebackup
endif
" }}}
" Custom Functions {{{
function! <SID>ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunc

function! <SID>CleanFile()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %!git stripspace
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunc

" Debugging: {{{
function! RemoveDebugs()
    :g/import pdb\|pdb\.set_trace()/de
endfunction
au FileType python nmap <leader>b oimport pdb; pdb.set_trace()<esc>
au FileType python nnoremap <silent> <leader>B :call RemoveDebugs()<CR>
" }}}
" }}}

" vim:foldmethod=marker:foldlevel=0
