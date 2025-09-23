" return to same spot when file opened
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
let mapleader = ","
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map <leader>ss :setlocal spell!<cr>
map <leader>e :source ~/.vimrc<cr>
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k 
set so=6
" Turn on the Wild menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
" Always show current position
set ruler
" Height of the command bar
set cmdheight=1
" A buffer becomes hidden when it is abandoned
set hid
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" Add a bit extra margin to the left
set foldcolumn=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set font according to system
if has("mac") || has("macunix")
    set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
" Set regular expression engine automatically
set regexpengine=0
" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif
try
    " 1 colorscheme evening
    colorscheme slate
    " 3 colorscheme habamax
    " 4 colorscheme lunaperche
catch
endtry

" Cursor
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
autocmd VimLeave * silent !echo -ne "\e[6 q"
set ttimeout
set ttimeoutlen=1
set ttyfast
""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""
filetype plugin on
filetype indent on
"
" => Ale (syntax checker and linter)
"
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\   'go': ['go', 'golint', 'errcheck']
\}
let g:ale_fixers = {
\   'c': ['clang-format'],
\}
nmap <silent> <leader>a <Plug>(ale_next_wrap)
let g:ale_set_highlights = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_virtualtext_cursor = 'disabled'
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
let g:rustfmt_autosave = 1
"
" => bufExplorer plugin
" 
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>
"
" => Nerd Tree
"
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2
" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
" Runner Functions
map <F6> :call CompileRunFast()<CR>
imap <F6> <Esc>:call CompileRunFast()<CR>
vmap <F6> <Esc>:call CompileRunFast()<CR>
func! CompileRunFast()  
if &buftype == 'terminal'
    exec "bd"
    exec "wa"
else
    exec "w"
endif
if &filetype == 'rust'
    exec "vert term time cargo r -r"
else
    :call CompileRun()
endif
endfunc

map <F5> :call CompileRun()<CR>
imap <F5> <Esc>:call CompileRun()<CR>
vmap <F5> <Esc>:call CompileRun()<CR>
func! CompileRun()  
if &buftype == 'terminal'
    exec "bd"
    exec "wa"
else
    exec "w"
endif
if &filetype == 'c'
    exec "!gcc % -o %<"
    exec "!time ./%<"
elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
elseif &filetype == 'java'
    " exec "!javac %"
    exec "vert term java %"
elseif &filetype == 'sh'
    exec "!time bash %"
elseif &filetype == 'python'
    exec "vert term time ./bin/python3 %"
elseif &filetype == 'html'
    exec "!google-chrome % &"
elseif &filetype == 'go'
    exec "!go build %<"
    exec "!time go run %"
elseif &filetype == 'matlab'
    exec "!time octave %"
elseif &filetype == 'rust'
    exec "vert term time cargo r"
elseif &filetype == 'arduino'
    exec "ArduinoUpload"
elseif &filetype == 'plantuml'
    exec "PlantumlOpen"
elseif &filetype == 'zsh'
    exec "!time zsh %"
elseif &filetype == 'asm'
    exec "!make"
elseif &filetype == 'Make'
    exec "vert term make"
endif
endfunc

autocmd FileType asm setlocal commentstring=//%s
map <F4> :call Test()<CR>
imap <F4> <Esc>:call Test()<CR>
vmap <F4> <Esc>:call Test()<CR>
func! Test()  
if &buftype == 'terminal'
    exec "bd"
    exec "wa"
else
    exec "w"
endif
if &filetype == 'rust'
    exec "vert term time cargo test"
endif
endfunc
