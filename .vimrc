"STOP FUCKING BEEPING
set noeb vb t_vb=
if has('gui')
  set vb t_vb=
endif

" Enter the XXI Century
set nocompatible

" remove all existing autocmds
autocmd!

" Sets how many lines of history VIM has to remember
set history=500

" fix errors with the buffer switching without saving...
set hidden

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "ç"
let g:mapleader = "ç"

"set scroll offset to 5 lines
set so=5 


let $LANG='es'
set langmenu=en

"Always show current position
set ruler
set number relativenumber    " toggle hybrid line numbers

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

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

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" Enable matchit plugin to match .*ml tags
packadd! matchit

" Enable syntax highlighting
syntax enable

" Do not show what mode you're in because statusbar already does it
set noshowmode

set background=dark

" Always show the status line
set laststatus=2

" New splits open to right and bottom
set splitbelow
set splitright

" Set extra options when running in GUI mode
if has("gui_running")
  " Hides toolbar and scrollbars and File menu
  set guioptions=gt
  set t_Co=256
  set guitablabel=%M\ %t
  " Toggle fullscreen
  nnoremap <silent> <leader>WW :set lines=200 columns=500<CR>
  nnoremap <silent> <leader>ww :set lines=50 columns=100<CR>
endif

" Highlights the current line background
set cursorline

"autocmd VimEnter * TagbarOpen

" Open VIM in big window
set lines=50 columns=100

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" make a mark for column 80
set colorcolumn=80

" set unix line endings
set fileformat=unix

" Use Unix as the standard file type
set ffs=unix,dos,mac

" save up to 100 marks, enable capital marks
set viminfo=h,'100,f1

" Return to last edit position when opening files 
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Useful Remappings for spanish keyboard
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ' [
nnoremap ¡ ]
nnoremap [ ^
nnoremap ] $

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Enable recursive path search with ':find' or <C-x><C-f> autocompletion
set path+=**

" Enable enhanced command line completion.
set wildmenu wildmode=list:full

" Ignore these filenames during enhanced command line completion.
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.luac " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc " Python byte code
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files
" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*

" File working related
" relative path (src/foo.txt)
nnoremap <leader>cf :let @+=expand("%")<CR>

" absolute path (/something/src/foo.txt)
nnoremap <leader>cF :let @+=expand("%:p")<CR>

" filename (foo.txt)
nnoremap <leader>ct :let @+=expand("%:t")<CR>

" directory name (/something/src)
nnoremap <leader>ch :let @+=expand("%:p:h")<CR>

" {{ SET RG as grep and use it wisely to find in files
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --ignore-case

  " --column: Show column number
  " --line-number: Show line number
  " --no-heading: Do not show file headings in results
  " --fixed-strings: Search term as a literal string
  " --ignore-case: Case insensitive search
  " --no-ignore: Do not respect .gitignore, etc...
  " --hidden: Search hidden files and folders
  " --follow: Follow symlinks
  " --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
  " --color: Search color options

  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}

" bind \ (backward slash) to grep shortcut
command! Search call MySearch()
nnoremap º :Search<CR>

function! MySearch()
  let grep_term = input("Enter search term: ")
  if !empty(grep_term)
    execute 'silent grep!' grep_term | copen
  else
    echo "Empty search term"
  endif
  redraw!
endfunction

" simple fuzzyfind for filenames
nnoremap <Leader>f :find<space>*
" a command to navigate most recent files
nnoremap <leader>F :bro<space>ol<CR>

" lets me add files with wildcards, like **/*.md for all markdown files, very useful.
nnoremap <space>a :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
nnoremap <leader>e :e **/<C-d>

" remaps ctrl-backspace to erase by word in cmdline
cnoremap <C-BS> <C-W>

" Renames current file

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

nmap <space>rn :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" QUICKFIX WINDOW MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer>

nnoremap <silent> 'q :cnext<CR>
nnoremap <silent> 'Q :cprev<CR>
nnoremap <buffer> gv <CR>:vs<CR><C-w>h:bn<CR>:bn<CR>

" toggles quickfix window (forced)
nnoremap <F3> :QFix<CR>
command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

" TAG JUMPING

nnoremap <leader>t :tjump<space>*

" stolen from sensible.vim
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

nnoremap <leader>l :set list!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEXT FILES TREATMENT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:autocmd! BufNewFile,BufRead * set nowrap "don't wrap in code
:autocmd! BufNewFile,BufRead *.txt,*.mkd,*.md,*.tex set wrap
:autocmd! BufNewFile,BufRead *.txt,*.mkd,*.md,*.tex set tw=0

"------  Text Editing Utilities  ------
" <Leader>U = Deletes Unwanted empty lines
map <Leader>dU :g/^\s*$/d<CR>
" <Leader>dT Deletes all tags on all lines
map <leader>dT :%s/<\_.\{-1,\}>//g<CR>
" <Leader>R = Converts tabs to spaces in document
map <Leader>R :retab<CR>

" Use Windows Clipboard
let &clipboard = has ('unnamedplus') ? 'unnamedplus' : 'unnamed'


