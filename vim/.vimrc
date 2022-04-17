" Adapted from Douglas Black's .vimrc
" Vi: {{{
set nocompatible "Explicitly set non-Vi compatiability
" }}}
" Colors: {{{
syntax enable           " enable syntax processing
colorscheme badwolf

" Font Settings{{{
set encoding=utf-8

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

" Pathogen: {{{
execute pathogen#infect()
" }}}

" Gutentags: {{{
" Set the project root lookup
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['.git', 'package.json']

" Generation settings -- self explanatory
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" Set a default location for tags
let g:gutentags_cache_dir = expand('~/.dotfiles/cache/.cache/vim/tags/')

" Extra args -- check ctags --list-fields for more info
let g:gutentags_ctags_extra_args = [
    \ '--tag-relative=yes',
    \ '--fields=+ailmnS',
    \ ]

map tt <C-]>
" }}}
" Deoplete: {{{
" execute deoplete#enable()
" Deoplete is really fucking with my shit

" Toggle autocomplete off
" -- deoplete is too slow at this point for large
" -- directories. Might enable this if it gets better
" nnoremap <leader>ac :call deoplete#disable()

" execute deoplete#enable()
"
" -- deoplete is too slow at this point for large
" -- directories. Might enable this if it gets better
" execute deoplete#enable()
" Options
" call deoplete#max_list=100
" }}}

" Vimwiki, Clipboard, and Viminfo: {{{
set backspace=indent,eol,start
let g:vimwiki_list = [{'path': '~/.wiki/'}]
set clipboard=unnamed
set viminfo+=n~/.dotfiles/vim/.viminfo
" }}}

" Spaces & Tabs: {{{
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
set modelines=1
filetype indent on
filetype plugin on
set autoindent
" }}}

" UI Layout: {{{
set number              " show line numbers
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set lazyredraw
set showmatch           " higlight matching parenthesis
" }}}

" Searching: {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}

" Folding: {{{
"=== folding ===
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za
set foldlevelstart=10   " start with fold level of 1
" }}}

" Line Shortcuts: {{{
nnoremap j gj
nnoremap k gk
nnoremap gV `[v`]
nnoremap E $
vnoremap E $
nnoremap B ^
vnoremap B ^
" }}}

" Leader Shortcuts: {{{
let mapleader=","

" Vim stuff
nnoremap <leader>m :silent make\|redraw!\|cw<CR>
nnoremap <leader>h :A<CR>

" Vimrc editing
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Wiki editing
nnoremap <leader>et :exec ":vsp $HOME/.wiki/Daily/" . strftime('%m-%d-%y') . ".wiki"<CR>

" Toggle line numbering
nnoremap <leader>l :call <SID>ToggleNumber()<CR>
nnoremap <leader>1 :set number!<CR>

" Remove highlighting
nnoremap <leader><space> :noh<CR>

" Make a sesion
nnoremap <leader>s :mksession<CR>

" Edit the bashrc
nnoremap <leader>ez :vsp ~/.bashrc<CR>

" Check for errors
nnoremap <leader>c :SyntasticCheck<CR>:Errors<CR>
" }}}

" Golang: {{{

" Vim-Go: {{{
" Go documentation from vim-go
" Normal mode
nnoremap <leader>gd :GoDoc<CR>
nnoremap <leader>gbr :GoDocBrowser<CR>
nnoremap <leader>gl :GoLint<CR>
nnoremap <leader>gf :GoFmt<CR>
nnoremap <leader>gi :GoInfo<CR>
nnoremap <leader>gt :GoTest!<CR>
nnoremap <leader>gta :GoTest! -tags=all<CR>
nnoremap <leader>gtu :GoTest! -tags=unit<CR>
nnoremap <leader>gti :GoTest! -tags=integration<CR>
nnoremap <leader>gtf :GoTestFunc!<CR>
nnoremap <leader>gc :GoMetaLinter!<CR>

" Fix imports by default
let g:go_fmt_command = "goimports"

" Visual mode
vnoremap <leader>gd :GoDoc<CR>
vnoremap <leader>gbr :GoDocBrowser<CR>

" use gopls for definitions and info
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'

" use goimports for auto importing
let g:go_fmt_command = 'goimports'

