" .vimrc
" By Demian Molinari - omglikeomg
" Last changes done on Jan 2019
"
" BASIC {{{
" 
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
if has('autocmd')
  filetype plugin on
  filetype indent on
endif
set bs=2
set autoindent
if has('smartindent')
  set smartindent
endif
set smartindent
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
" set tab = 4 spaces
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
" always show status bar
set laststatus=2
" show position in status bar
set ruler
" set history length
if &history < 1000
  set history=1000
endif
set scrolloff=3
set cmdheight=2
set lazyredraw
set mouse=a
let &clipboard = has ('unnamedplus') ? 'unnamedplus' : 'unnamed'
set splitbelow splitright
" }}}

" EXTRA CUSTOMIZATION {{{
"""""""""""""""""""""
set hidden
set path=a.,,**
set fileignorecase
set autoread
set textwidth=0
set listchars=tab:\ \|,eol:¬,extends:…,precedes:…,trail:.,nbsp:·
set linebreak
" set number relativenumber
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
hi! StatusLine ctermfg=15 ctermbg=0
hi! StatusLineNC ctermfg=0 ctermbg=7
" color statusline
set statusline=%{ChangeStatuslineColor()}
" bufno
set statusline+=%-3.3n
" file+path
set statusline+=%f\ 
" flags(mod,ro,etc)
set statusline+=%h%m%r%w%<\
" [filetype
set statusline+=[%{strlen(&ft)?&ft:'none'}\|
" encoding
set statusline+=%{strlen(&fenc)?&fenc:&enc}\|
" format (unix,dos)]
set statusline+=%{&fileformat}]
" right...
set statusline+=%=
" fugitive status line
set statusline+=\%{fugitive#statusline()}
" linecol
set statusline+=[%04l,%04v]\ 
" total
set statusline+=%L\ lines

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
  let &grepprg='grep -n -R --exclude=' . shellescape(&wildignore) . ' $*'
endif

if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
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
nnoremap gl <C-]>
" nnoremap ª _
" nnoremap - /\v
" nnoremap _ ?\v
" xnoremap ª _
" xnoremap - /\v
" xnoremap _ ?\v
" onoremap ª _
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

nnoremap <leader>wd :echo<space>expand('%:h')<CR>

" Grep pattern
nnoremap ~ :Search<CR>
" }}}

" HELPERS {{{
"""""""""
" remember last position on a file
augroup Restorepos
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" display current on current buffer
augroup Cursorline
  autocmd!
  autocmd BufEnter * setlocal cursorline
  autocmd BufLeave * setlocal nocursorline
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

" augroup TS
"   autocmd!
"   autocmd Filetype typescript,typescriptreact set makeprg=npm\ run\ --silent\ lint:compact
"   autocmd Filetype typescript,typescriptreact set errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#
"   " autocmd Filetype typescript,typescriptreact set errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %trror\ -\ %m
"   " autocmd Filetype typescript,typescriptreact set errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %tarning\ -\ %m
"   autocmd BufWritePost *.tsx,*.ts silent lmake! % | silent redraw! | lwindow
" augroup END

" Verify if Quickfixlist or locationList are open
function! QfVisible() abort
  return len(filter(range(1,winnr('$')),'getwinvar(v:val, "&ft") == "qf"'))
endfunction

augroup DiffColors
  autocmd!
  autocmd FilterWritePre * if &diff | color apprentice | endif
augroup END

