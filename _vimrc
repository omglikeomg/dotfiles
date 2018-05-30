" File              : _vimrc
" Author            : Demian Molinari <demianmolinari@yahoo.com>
" Date              : 28.05.2018
" Last Modified Date: 28.05.2018
" Last Modified By  : Demian Molinari <demianmolinari@yahoo.com>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"STOP FUCKING BEEPING

set noeb vb t_vb=
if has('gui')
  set vb t_vb=
endif

" Enter the XXI Century
set nocompatible

" Enable matchit plugin
packadd! matchit

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
let mapleader = " "
let g:mapleader = " "

" let scroll 5 lines offsetted from the borders of the screen for improved
" readability
set so=5 

let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

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

" Enable recursive path search with ':find' or <C-x><C-f> autocompletion
set path+=**

" Enable syntax highlighting
syntax enable

" Do not show what mode you're in because statusbar already does it
set noshowmode

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guioptions-=r
  set guioptions-=L
  set t_Co=256
  set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" set unix line endings
set fileformat=unix

" Use Unix as the standard file type
set ffs=unix,dos,mac

" save up to 100 marks, enable capital marks
set viminfo=h,'100,f1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Use Windows Clipboard
let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'


" map c-x and c-v to work as they do in windows, only in insert mode
vm <c-x> "+x
vm <c-c> "+y
cno <c-v> <c-r>+
exe 'ino <script> <C-V>' paste#paste_cmd['i']

"------  Text File Settings  ------
:autocmd! BufNewFile,BufRead * set nowrap
:autocmd! BufNewFile,BufRead *.txt,*.md,*.tex set wrap
:autocmd! BufNewFile,BufRead *.txt,*.md,*.tex set tw=0

"------  Text Editing Utilities  ------
" <Leader>ss = Delete all Trailing space in file
map <Leader>ss :%s/\s\+$//<CR>

" <Leader>U = Deletes Unwanted empty lines
map <Leader>dU :g/^\s*$/d<CR>
" <Leader>dT Deletes all tags on all lines
map <leader>dT :%s/<\_.\{-1,\}>//g<CR>

" <Leader>R = Converts tabs to spaces in document
map <Leader>R :retab<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 80 characters
set lbr
set tw=80

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" F2 = Paste Toggle (in insert mode, pasting indented text behavior changes)
set pastetoggle=<F2>


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * "sy/<C-r>s
vnoremap <silent> # "sy/<C-r>sNN

" allow Tab and Shift+Tab to
" tab  selection in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" When you press rg you Grep after the selected text
vnoremap <silent> rg "sy:silent grep <C-r>s \| copen<CR><C-l>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r  "sy:%s/<C-r>s//g<Left><Left>

" select all mapping
nnoremap <leader>a ggVG

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when pressing ESC

nnoremap <Esc> :noh<CR>

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


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" Always show the status line
set laststatus=2

" New splits open to right and bottom
set splitbelow
set splitright

"------  Window Navigation  ------
" <Leader>hljk = Move between windows
nnoremap <Leader>h <C-w>h
nnoremap <Leader>l <C-w>l
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k

"<Leader>= = Normalize window widths
nnoremap <Leader>= :wincmd =<CR>

" make TAB a window fast switcher on normal mode only
nnoremap <Tab> <C-W>w:cd %:p:h<CR>:<CR>
nnoremap <c-Tab> <C-W>W:cd %:p:h<CR>:<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

if has("autocmd")
  autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


" " use <C-Space> for Vim's keyword autocomplete
" "  ...in the terminal
" inoremap <Nul> <C-n>
" "  ...and in gui mode
" inoremap <C-Space> <C-n>

" -- Toggle Line Wrap
nnoremap <Leader>wr :set wrap! wrap?<CR>

"set font"

if has('win32')
  set guifont=ProggyCleanTT:h12,Consolas:h12,Lucida\ Console:h10
elseif has('mac')
  set guifont=Inconsolata:h10,Menlo:h14
else
  set guifont=Inconsolata:h10,Source\ Code\ Pro:h10,Ubuntu\ Mono:h10
endif

" map Ctrl+Backspace and Ctrl+Del to behave like windows
:imap <C-BS> <C-W>
:imap <C-Del> <C-O>dw

" vertical line indentation
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '~'

" make a mark for column 80
set colorcolumn=80
""""""""""""""""""""""""""""""""""""""
" Other
""""""""""""""""""""""""""""""""""""""
" -- Open Config File Fast
nnoremap <Leader>rc :tabnew $MYVIMRC<CR>

" Taken from http://peterodding.com/code/vim/profile/vimrc
" Make Vim open and close folded text as needed because I can't be bothered to
" do so myself and wouldn't use text folding at all if it wasn't automatic.
" set foldmethod=marker foldopen=all,insert foldclose=all

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

if has("gui_running")
  " Hides toolbar and scrollbars and File menu
  set guioptions=gt

  " Highlights the current line background
  set cursorline

  "autocmd VimEnter * TagbarOpen

  " Open VIM in big window
  set lines=50 columns=100

  " Toggle fullscreen
  map <silent> <leader>w :set lines=200 columns=500<CR>
