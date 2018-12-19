" .vimrc
" By Demian Molinari - omglikeomg
" Last changes done on Sept. 1, 2018
"
" BASIC {{{
"""""""

set hidden
set mouse=a
set noerrorbells visualbell t_vb=
if &term!='xterm-256color'
  set term=xterm-256color
endif
if has('mouse_sgr')
  set ttymouse=sgr
else
  set ttymouse=xterm2
endif

if &history < 500
  set history=500
endif

set encoding=utf-8
set backspace=eol,start,indent
" [h] and [l] dont change line when moving, arrows do
set whichwrap+=<,>,[,]
set whichwrap-=h,l
" }}}

" ANTIVIMHEAVIOR {{{
""""""""""""""""
set nowritebackup
set nobackup
set noswapfile
set autoread
if !empty(&viminfo)
  set viminfo^=!
endif
" }}}

" CLIPBOARD-things {{{
""""""""""""""""""
let &clipboard = has ('unnamedplus') ? 'unnamedplus' : 'unnamed'
set pastetoggle=<F2>
" }}}

" SEARCH {{{
""""""""
set incsearch
set ignorecase
set smartcase
" }}}

" INTERFACE {{{
"""""""""""
set number relativenumber
set hlsearch
if !&scrolloff
  set scrolloff=3
endif
if !&sidescrolloff
  set sidescrolloff=1
endif
set cmdheight=2
set nocursorline
set lazyredraw

" statusbar
let g:currentmode={
    \ 'n'  : 'N ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'V ',
    \ 'V'  : 'V·Line ',
    \ '' : 'V·Block ',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '' : 'S·Block ',
    \ 'i'  : 'I ',
    \ 'R'  : 'R ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
    \ 't'  : 'Terminal ',
    \}
highlight! StatusLine ctermfg=0 ctermbg=15
set laststatus=2
set statusline=%{ChangeStatuslineColor()}
set statusline+=%<\
set statusline+=%-3.3n\                       " bufno
set statusline+=%40F\                         " file+path
set statusline+=%h%m%r%w                      " flags(mod,ro,etc)
set statusline+=[%{strlen(&ft)?&ft:'none'},   " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},  " encoding
set statusline+=%{&fileformat}]               " format (unix,dos)
set statusline+=%=                            " right...
" syntax-info
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\
set statusline+=[%04l,%04v]\                  " linecol
set statusline+=(%L\ lines)                   " total

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

set splitbelow
set splitright

set foldmethod=marker

set background=dark
" }}}

" FORMAT OF STUFF {{{
"""""""""""""""""
set fileformat=unix
set ffs=unix,dos,mac

set nojoinspaces
set formatoptions+=j

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
if has('autocmd')
  filetype plugin on
  filetype indent on
endif
set textwidth=0
set linebreak
set nowrap

set shiftwidth=2 softtabstop=2
set tabstop=2
set smarttab
set autoindent
set expandtab
set nolist
set listchars=tab:\|\ ,eol:¬,extends:…,precedes:…,trail:.,nbsp:·

" I like using listchars all the time
" augroup Saving_text
"   autocmd!
"   autocmd BufReadPost * call Try_Retab()
"   autocmd BufWritePre * call Set_Spaces()
"   autocmd BufWritePost * call Set_Tabs()
" augroup END

" }}}

" GUI SETUP {{{
"""""""""""
if has('gui_running')
  set guioptions=gt
  colorscheme desert
  set columns=100
  set lines=60
endif
" }}}

" WEIRD PREVENTION {{{
""""""""""""""""""
" [O] timeouts
set timeout timeoutlen=1000 ttimeoutlen=100
" literally: Stop SQL language files from doing unholy things to the C-c key
let g:omni_sql_no_default_maps = 1

if has('win32')
  let g:vim_at_user_home = $USERPROFILE."/vimfiles"
else
  let g:vim_at_user_home = $HOME."/.vim"
endif
" }}}

" NETRW {{{
"""""""
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_browse_split = 0
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\\s\s\)\zs\.\S\+'
let g:netrw_winsize = 35
let g:netrw_localrmdir='rm -r'

augroup netrw
  autocmd!
  autocmd FileType netrw setl bufhidden=wipe
augroup END
" }}}

" COMPLETION {{{
""""""""""""
set omnifunc=syntaxcomplete#Complete
set path=a.,,**
set wildmenu wildmode=list:longest