" use golangci-lint for linting
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "10s"
let g:go_metalinter_command = "golangci-lint"
" Debug
" let g:go_debug=['shell-commands']

" }}}
" GoVim: {{{
" suggestions from the minimal govim
set updatetime=500
set signcolumn=number
" Set the goimports package to the local
" module root
call govim#config#Set("FormatOnSave", "goimports")
call govim#config#Set("GoImportsLocalPrefix", trim(
    \ system(
    \ 'cd ' . substitute(
        \ shellescape(
            \ expand('%:p:h')),
    \ "\.dotfiles\/go\/", "", "") .
    \ ' && go list -m;')))
" }}}

" Testing: {{{
nnoremap <leader>Tf :TestFile<CR>
nnoremap <leader>Ts :TestSuite<CR>
nnoremap <leader>Tl :TestLast<CR>
nnoremap <leader>r :call <SID>RunFile()<CR>
" }}}

" Goyo: {{{
nnoremap <leader>p :Goyo<CR>
" }}}

" Nerdtree: {{{
nnoremap <leader>d :NERDTree<CR>
nnoremap <leader>dc :NERDTreeClose<CR>
" }}}

" Copy Paste: {{{
" Copy into the + register on highlight
vnoremap <leader>y "+y
" }}}

" Pane Switching Remaps: {{{
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

" Powerline: {{{
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
let g:powerline_pycmd = "py3"
let g:Powerline_symbols = "fancy"
set laststatus=2
" }}}

" Avoid Esc: {{{
inoremap jk <Esc>
inoremap kj <Esc>
" }}}

" CtrlP: {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\vbuild/|dist/|venv/|target/|\.(o|swp|pyc|egg)$'
" }}}

" Syntastic: {{{
" Syntastic Python: {{{
" In general, I would like to use pylint but there are too many egregious
" errors rn
let g:syntastic_python_checkers = ["flake8", "mypy"]
let g:syntastic_ignore_files = ['.java$']
let g:syntastic_python_python_exec = 'python3'
" }}}
" Syntastic Go: {{{
let g:syntastic_go_checkers = [ "go", "gofmt", "govet", "revive", "golangci-lint" ]
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" }}}
" Syntastic Shellcheck (bash) {{{
" -x follows `source` directives even when the file is not specified as input,
" meaning that shellcheck can check any file to be sourced.
let g:syntastic_sh_shellcheck_args = "-x"
" }}}
" }}}

" AutoGroups: {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.ts,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab

    autocmd BufEnter *.sh,*.tf setlocal tabstop=2
    autocmd BufEnter *.sh,*.tf setlocal shiftwidth=2
    autocmd BufEnter *.sh,*.tf setlocal softtabstop=2

    autocmd BufEnter *.ts setlocal tabstop=2
    autocmd BufEnter *.ts setlocal softtabstop=2
    autocmd BufEnter *.ts setlocal shiftwidth=2

    autocmd BufEnter *.tsx setlocal tabstop=2
    autocmd BufEnter *.tsx setlocal softtabstop=2
    autocmd BufEnter *.tsx setlocal shiftwidth=2

    autocmd BufEnter *.scss setlocal tabstop=2
    autocmd BufEnter *.scss setlocal softtabstop=2
    autocmd BufEnter *.scss setlocal shiftwidth=2

    autocmd BufEnter *.json setlocal tabstop=2
    autocmd BufEnter *.json setlocal softtabstop=2
    autocmd BufEnter *.json setlocal shiftwidth=2
    autocmd BufEnter *.py setlocal tabstop=4

    autocmd BufEnter *.py setlocal tabstop=4
    autocmd BufEnter *.md setlocal ft=markdown
    autocmd BufEnter *.go setlocal noexpandtab
    autocmd BufEnter *.avsc setlocal ft=json
augroup END

augroup pythongroup
    autocmd!
    " autocmd BufWritePre *.py execute ':Black'
augroup END
" }}}

" Open in the browser: {{{
let g:netrw_browsex_viewer = "open"
" }}}

" Testing: {{{
let test#strategy = 'neovim'  " run in a small terminal
let test#python#runner = 'nose'
" }}}

" Backups: {{{
if !has("gui_win32")
    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set backupskip=/tmp/*,/private/tmp/*
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set writebackup
endif
" }}}

" Custom Functions: {{{
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