" map c-x and c-v to work as they do in windows
" only in insert mode and command mode
vmap <c-x> "+x
vmap <c-c> "+y
cno <c-v> <c-r>+
exe 'ino <script> <C-V>' paste#paste_cmd['i']
" map Ctrl+Backspace and Ctrl+Del to behave like windows
:imap <C-BS> <C-W>
:imap <C-Del> <C-O>dw
" Ctrl-U saves in u register what erases (instead of just erasing the whole line)
inoremap <C-U> <C-G>u<C-U>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab " Use spaces instead of tabs
set smarttab " Be smart when using tabs ;)
set ai "Auto indent
set si "Smart indent

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak is on, textwidth is infinite
set lbr
set tw=0

" F2 = Paste Toggle (in insert mode, pasting indented text behavior changes)
set pastetoggle=<F2>

""""""""""""""""""""""""""""""
" => Visual mode & search related
""""""""""""""""""""""""""""""
" remap yy to yank line without <CR>
nnoremap yy 0y$

" Disable highlight when pressing ESC
nnoremap <Esc> :noh<CR>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * "sy/<C-r>s
vnoremap <silent> # "sy/<C-r>sNN

" allow Tab and Shift+Tab to
" tab  selection in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r  "sy:%s/<C-r>s//g<Left><Left>

" select all mapping
nnoremap <leader>a ggVG

" find through files the word under cursor
nnoremap <Leader>* :lvimgrep /\<<C-R><C-w>\>/gj *<CR>
" leader rw to replace word under cursor
nnoremap <Leader>rW :%s/\<<C-R><C-W>\>/g<LEFT><LEFT>
" leader rW to replace WORD under cursor
nnoremap <Leader>rW :%s/\<<C-R><C-A>\>/g<LEFT><LEFT>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext<CR>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

"------  Window Navigation  ------
" <Leader>hljk = Move between windows
nnoremap <Leader>h <C-w>h
nnoremap <Leader>l <C-w>l
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k

nnoremap <Leader>H <C-w>H
nnoremap <Leader>L <C-w>L
nnoremap <Leader>J <C-w>J
nnoremap <Leader>K <C-w>K

"<Leader>= = Normalize window widths
nnoremap <Leader>= :wincmd =<CR>

" ---------- BUFFERS and whatnot  ------
" a number based buffer list
nnoremap <leader>b :ls<CR>:buffer<space>
" a fuzzy buffer list
nnoremap <leader>b :b <C-d>*
" jump to previous edited buffer
nnoremap <space>bb :b#<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions for editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clean trailing whitespace
fun! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

" if has("autocmd")
"   autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
" endif
nnoremap <leader>tw :call CleanExtraSpaces()

" -- Toggle Line Wrap
nnoremap <Leader>wr :set wrap! wrap?<CR>

if has('win32')
  set guifont=ProggyCleanTT:h12,Lucida\ Console:h11
elseif has('mac')
  set guifont=ProggyCleanTT:h12,Menlo:h14
else
  set guifont=ProggyCleanTT:h12,Source\ Code\ Pro:h12,Ubuntu\ Mono:h12
endif

" A Tim Pope function for tables automaticly realigning when using pipe for
" separations:
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Add a heading/subheading to current line
nnoremap <leader>h1 yypVr=<Esc>==
nnoremap <leader>h2 yypVr-<Esc>==
""""""""""""""""""""""""""""""""""""""
" Other
""""""""""""""""""""""""""""""""""""""
" -- Open Config File Fast
nnoremap <Leader>rc :tabnew $MYVIMRC<CR>

" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=100
" Stop SQL language files from doing unholy things to the C-c key
let g:omni_sql_no_default_maps = 1

" STATUS LINE
set statusline=%F%m%r%h%w[%L]%=(%{&ff})%y[%04l,%04v]