endif

""""""""""""""""""""""""""""""""""""""
" Vim-Plug Section
""""""""""""""""""""""""""""""""""""""
if has('win32')
  call plug#begin('$HOME/vimfiles/plugged')
else 
  call plug#begin('~/.vim/plugged')
endif

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
"
"
" the . command can repeat whatever you want!
" http://vimcasts.org/episodes/creating-repeatable-mappings-with-repeat-vim/
Plug 'tpope/vim-repeat'
" comment automatically with gc<movement>
Plug 'tpope/vim-commentary'

" Extra Colorschemes ¿?
Plug 'noahfrederick/vim-noctu'
Plug 'dennougorilla/azuki.vim'

" Indent line
Plug 'Yggdroot/indentLine'

" Vim Autoclose for parenthesis and quotation
Plug 'jiangmiao/auto-pairs'

" markdown and tabular power for json/md <mappings later>
Plug 'godlygeek/tabular'

" php autocompletion engine and tools
Plug 'shawncplus/phpcomplete.vim'

" TAG outliner -- toggle with <Leader>tb
Plug 'majutsushi/tagbar'

" Header Insert (with <leader>1)
Plug 'alpertuna/vim-header'

" -- FileSystem
Plug 'ludovicchabant/vim-gutentags' " auto-tag generator

