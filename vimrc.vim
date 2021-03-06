" .vimrc
" By Demian Molinari - omglikeomg
" Last changes done on Jan 2019
"
" BASIC {{{
set nocompatible "relevant only if the file name/location is not of the default rc file
set bg=dark
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
if has('autocmd')
  filetype plugin on
  filetype indent on
endif
set bs=2 " eol, start, indent
set autoindent
if has('smartindent')
  set smartindent
endif
if has('wildmenu')
  set wildmenu
  set wildmode=list:longest
  set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
  set wildignore+=*.luac " Lua byte code
  " compiled object files
  set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.dat,*.class,*.zip,*.rar,*.7z,*.gz
  set wildignore+=*.pyc " Python byte code
  set wildignore+=*.spl " compiled spelling word lists
  set wildignore+=*.sw? " Vim swap files
  " images
  set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico,*.svg
  set wildignore+=*.pdf,*.psd,*.ai
  " node modules y similar
  set wildignore+=*/node_modules/*,*/bower_components/*
  " git
  set wildignore+=.git/*
endif
if has('autocmd') && exists('+omnifunc')
  set omnifunc=syntaxcomplete#Complete
endif
" search parameters
set incsearch
set hlsearch
set ignorecase
set smartcase
" set tab = 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2
set smarttab
" dont wrap text by default
set nolist
set nowrap
" dont write extra files
set nobackup
set nowritebackup
set noswapfile
" display current position
set cursorline
" always show status bar
set laststatus=2
" show position in status bar
set ruler
" set history length
if &history < 9999
  set history=9999
endif
set scrolloff=3
set cmdheight=2
set lazyredraw
set mouse=a
" fix ttymouse problems on very large screen resolutions
if has('mouse_sgr')
  set ttymouse=sgr
else
  set ttymouse=xterm2
endif
let &clipboard = has ('unnamedplus') ? 'unnamedplus' : 'unnamed'
set splitbelow splitright
set hidden
" }}}

" EXTRA CUSTOMIZATION {{{
"""""""""""""""""""""
set path=a.,,**
set fileignorecase
set autoread
set textwidth=0
set listchars=tab:\ \|,eol:¬,extends:…,precedes:…,trail:.,nbsp:·
" do not duplicate spaces after a join
set nojoinspaces
" removes comment 'leader' when joining lines
set formatoptions+=j
set linebreak
set number relativenumber
set foldmethod=marker
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
highlight! StatusLine ctermfg=15 ctermbg=0
highlight! StatusLineNC ctermfg=0 ctermbg=15
set statusline=%{ChangeStatuslineColor()}
set statusline+=%<\ 
set statusline+=%-3.3n\                       " bufno
set statusline+=%40F\                         " file+path
set statusline+=%h%m%r%w                      " flags(mod,ro,etc)
set statusline+=[%{strlen(&ft)?&ft:'none'},   " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},  " encoding
set statusline+=%{&fileformat}]               " format (unix,dos)
set statusline+=%=                            " right...
set statusline+=[%04l,%04v]\                  " linecol
set statusline+=(%L\ lines)                   " total

if !exists('g:loaded_matchparen') && findfile('plugin/matchparen.vim', &rtp) ==# ''
  runtime! macros/matchparen.vim
  DoMatchParen
endif
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

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
elseif executable("ag") 
  set grepprg=ag\ --nogroup\ --nocolor\ --smart-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("egrep")
  set grepprg=egrep\ .\ -rne
endif
" }}}

" NETRW{{{
"""""""
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_browse_split = 0
let g:netrw_liststyle=3
augroup netrw
  autocmd!
  autocmd FileType netrw setl bufhidden=wipe
augroup END
" }}}

" GUI SETUP {{{
"""""""""""
if has('gui_running')
  set guioptions=gt
  colorscheme desert
  set columns=100
  set lines=60
  set guifont=Input\ Regular:h18
endif
" }}}

" KEYMAPPING {{{
""""""""""""
nnoremap <space> <Nop>
let mapleader = " "
let g:mapleader = "\<Space>"

" MANDATORY ANTI <CTRL-U>
inoremap <C-U> <C-G>u<C-U>
" Nohighlight
nnoremap <expr> <leader><leader><leader> QfVisible() ? ":lclose<CR>:cclose<CR>" : ":noh<CR>"

" useful on spanish keyboard
" nnoremap gl <C-]>
" onoremap ª _
" nnoremap ª _
" nnoremap - /\v
" nnoremap _ ?\v
" xnoremap - /\v
" xnoremap _ ?\v
" onoremap - /\v
" onoremap _ ?\v

" WRAP:
nnoremap <expr>çli expand(&g:list) ? ":call Set_Spaces()<CR>" : ":call Set_Tabs()<CR>"
nnoremap çwr :set wrap! wrap?<CR>
nnoremap <expr>j expand(&l:wrap) == 1 ? "gj" : "j"
nnoremap <expr>k expand(&l:wrap) == 1 ? "gk" : "k"
nnoremap <expr>^ expand(&l:wrap) == 1 ? "g0" : "^"
nnoremap <expr>$ expand(&l:wrap) == 1 ? "g$" : "$"

" DONT JUMP WHEN JOINING LINES:
nnoremap J mzJ`z

" YOU WILL NEVER STOP, WON'T YOU?
nnoremap <Leader>rc :tabnew $MYVIMRC<CR>

" AUTOCOMPLETION:
inoremap <C-F> <C-X><C-F>
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" DONT MESS UP MY REGISTER
nnoremap x "_x
nnoremap c "_c

" Indent selection with TAB
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

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

" utilities to make splits on opening files/buffers
" vertical split
cnoremap <C-S> <Home>vertical s<End>
" horizontal split
cnoremap <C-X> <Home>s<End>
" new tab
cnoremap <C-T> <Home>tab<End>

" Grep pattern
nnoremap º :Search<CR>
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
  autocmd BufReadPost *.theme,*.module set ft=php
  autocmd Filetype php compiler php
  autocmd BufWritePost *.theme,*.module,*.php silent lmake! % | silent redraw! | lwindow
augroup END

" Verify if Quickfixlist or locationList are open
function! QfVisible() abort
  return len(filter(range(1,winnr('$')),'getwinvar(v:val, "&ft") == "qf"'))
endfunction

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

" Search for string in files
function! MySearch() abort
  let grep_term = input("Pattern: ")
  if !empty(grep_term)
    execute 'silent lgrep!' grep_term
    " silent prevents from opening first result
    execute 'lopen'
    " remap Ctrl-T, Ctrl-X and Ctrl-V to open splits/tabs
    nnoremap <buffer> <C-T> <C-W><CR><C-W>T
    nnoremap <buffer> <C-X> <C-W><CR>
    nnoremap <buffer> <C-V> <C-W><CR><C-W>L
    nnoremap <buffer> <Esc> :lclose<CR>
  else
    echo "No pattern provided"
  endif
  redraw!
endfunction

" Thanks romainl
" make list-like commands more intuitive
function! CCR()
  let cmdline = getcmdline()
  if cmdline =~ '\v\C^(ls|files|buffers)'
    " like :ls but prompts for a buffer command
    return "\<CR>:b"
  elseif cmdline =~ '\v\C/(#|nu|num|numb|numbe|number)$'
    " like :g//# but prompts for a command
    return "\<CR>:"
  elseif cmdline =~ '\v\C^(dli|il)'
    " like :dlist or :ilist but prompts for a count for :djump or :ijump
    return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
  elseif cmdline =~ '\v\C^(cli|lli)'
    " like :clist or :llist but prompts for an error/location number
    return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
  elseif cmdline =~ '\C^old'
    " like :oldfiles but prompts for an old file to edit
    set nomore
    return "\<CR>:sil se more|e #<"
  elseif cmdline =~ '\C^changes'
    " like :changes but prompts for a change to jump to
    set nomore
    return "\<CR>:sil se more|norm! g;\<S-Left>"
  elseif cmdline =~ '\C^ju'
    " like :jumps but prompts for a position to jump to
    set nomore
    return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
  elseif cmdline =~ '\C^marks'
    " like :marks but prompts for a mark to jump to
    return "\<CR>:norm! `"
  elseif cmdline =~ '\C^undol'
    " like :undolist but prompts for a change to undo
    return "\<CR>:u "
  else
    return "\<CR>"
  endif
endfunction
cnoremap <expr> <CR> CCR()

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

" PLUGINS {{{
"""""""""
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
  " Drupal Twig
  let g:surround_{char2nr("c")} = "{# \r #}"
  let g:surround_{char2nr("T")} = "{% trans %}\r{% endtrans %}"
  let g:surround_{char2nr("V")} = "{{ \r }}"
  let g:surround_{char2nr("v")} = "{% \r %}"
  " config END
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-abolish'
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
        \     'fun' : "function ${child} (|) {\r\r}",
        \     'puf' : "public function ${child} (|) {\r\r}",
        \     'pusf' : "public static function ${child} (|) {\r\r}",
        \     'psf' : "protected static function ${child} (|) {\r\r}",
        \     'pf' : "protected function ${child} (|) {\r\r}",
        \     'sf' : "static function ${child} (|) {\r\r}",
        \     'for' : "for (\$i = 0; \$i < |; $i++) {\r\t|\r}",
        \     'fore' : "foreach (\$${child} as \$${child}_element) {\r\t|\r}",
        \    },
        \ },
        \ }

  " if has fzf, use fzf
  if executable('fzf')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    " config:
    let g:fzf_layout = { 'down': '~20%' }
    let g:fzf_colors =
          \ { 'fg':      ['fg', 'normal'],
          \ 'bg':      ['bg', 'clear'],
          \ 'hl':      ['fg', 'string'],
          \ 'fg+':     ['fg', 'cursorline', 'cursorcolumn', 'normal'],
          \ 'bg+':     ['bg', 'cursorline', 'cursorcolumn'],
          \ 'hl+':     ['fg', 'statement'],
          \ 'info':    ['fg', 'preproc'],
          \ 'prompt':  ['fg', 'conditional'],
          \ 'pointer': ['fg', 'exception'],
          \ 'marker':  ['fg', 'keyword'],
          \ 'spinner': ['fg', 'label'],
          \ 'header':  ['fg', 'comment'] }

    if executable('rg')
      command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
            \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
            \   <bang>0)
    endif

    " MAPPINGS
    if !&diff
      augroup PluginMapping
        autocmd!
        autocmd VimEnter * call Maps_Plugins()
      augroup end
    endif

    function! Maps_Plugins() abort
      if exists(":FZF")
        exec 'nnoremap <leader>b :Buffers<CR>'
        exec 'nnoremap <leader>f :Files<CR>'
        if executable('rg')
          exec 'nnoremap º :Rg<space>'
        endif
        exec 'nnoremap <leader>F :History'
        exec 'nnoremap <leader>ts :Tags'
      endif
    endfunction
  endif

  " Language-specific utilities
  Plug 'sheerun/vim-polyglot'
  Plug 'fatih/vim-go'
  call plug#end()

endif
" }}}