" Don't let x and c to spoil the yank register
nnoremap x "_x
nnoremap c "_c
" Keep the cursor in place while joining lines
nnoremap J mzJ`z

""""""""""""""""""""""""""""""""""""""
" Vim-Plug Section
""""""""""""""""""""""""""""""""""""""
if exists("*plug#begin")
  if has('win32')
    call plug#begin('$HOME/vimfiles/plugged')
  else 
    call plug#begin('~/.vim/plugged')
  endif

  " And now, install plugins

  " the . command can repeat whatever you want!
  Plug 'tpope/vim-repeat'
  " comment automatically with gc<movement>
  Plug 'tpope/vim-commentary'
  " probably the best plugin ever written
  Plug 'tpope/vim-surround'
  " Usage:
  " yssb rodea linea de parentesis (yank substline brackets)
  " ds" elimina comillas de alrededor (delete surrounding ")
  " cs"<q> substituye comillas por <q> change surrounding " for <q>
  " ysiw] rodeará una palabra de brackets yank substinnerword ]
  " S en visual mode permite rodear con cualquier
  " input.
  " ALSO personalizados:
  " * significa /* */ comments
  " ! significa <!-- --> comments

  Plug 'tpope/vim-vinegar' " netrw on steroids
  " wrapper for git and display git diff in the left gutter
  Plug 'tpope/vim-fugitive' | Plug 'airblade/vim-gitgutter'
  " easily search, substitute and abbreviate multiple version of words
  Plug 'tpope/vim-abolish'
  " Usage:
  " :Abolish pattern-to-substitute substitution
  " pattern might be composed like this
  " :Abolish teh the
  " :Abolish colour{,s,ed,ing} color{}
  " :Abolish {hon,col}our{,s,ed,ing} {}or{}
  " or in case of searches
  " :S /{insert,visual,command}_mode
  " matches INSERT_MODE, visual_mode & CommandMode

  " Extra Colorschemes ¿?
  Plug 'noahfrederick/vim-noctu'
  Plug 'dennougorilla/azuki.vim'
  Plug 'aereal/vim-colors-japanesque'
  Plug 'whatyouhide/vim-gotham'
  Plug 'mbbill/vim-seattle'
  Plug 'clinstid/eink.vim'

  " Vim Autoclose for parenthesis and quotation
  Plug 'jiangmiao/auto-pairs'

  " markdown and tabular power for json/md <mappings later>
  Plug 'godlygeek/tabular'
  " The godly motion
  Plug 'justinmk/vim-sneak'

  " -- Web Development
  Plug 'mattn/emmet-vim' " most vital for zen-coding
  Plug 'groenewege/vim-less' " useful for understanding less-syntax
  Plug 'ap/vim-css-color' " can print colors if put an hex or rgb code
  Plug 'hail2u/vim-css3-syntax' "useful for understanding css regular syntax
  Plug 'othree/html5.vim' "supposed to provide a better indent
  Plug 'pangloss/vim-javascript' "syntax check for js
  Plug 'elzr/vim-json' "useful for json reading
  Plug 'StanAngeloff/php.vim' "provides php syntax check
  Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' } "trying to get Unity omnicompletion in Vim

  " Initialize plugin system
  call plug#end()

endif

" Tabular mappings
" <SPC>a + symbol tabularizes by symbol
if exists(":Tabularize")
  nmap <space>a= :Tabularize /=<CR>
  vmap <space>a= :Tabularize /=<CR>
  nmap <space>a: Tabularize /:\zs<CR>
  vmap <space>a: Tabularize /:\zs<CR>
endif
" --------- Surround Options -----
"  let ! make a <!-- --> comment surrounding
let g:surround_{char2nr("!")} = "<!-- \r -->"

"  let * make a /* */ comment surrounding
let g:surround_{char2nr("*")} = "/* \r */"

" --------- fuGITive -----
if exists(":Gstatus")
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <Leader>gr :Gremove<CR>
  nnoremap <Leader>gl :Glog<CR>
  nnoremap <Leader>gb :Gblame<CR>
  nnoremap <Leader>gm :Gmove 
  nnoremap <Leader>gp :Ggrep 
  nnoremap <Leader>gR :Gread<CR>
  nnoremap <Leader>gg :Git 
  nnoremap <Leader>gd :Gdiff<CR>

  "------  Git Gutter Options ------
  "Disable <Leader>h* commands as they slow down movement
  let g:gitgutter_map_keys = 0
  if executable("rg")
    let g:gitgutter_grep = 'rg'
  endif
endif  

" ---- Emmet ----
if exists(":emmet#expandAbbr()")
  imap   <C-space>   <Esc>:call emmet#expandAbbr(3,"")<CR>i
endif  

" ----- NETRW file manager -----
let g:netrw_banner=0 " disable annoying banner
let g:netrw_browse_split=4 "open in vsplit window
let g:netrw_altv=1 " open splits to the right
let g:netrw_liststyle=3 " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\\s\s\)\zs\.\S\+'
let g:netrw_winsize = 35
let g:netrw_localrmdir='rm -r' " permite borrar directorios no-vacíos

" Toggle netrw with <Leader>nt
nmap <Leader>nt :call ToggleNetrw()<CR>
" Make sure netrw buffers dont remain hidden
autocmd FileType netrw setl bufhidden=wipe

" a function to avoid opening Netrw another time when it is already open
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction


"""""" OMNISHARP FEATURES
let g:OmniSharp_server_path = 'C:\omnisharp.http-win-x64\OmniSharp.exe'
let g:syntastic_cs_checkers = ['code_checker']
let g:OmniSharp_server_type = 'roslyn'

augroup omnisharp_commands
if exists(":OmniSharpStartServer")
  " Start the omnisharp server for the current solution
  nnoremap <Leader>sts :OmniSharpStartServer<CR>
  nnoremap <Leader>sps :OmniSharpStopServer<CR>
  
  augroup omnisharp_commands
    autocmd!
    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <buffer> <F5> :wa!<CR>:OmniSharpBuild<CR>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <buffer> <Leader>b :wa!<CR>:OmniSharpBuildAsync<CR>
    " Automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()
    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>
    " Cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <buffer> <Leader>x  :OmniSharpFixIssue<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
  augroup END
endif

" TODO colorschemes
colorscheme darkblue