" -- Basics
" Testing not having a statusbar
" Plug 'itchyny/lightline.vim' "Status Line
Plug 'tpope/vim-surround' " yssb rodea linea de parentesis (yank substline brackets)
" ds" elimina comillas de alrededor (delete surrounding ")
" cs"<q> substituye comillas por <q> change surrounding " for <q>
" ysiw] rodeará una palabra de brackets yank substinnerword ]
" S en visual mode permite rodear con cualquier
" input.
" ALSO personalizados:
" * significa /* */ comments
" ! significa <!-- --> comments

Plug 'tpope/vim-vinegar' " netrw on steroids

" -- Motion plugs
" Plug 'Lokaltog/vim-easymotion' " Use <SPC>s or 'sneak'<char><char> movement
Plug 'justinmk/vim-sneak'

" -- Web Development
Plug 'mattn/emmet-vim' " most vital for zen-coding
Plug 'groenewege/vim-less' " useful for understanding less-syntax
Plug 'ap/vim-css-color' " can print colors if put an hex or rgb code
Plug 'hail2u/vim-css3-syntax' "useful for understanding css regular syntax
Plug 'scrooloose/syntastic' "error correct for most languages
Plug 'othree/html5.vim' "supposed to provide a better indent
Plug 'pangloss/vim-javascript' "syntax check for js
Plug 'elzr/vim-json' "useful for json reading
Plug 'StanAngeloff/php.vim' "provides php syntax check

Plug 'OmniSharp/omnisharp-vim' "trying to get Unity omnicompletion in Vim


" Initialize plugin system
call plug#end()


"------  Header Options  ------

let g:header_field_author = 'Demian Molinari'
let g:header_field_author_email = 'demianmolinari@yahoo.com'
let g:header_auto_add_header = 0
let g:header_field_timestamp_format = '%Y.%m.%d'
nmap <leader>1 :AddHeader<CR>

" Tabular mappings
" <SPC>a + symbol tabularizes by symbol
if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t: Tabularize /:\zs<CR>
  vmap <Leader>t: Tabularize /:\zs<CR>
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

" --------- Surround Options -----
"  let ! make a <!-- --> comment surrounding
let g:surround_{char2nr("!")} = "<!-- \r -->"

"  let * make a /* */ comment surrounding
let g:surround_{char2nr("*")} = "/* \r */"

"------  fugitive Plug Options  ------
"https://github.com/tpope/vim-fugitive
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
let g:gitgutter_grep = 'rg'

" map FuzzyFinder --> using <Leader>F now as default because its hellafast
" has default <leader>f and <leader>b mappings so lines are commented
" noremap <leader>b :FufBuffer<cr>
" noremap <leader>f :FufFile<cr>
" noremap <leader>T :LeaderfTag<cr>
" noremap <leader>F :LeaderfMru<cr>
" ============== OMITIDO --> ver nuevos mappeos al final del archivo

" use zencoding with <C-Space> or <space>,
" let g:user_emmet_expandabbr_key = '<C-space>'
imap   <C-space>   <Esc>:call emmet#expandAbbr(3,"")<CR>i
" let g:user_emmet_mode = 'n'

" Tags and Tagbar Configuration
" tell gutentags where to match a root (besides specific .git .hg etc)
let g:gutentags_project_root = ['public']
nnoremap <Leader>tb :TagbarToggle<CR>

" Set colorscheme depending on files to open ¿?
colorscheme azuki

" TEST: using netrw (maybe install vinegar.vim)
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

" File working related
" relative path (src/foo.txt)
  nnoremap <leader>cf :let @+=expand("%")<CR>

  " absolute path (/something/src/foo.txt)
  nnoremap <leader>cF :let @+=expand("%:p")<CR>

  " filename (foo.txt)
  nnoremap <leader>ct :let @+=expand("%:t")<CR>

  " directory name (/something/src)
  nnoremap <leader>ch :let @+=expand("%:p:h")<CR>

" IndentLine Configuration
let g:indentLine_setColors = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_char = '|'

" TEST: Lightline plugin disabled and making my own statusbar:
" Status Line: {{{

" Status Function: {{{2
function! Status(winnr)
  let stat = ''
  let active = winnr() == a:winnr
  let buffer = winbufnr(a:winnr)

  let modified = getbufvar(buffer, '&modified')
  let readonly = getbufvar(buffer, '&ro')
  let fname = bufname(buffer)
  let ftype = getbufvar(buffer, '&filetype')

  " column
  let stat .= '%1*' . (col(".") / 100 >= 1 ? '%v ' : ' %2v ') . '%*'

  " file
  let stat .=  active ? ' File: > ' : ' <'
  let stat .= ' %<'

  if fname == '__Gundo__'
    let stat .= 'Gundo'
  elseif fname == '__Gundo_Preview__'
    let stat .= 'Gundo Preview'
  else
    let stat .= '%f'
  endif

  let stat .= active ? ' < ' : ' >'

  " file modified
  let stat .=  modified ? ' [+] ' : ''

  " read only
  let stat .= readonly ? '[RO]' : ''

  " paste
  if active && &paste
    let stat .= ' %2*' . 'P' . '%*'
  endif

  " right side
  let stat .= '%=' . '('. ftype . ') ' . '%='
   

  " git branch
  if exists('*fugitive#head')
    let head = fugitive#head()

    if empty(head) && exists('*fugitive#detect') && !exists('b:git_dir')
      call fugitive#detect(getcwd())
      let head = fugitive#head()
    endif
  endif

  if !empty(head)
    let stat .=  ' ¿ ' . head . ' '
  endif

  return stat
endfunction
" }}}

" Status AutoCMD: {{{
function! SetStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status('.nr.')')
  endfor
endfunction

augroup status
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter,BufUnload * call SetStatus()
augroup END
" }}}

" }}}

" Don't let x and c to spoil the yank register
nnoremap x "_x
nnoremap c "_c
" Keep the cursor in place while joining lines
nnoremap J mzJ`z
" Add a heading/subheading to current line
nnoremap <leader>h1 yypVr=<Esc>==
nnoremap <leader>h2 yypVr-<Esc>==

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

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer>

" custom mappings for the quickfix-window, 
" such as closing it using q and jumping to a result directly whie closing the 
" quickfix-window using O, 
" también usar <C-N> y <C-P> para navegar resultados si hiciera falta
" and--- opening un vsplit with gv
autocmd BufReadPost quickfix nnoremap <buffer> q :cclose<CR>
autocmd BufReadPost quickfix nnoremap <buffer> O <CR>:cclose<CR>
autocmd BufReadPost quickfix nnoremap <buffer> gv <CR>:vs<CR><C-w>h:bn<CR>:bn<CR>
autocmd BufReadPost quickfix nnoremap <c-n> :cnext<CR>
autocmd BufReadPost quickfix nnoremap <c-p> :cprev<CR>

" resumen de lo aprendido
" \ para hacer un grep search que da resultados (similar a <leader>f)
" con una palabra seleccionada, 'rg' hace también una búsqueda por archivos


"""""" OMNISHARP FEATURES
let g:OmniSharp_server_path = 'C:\omnisharp.http-win-x64\OmniSharp.exe'
let g:syntastic_cs_checkers = ['code_checker']
let g:OmniSharp_server_type = 'roslyn'

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

" Start the omnisharp server for the current solution
nnoremap <Leader>sts :OmniSharpStartServer<CR>
nnoremap <Leader>sps :OmniSharpStopServer<CR>

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

" a command to navigate buffer list fast
nnoremap <leader>b :ls<CR>:buffer<space>
" a command to navigate most recent files
nnoremap <leader>F :bro<space>ol<CR>

" apuntes buenitos:
" ma  Set current position as mark 'a' (any lowercase letter will do).
" `a  Jump to mark 'a'. (The first character is a backtick, left of the '1' on your keyboard.)
" g;  Go back to the last place you edited. (You can do it multiple times in a row.)
" Folding
" :fold In visual mode: Fold selected lines.
" 3zF Fold 3 lines.
" zo Open current fold under the cursor.
" zc Close current fold under the cursor.
" za Toggle current fold under the cursor.
" zR Open all folds.
" zM Close all folds.
" zd Delete fold under the cursor. (Leaves text intact, just removes fold.)
" soledad

augroup quickfix_for_vimgrep
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

" find through files the word under cursor
nnoremap <Leader>* :lvimgrep /\<<C-R><C-w>\>/gj *<CR>
" leader rw to replace word under cursor
nnoremap <Leader>rW :%s/\<<C-R><C-W>\>/g<LEFT><LEFT>
" leader rW to replace WORD under cursor
nnoremap <Leader>rW :%s/\<<C-R><C-A>\>/g<LEFT><LEFT>