set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.luac " Lua byte code
" compiled object files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.dat,*.class,*.zip,*.rar,*.7z
set wildignore+=*.pyc " Python byte code
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files
" images
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
" node modules y similar
set wildignore+=*/node_modules/*,*/bower_components/*
" git
set wildignore+=.git/*

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

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
elseif executable("ag") " o si existe su hermano menor y más famoso Ag
  set grepprg=ag\ --nogroup\ --nocolor\ --smart-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
else
  set grepprg=egrep\ .\ -rne
  set fileignorecase
endif
" }}}

" KEYS {{{
""""""
nnoremap <space> <Nop>
let mapleader = " "
let g:mapleader = "\<Space>"
" MANDATORY ANTI <CTRL-U>
inoremap <C-U> <C-G>u<C-U>

nnoremap <leader><leader><leader> :noh<CR>

" STUPID SPANISH KEYBOARD
" nnoremap - /
" nnoremap _ ?
nnoremap - /\v
nnoremap _ ?\v
nnoremap gl <C-]>

" WRAP:
nnoremap <expr>çli expand(&g:list) ? ":call Set_Spaces()<CR>" : ":call Set_Tabs()<CR>"
nnoremap çwr :set wrap! wrap?<CR>
" nnoremap <Leader>wr :set wrap!<CR>:set list! wrap?<CR>
nnoremap <expr>j expand(&l:wrap) == 1 ? "gj" : "j"
nnoremap <expr>k expand(&l:wrap) == 1 ? "gk" : "k"
nnoremap <expr>^ expand(&l:wrap) == 1 ? "g0" : "^"
nnoremap <expr>$ expand(&l:wrap) == 1 ? "g$" : "$"

" DONT JUMP WHEN JOINING LINES:
nnoremap J mzJ`z

" YOU WILL NEVER STOP, WON'T YOU?
nnoremap <Leader>rc :tabnew $MYVIMRC<CR>

" GUI IS A PRETTY COOL GUY BECAUSE OF THIS:
inoremap <C-BS> <C-W>
inoremap <C-Del> <C-O>dw
" alternates between eol, next line and current position in insert-mode
" without that much finger acrobatics
" (works in gui mode only)
inoremap <C-CR> <Esc>mmo
inoremap <S-CR> <Esc>mmA
inoremap <C-B> <Esc>'mi

" AUTOCOMPLETION:
inoremap <C-F> <C-X><C-F>
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" HELP-SEARCH:
nnoremap <leader>hs :vs g:vim_at_user_home/vimtips.txt<CR>

" Replace word under cursor:
nnoremap <Leader>rw :%s/\<<C-R><C-W>\>//g<LEFT><LEFT>
" Replace WORD under cursor:
nnoremap <Leader>rW :%s/\<<C-R><C-A>\>//g<LEFT><LEFT>

" I <3 IL
" nnoremap <leader>/ :il /
" nnoremap <leader>* [I:
" I have a better il that loads in loclist
nnoremap <leader>/ :Tilist<space>
nnoremap <leader>* :call Turbo_asterisk()<CR>"

" TAGS
nnoremap <Leader>ts :tselect<Space><C-D>
nnoremap <leader>tj :tjump<Space><C-D>*

" DONT MESS UP MY REGISTER
nnoremap x "_x
nnoremap c "_c

" VISUAL:
" Search selection in visual
vnoremap <silent> * "sy/<C-r>s<CR>
vnoremap <silent> # "sy?<C-r>s<CR>
" Indent selection with TAB
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" windows like mappings for copy/cut
vnoremap <c-x> "+d
vnoremap <c-c> "+y
" Select all mapping
nnoremap <leader>a ggVG

" SWAP TO LAST USED TAB
nnoremap <Leader>t<Leader> :exe "tabn ".g:lasttab<CR>

" LIST BUFFERS, OPEN BUFFERS
nnoremap <leader>b :ls<CR>:b<space>
nnoremap <leader>B :b #<CR>

" files
nnoremap <leader>f :find *
nnoremap <leader>e :Ex<CR>

" I mostly use preview window from netrw
nnoremap <leader><leader>p <C-w>z
" Shortcut to close quickfix window 
" TODO: upgrade to closing latest lwindow if no qf is found
nnoremap <leader><leader>q :cclose<CR>

" utilities to make splits on opening files/buffers
" vertical split
cnoremap <C-S> <Home>vertical s<End>
" horizontal split
cnoremap <C-X> <Home>s<End>
" new tab
cnoremap <C-T> <Home>tab<End>

" Grep pattern
nnoremap º :Search<CR>
" GrepFind (word under cursor)
nnoremap <Leader>gf :Search<CR><C-R><C-w><CR>
" nnoremap <leader>F :oldfiles<CR>:e #<
nnoremap <leader>F :MostRecent<CR>
" }}}

" HELPERS {{{
"""""""""
" remember last position on a file
augroup Restorepos
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

augroup TwigIfNotTwig
  autocmd!
  autocmd Filetype twig set ft=html
augroup END
augroup DrupalFiles
  autocmd!
  autocmd Filetype theme,module set ft=php
augroup END

augroup CursorLine
  autocmd!
  autocmd VimEnter * setlocal cursorline
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

function! MakeTags() abort
  let command='ctags -R'
  let confirm = input(expand('%:h') . ' is this the correct path? y/n')
  if confirm == 'y'
    exec ':silent !' . command
  elseif confirm == 'n'
    echo 'please navigate to the correct directory'
    return
  endif
  echo 'Tags generated.'
endfunction

command! Maketags call MakeTags()

augroup QfRemaps
  autocmd!
  autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
  autocmd FileType qf nnoremap <buffer><silent> <leader><CR> <C-w><CR>:cclose<CR>
augroup END

" remembers last tab number
augroup Lasttab
  autocmd!
  autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END

" FUNCTION TO SAVE AS SPACES AND SEE AS TABS
function! Set_Tabs() abort
  if(&g:expandtab) " if using spaces
    set noexpandtab " disable
    " and retab it
    exec 'keepjumps %retab!'
    " then show listchars
    set list
  endif
endfunction

" TODO: find out how not to write the changes to the changelist so you don't
" have to undo twice after saving if you mess up.
function! Set_Spaces() abort
  if (&g:expandtab == 0) " if using tabs
    set expandtab " use spaces
    " and retab it
    exec 'keepjumps %retab'
    " then hide listchars
    set nolist
  endif
endfunction

function! Try_Retab() abort
  if !&readonly && &buftype != 'nofile' && &buftype != 'quickfix'
    exec 'keepjumps %retab!'
  endif
endfunction

" changes statusline color per mode
function! ChangeStatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! StatusLine ctermfg=15 ctermbg=0 guibg=#EEEEEE guifg=#080002'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! StatusLine ctermfg=3 ctermbg=0 guibg=#EAE27C guifg=#080002'
  elseif (mode() ==# 'i')
    exe 'hi! StatusLine ctermfg=1 ctermbg=0 guibg=#F08C46 guifg=#080002'
  else
    exe 'hi! StatusLine ctermfg=2 ctermbg=0 guibg=#EEEEEE guifg=#080002'
  endif
  return ''
endfunction

" Open list of oldfiles as something interactionable:
command! MostRecent vnew +setl\ buftype=nofile | 0put =v:oldfiles
      \| nnoremap <buffer> <CR> :e <C-r>=getline('.')<CR><CR>

" il command improvements...
function! Turbo_asterisk() abort
  redir => output
  silent! exec join(['ilist', expand('<cword>')], ' ')
  redir END
  let lines = split(output, '\n')
  if lines[0] =~ '^Error detected'
    echomsg 'Word not found'
    return
  endif
  let [filename, line_info] = [lines[0], lines[1:-1]]
  let loclist_entries = map(line_info, "{
        \ 'filename': filename,
        \ 'lnum': split(v:val)[1],
        \ 'text': getline(split(v:val)[1])
        \ }"
        \ )
  let win_number = winnr()
  call setloclist(win_number, loclist_entries)
  lwindow
endfunction

function! Turbo_il(pattern) abort
  redir => output
  silent! exec join(['ilist', a:pattern], ' ')
  redir END
  let lines = split(output, '\n')
  if lines[0] =~ '^Error detected'
    echomsg 'Word not found'
    return
  endif
  let [filename, line_info] = [lines[0], lines[1:-1]]
  let loclist_entries = map(line_info, "{
        \ 'filename': filename,
        \ 'lnum': split(v:val)[1],
        \ 'text': getline(split(v:val)[1])
        \}"
        \)
  let win_number = winnr()
  call setloclist(win_number, loclist_entries)
  lwindow
endfunction

" requires 1 argument so command is mandatory
command! -nargs=1 Tilist exec printf('call Turbo_il(%s)', string(<q-args>))

" Search for string in files
function! MySearch() abort
  let grep_term = input("Pattern: ")
  if !empty(grep_term)
    execute 'silent grep!' grep_term
    " silent prevents from opening first result
    " DO NOT USE LocList for this one !!
    execute 'copen'
    " remap Ctrl-T, Ctrl-X and Ctrl-V to open splits/tabs
    nnoremap <buffer> <C-T> <C-W><CR><C-W>T
    nnoremap <buffer> <C-X> <C-W><CR>
    nnoremap <buffer> <C-V> <C-W><CR><C-W>L
    nnoremap <buffer> <Esc> :cclose<CR>
  else
    echo "No pattern provided"
  endif
  redraw!
endfunction

command! Search call MySearch()

function! InstallPlug(win) abort
  if a:win == 1
    if empty(glob($HOME . '/vimfiles/autoload/plug.vim'))
      if executable('curl')
        silent !curl -fLo $HOME/vimfiles/autoload/plug.vim --create-dirs
              \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      else
        echomsg 'Cannot install Vim-Plug. Install curl first'
      endif
    endif
  endif
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
endfunction

command! -bar InstallPlug call InstallPlug(has('win32'))
" }}}

" PLUGIN AND SO ON {{{
""""""""""""""""""
if filereadable($HOME . '/vimfiles/autoload/plug.vim') 
      \|| filereadable($HOME . '/.vim/autoload/plug.vim')
  if has('win32')
    call plug#begin('$HOME/vimfiles/plugged')
  else
    call plug#begin('~/.vim/plugged')
  endif

  Plug 'tpope/vim-repeat' 
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  " config:
  let g:surround_{char2nr("¡")} = "¡\r!"
  let g:surround_{char2nr("¿")} = "¿\r?"
  " Drupal Twig translation surround
  let g:surround_{char2nr("T")} = "{% trans %}\r{% endtrans %}"
  " config END
  Plug 'tpope/vim-fugitive' | Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-abolish'
  " Plug 'jiangmiao/auto-pairs' " <-- try to live w/o it
  Plug 'godlygeek/tabular'
  " config:
  " A Tim Pope function for tables automatically realigning when using pipe for
  " separations:
  inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

  function! s:align() abort
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
      let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
      let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
      Tabularize/|/l1
      normal! 0
      call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
  endfunction"
  " config END

  " UNNECESSARY COMMODITIES
  Plug 'mattn/emmet-vim'
  " this trick has proven more useful than expected
  imap ,, <plug>(emmet-expand-abbr)

  let g:user_emmet_settings = {
        \ 'php' : {
        \   'snippets' : {
        \     'ake' : "array_key_exists(|)",
        \     'pm' : "preg_match(|)",
        \     'ps' : "preg_replace(|)",
        \     'fun' : "function | () {\r\r}",
        \     'pf' : "public function | () {\r\r}",
        \     'sf' : "static function | () {\r\r}",
        \     'psf' : "public static function | () {\r\r}",
        \     'for' : "for (\$i = 0; \$i < |; $i++) {\r\t|\r}",
        \     'fore' : "foreach (\$${child} as \$${child}_element) {\r\t|\r}",
        \    },
        \ },
        \ }

  if !has('win32')
    " If windows, install manually fzf binary and put it on system32
    Plug 'junegunn/fzf', { 'dir': $HOME.'/fzf', 'do': './install --all' }
  endif
  Plug 'junegunn/fzf.vim'
  " config:
  let g:fzf_layout = { 'down': '~20%' }
  let g:fzf_colors =
        \ { 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Clear'],
        \ 'hl':      ['fg', 'String'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }

  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
        \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
        \   <bang>0)

  " SYNTAX
  Plug 'sheerun/vim-polyglot'
  Plug 'fatih/vim-go'

  " SOME COLOUR
  Plug 'robertmeta/nofrils'
  Plug 'nightsense/strawberry'

  " MAPPINGS
  if !&diff
    augroup PluginMapping
      autocmd!
      autocmd VimEnter * call Maps_Plugins()
    augroup end
  endif

  function! Maps_Plugins() abort
    " if exists(":Emmet")
    "   exec 'inoremap <C-Space> <Esc>:call emmet#expandAbbr(3,"")<CR>i'
    " endif
    if exists(":FZF")
      exec 'nnoremap <leader>b :Buffers<CR>'
      exec 'nnoremap <leader>f :Files<CR>'
      exec 'nnoremap º :Rg<space>'
      exec 'nnoremap <leader>F :History'
      exec 'nnoremap <leader>ts :Tags'
    endif
    if exists(":Git")
      let g:gitgutter_map_keys = 0
      let g:gitgutter_max_signs = 999
      if executable("rg")
        let g:gitgutter_grep = 'rg'
      endif
    endif
  endfunction

  " For testing purposes:
  Plug 'junegunn/vader.vim'
  call plug#end()
endif
" }}}