" Open list of oldfiles as something interactionable:
command! MostRecent vnew +setl\ buftype=nofile | 0put =v:oldfiles
      \| nnoremap <buffer> <CR> :e <C-r>=getline('.')<CR><CR>

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
    if executable('curl')
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
      echomsg 'Cannot install Vim-Plug. Install curl first'
    endif
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
  " config:
  autocmd Filetype php setlocal commentstring=//\ %s
  autocmd Filetype html.twig setlocal commentstring={#\ %s\ #}
  Plug 'tpope/vim-surround'
  " config:
  let g:surround_{char2nr("¡")} = "¡\r!"
  let g:surround_{char2nr("¿")} = "¿\r?"
  " Drupal Twig
  let g:surround_{char2nr("T")} = "{% trans %}\r{% endtrans %}"
  let g:surround_{char2nr("V")} = "{{ \r }}"
  let g:surround_{char2nr("v")} = "{% \r %}"
  let g:surround_{char2nr("c")} = "{# \r #}"
  " config END
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-vinegar'
  Plug 'godlygeek/tabular'
  Plug 'editorconfig/editorconfig-vim'
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

  " VimWiki as a way to take notes
  Plug 'vimwiki/vimwiki'

  " UNNECESSARY COMMODITIES
  Plug 'kkoomen/vim-doge'
  Plug 'mattn/emmet-vim'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"

  " " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"
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
    let g:fzf_preview_window = ['up:50%', 'ctrl-/']
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
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
            \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)
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
          exec 'nnoremap ~ :Rg<space>'
        endif
        exec 'nnoremap <leader>F :History<CR>'
        exec 'nnoremap <leader>ts :Tags<CR>'
        command! FZFMru call fzf#run({
              \  'source':  v:oldfiles,
              \  'sink':    'e',
              \  'options': '-m -x +s',
              \  'down':    '40%'})
        let g:fzf_layout = { 'window': 'enew' }
      endif
    endfunction
  endif

    " Colors for gui
    Plug 'sainnhe/vim-color-forest-night'
    Plug 'liuchengxu/space-vim-theme'
    Plug 'vim-scripts/norwaytoday'
    Plug 'romainl/Apprentice'
    Plug 'termlimit/vim-color-forest-night'
    Plug 'sainnhe/everforest'
    Plug 'arcticicestudio/nord-vim'

    " Language-specific utilities
    Plug 'sheerun/vim-polyglot'
    let g:polyglot_disabled = ['vue']
    Plug 'fatih/vim-go'
    Plug 'aklt/plantuml-syntax'

    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    let g:limelight_conceal_ctermfg = 240
    augroup GoyoStuff
      autocmd!
      autocmd User GoyoEnter Limelight
      autocmd User GoyoLeave Limelight!
    augroup END

    " COC NVIM & config
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['js', 'ts', 'javascript', 'typescript', 'tsx', 'jsx', 'typescriptreact', 'javascriptreact']}
    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    function! SetCocStuff() abort
      set updatetime=300
      " Don't pass messages to |ins-completion-menu|.
      set shortmess+=c
      " Use `[g` and `]g` to navigate diagnostics
      " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)
      " GoTo code navigation.
      nmap <silent> <leader>gd :call CocAction('jumpDefinition', 'vsplit')<CR>
      nmap <silent> <leader>gy <Plug>(coc-type-definition)
      nmap <silent> <leader>gi <Plug>(coc-implementation)
      nmap <silent> <leader>gr <Plug>(coc-references)
      nmap <silent> <leader>gf <Plug>(coc-codeaction-cursor)
      " Use c-e to see element description
      inoremap <silent><expr> <C-e> coc#refresh()
      nnoremap <silent><expr> <C-e> coc#refresh()
      " No warns at startup
      let g:coc_disable_startup_warning=1
      " Add `:Format` command to format current buffer.
      command! -nargs=0 Format :call CocAction('format')
      " Add `:OR` command for organize imports of the current buffer.
      command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
      " Formatting selected code.
      xmap <leader>f  <Plug>(coc-format-selected)
      " Mappings for CoCList
      " Show all diagnostics.
      nnoremap <silent><nowait> <space>cD  :<C-u>CocList diagnostics<cr>
      " Manage extensions.
      nnoremap <silent><nowait> <space>ce  :<C-u>CocList extensions<cr>
      " Show commands.
      nnoremap <silent><nowait> <space>cc  :<C-u>CocList commands<cr>
      " Find symbol of current document.
      nnoremap <silent><nowait> <space>co  :<C-u>CocList outline<cr>
      " Search workspace symbols.
      nnoremap <silent><nowait> <space>cs  :<C-u>CocList -I symbols<cr>
      " Do default action for next item.
      nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
      " Do default action for previous item.
      nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
      " Resume latest coc list.
      nnoremap <silent><nowait> <space>cp  :<C-u>CocListResume<CR>
      " Use CodeLens
      nnoremap <silent> <space>cl  <Plug>(coc-config-codeLens-enable)
      " Symbol renaming.
      nmap <leader>rn <Plug>(coc-rename)
      " Remap keys for applying codeAction to the current buffer.
      nmap <leader>ac  <Plug>(coc-codeaction)
      " Apply AutoFix to problem on the current line.
      nmap <leader>qf  <Plug>(coc-fix-current)
      " Run the Code Lens action on the current line.
      nmap <leader>cl  <Plug>(coc-codelens-action)
      " Use K to show documentation in preview window.
      nnoremap <silent> K :call ShowDocumentation()<CR>
      " Highlight the symbol and its references when holding the cursor.
    endfunction
    " COC EXTRAS
    augroup cocFormatGroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,javascript,javascriptreact,typescriptreact,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
      autocmd CursorHold * if count(['c','cpp','python'],&filetype) | silent call CocActionAsync('highlight') | endif
    augroup end
    function! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
      else
        call feedkeys('K', 'in')
      endif
    endfunction

    augroup Vue
      autocmd!
      autocmd BufReadPost *.vue set ft=html
    augroup END
    call plug#end()

    augroup CocEnabled
      autocmd!
      autocmd FileType typescript,javascript,javascriptreact,typescriptreact,json call SetCocStuff()
    augroup END


  endif
  " }}}

  color megrim
  " GUI SETUP {{{
  """""""""""
  if has('gui_running')
    set guioptions=gt
    colorscheme norwaytoday
    set columns=140
    set lines=70
    set guifont=Input-Regular:h12
  endif
  " }}}
