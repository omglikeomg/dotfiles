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
  set smartindent " This is often a good default. Neovim might behave slightly differently with 'autoindent' vs 'smartindent' in some cases, but this is fine.
endif
" set smartindent " You have this twice, the if-block above already sets it. Redundant but harmless.
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
  " Neovim often provides good completion out-of-the-box via LSP,
  " but syntaxcomplete can be a fallback.
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
set nolist " This will be toggled by your çli mapping and Set_Spaces/Set_Tabs functions
set nowrap
" dont write extra files
set nobackup
set nowritebackup
set noswapfile " Good for Neovim too.
" always show status bar
set laststatus=2
" show position in status bar
set ruler
" set history length
if &history < 1000
  set history=1000 " Neovim has a separate shada file for history, but this Vim setting is still respected for command-line history.
endif
set scrolloff=3
set cmdheight=2
set lazyredraw
set mouse=a " This is default in Neovim, but explicit setting is fine.
" Clipboard: Neovim usually prefers 'unnamedplus' if a clipboard tool (xclip, wl-copy, pbcopy) is found.
" This logic is perfectly fine.
let &clipboard = has ('unnamedplus') ? 'unnamedplus' : 'unnamed'
set splitbelow splitright
" }}}

" EXTRA CUSTOMIZATION {{{
"""""""""""""""""""""
set hidden
set path=.,,** " Note: Neovim's default path is often more comprehensive. This overrides it.
set fileignorecase " Useful, especially if you work across OSes.
set autoread " Good. Consider `autocmd FocusGained,BufEnter * checktime` for more robustness if files change outside Neovim.
set textwidth=0
set listchars=tab:\ \|,eol:¬,extends:…,precedes:…,trail:.,nbsp:·
set linebreak
" set number relativenumber " This is commented out, same as original.
set foldmethod=marker
let g:currentmode={
    \ 'n'  : 'N ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'V ',
    \ 'V'  : 'V·Line ',
    \ '' : 'V·Block ', " Ctrl-V in Vim, represents visual block mode
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '' : 'S·Block ', " Ctrl-S related in Vim, might be less common
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
    \ }
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
set statusline+=\%{fugitive#statusline()} " Requires vim-fugitive
" linecol
set statusline+=[%04l,%04v]\ 
" total
set statusline+=%L\ lines

" Neovim includes an improved version of matchit. It's usually enabled by default.
" This block might not be necessary. Test if '%' works on HTML tags, if/else blocks, etc. without it.
" If it doesn't, you might need `packadd! matchit` if using package manager, or ensure it's loaded.
" For now, keeping it, but it's a point to check.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("ag") 
  set grepprg=ag\ --nogroup\ --nocolor\ --smart-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("egrep") " Note: 'grep' is more common than 'egrep' as a fallback.
                          " Using 'grep -E' is equivalent to 'egrep'.
  let &grepprg='grep -n -R --exclude=' . shellescape(&wildignore) . ' $*'
endif

" Check for specific patch versions is usually fine, Neovim keeps up with Vim patches.
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
augroup netrw_settings " Changed augroup name slightly to avoid potential global namespace collision, good practice
  autocmd!
  autocmd FileType netrw setl bufhidden=wipe
augroup END
" }}}

" KEYMAPPING {{{
""""""""""""
nnoremap <space> <Nop>
let mapleader = " "
" let g:mapleader = "\<Space>" " Setting mapleader is enough, g:mapleader is for checking its value. Redundant but harmless.

" MANDATORY ANTI <CTRL-U>
inoremap <C-U> <C-G>u<C-U>
" Nohighlight
nnoremap <expr> <leader><leader><leader> QfVisible() ? ":lclose<CR>:cclose<CR>" : ":noh<CR>"

" useful on spanish keyboard
nnoremap gl <C-]> " This jumps to tag definition, useful.
" nnoremap ª _ " Commented out as in original
" nnoremap - /\v
" nnoremap _ ?\v
" xnoremap ª _
" xnoremap - /\v
" xnoremap _ ?\v
" onoremap ª _
" onoremap - /\v
" onoremap _ ?\v

" WRAP:
nnoremap <expr>çli expand(&g:list) ? ":call Set_Spaces()<CR>" : ":call Set_Tabs()<CR>" " Assuming 'ç' is intended
nnoremap çwr :set wrap! wrap?<CR>
nnoremap <expr>j expand(&l:wrap) == 1 ? "gj" : "j"
nnoremap <expr>k expand(&l:wrap) == 1 ? "gk" : "k"
nnoremap <expr>^ expand(&l:wrap) == 1 ? "g0" : "^" " Note: ^ is usually 'g^' when wrapped, 0 is g0. This makes ^ always behave like g0 if wrapped.
nnoremap <expr>$ expand(&l:wrap) == 1 ? "g$" : "$"
vnoremap <expr>j expand(&l:wrap) == 1 ? "gj" : "j"
vnoremap <expr>k expand(&l:wrap) == 1 ? "gk" : "k"
vnoremap <expr>^ expand(&l:wrap) == 1 ? "g0" : "^"
vnoremap <expr>$ expand(&l:wrap) == 1 ? "g$" : "$"

" DONT JUMP WHEN JOINING LINES:
nnoremap J mzJ`z

" YOU WILL NEVER STOP, WON'T YOU?
" For Neovim, the config is typically ~/.config/nvim/init.vim
" You can set MYVIMRC in your shell: export MYVIMRC="$HOME/.config/nvim/init.vim"
" Or change the mapping:
nnoremap <leader>rc :tabnew $MYVIMRC<CR> " Make sure $MYVIMRC points to your init.vim
" Alternatively, for a more robust Neovim way:
" nnoremap <leader>rc :tabnew <span class="math-inline">XDG\_CONFIG\_HOME/nvim/init\.vim<CR\> " If XDG\_CONFIG\_HOME is set
" nnoremap <leader\>rc \:execute 'tabnew ' \. stdpath\('config'\) \. '/init\.vim'<CR\> " Neovim specific
" AUTOCOMPLETION\:
inoremap <C\-F\> <C\-X\><C\-F\> " Built\-in file completion
inoremap <expr\> <Esc\>      pumvisible\(\) ? "\\<C\-e\>" \: "\\<Esc\>"
inoremap <expr\> <CR\>        pumvisible\(\) ? "\\<C\-y\>" \: "\\<CR\>"
inoremap <expr\> <Down\>      pumvisible\(\) ? "\\<C\-n\>" \: "\\<Down\>"
inoremap <expr\> <Up\>        pumvisible\(\) ? "\\<C\-p\>" \: "\\<Up\>"
inoremap <expr\> <PageDown\> pumvisible\(\) ? "\\<PageDown\>\\<C\-p\>\\<C\-n\>" \: "\\<PageDown\>"
inoremap <expr\> <PageUp\>   pumvisible\(\) ? "\\<PageUp\>\\<C\-p\>\\<C\-n\>" \: "\\<PageUp\>"
" DONT MESS UP MY REGISTER
nnoremap x "\_x
nnoremap c "\_c
" Indent selection with TAB
vnoremap <Tab\> \>gv
vnoremap <S\-Tab\> <gv
" Select all mapping
nnoremap <leader\>a ggVG
" SWAP TO LAST USED TAB
" This requires g\:lasttab to be set\. Vim usually handles this with 'buftabline' or similar\.
" You might need an autocommand to set g\:lasttab on TabLeave\.
" autocmd TabLeave \* let g\:lasttab \= tabpagenr\(\)
nnoremap <Leader\>t<Leader\> \:exe "tabn "\.g\:lasttab<CR\>
" LIST BUFFERS, OPEN BUFFERS
nnoremap <leader\>b \:ls<CR\>\:b<space\>
nnoremap <leader\>B \:b \#<CR\> " Switch to alternate buffer
" files
nnoremap <leader\>f \:find \* " This will search based on your 'path' setting\.
nnoremap <leader\>e \:Ex<CR\> " Open Netrw in current directory
" utilities to make splits on opening files/buffers
cnoremap <C\-S\> <Home\>vertical s<End\> " For commands like \:e, \:find
cnoremap <C\-X\> <Home\>s<End\>
cnoremap <C\-T\> <Home\>tab<End\>
nnoremap <leader\>wd \:echo expand\('%\:h'\)<CR\> " Echo current file's directory
" Grep pattern
nnoremap \~ \:Search<CR\> " Calls your custom Search command \(defined later\)
" \}\}\}
" HELPERS \{\{\{
"""""""""
" remember last position on a file
augroup RestoreCursorPosition
autocmd\!
autocmd BufReadPost \* if line\("'\\""\) \> 1 && line\("'\\""\) <\= line\("</span>") | exe "normal! g`\"" | endif " Corrected to g`\" to also restore column
augroup END

" display current on current buffer
augroup CursorLineHighlight
  autocmd!
  autocmd BufEnter,WinEnter * setlocal cursorline
  autocmd BufLeave,WinLeave * setlocal nocursorline
augroup END

augroup TwigSyntaxOverride
  autocmd!
  autocmd Filetype twig set ft=html " This might interfere with twig-specific syntax/LSP if you use them.
                                  " vim-polyglot or specific twig plugins usually handle this better.
augroup END
augroup DrupalFiletypes
  autocmd!
  autocmd BufReadPost *.theme,*.module set ft=php
  autocmd Filetype php compiler php " This relies on a compiler script for php.
  autocmd BufWritePost *.theme,*.module,*.php silent lmake! % | silent redraw! | lwindow " Uses :lmake
augroup END

" augroup TS (Commented out as in original)
" ...
" augroup END

" Verify if Quickfixlist or locationList are open
function! QfVisible() abort
  return len(filter(range(1,winnr('<span class="math-inline">'\)\),'getwinvar\(v\:val, "&ft"\) \=\= "qf"'\)\)
endfunction
augroup DiffCustomColors
autocmd\!
autocmd FilterWritePre \* if &diff \| color apprentice \| endif " Sets colorscheme for diffs
augroup END
" Open list of oldfiles as something interactionable\:
command\! MostRecent vnew \+setl\\ buftype\=nofile \| 0put \=v\:oldfiles
\\ \| nnoremap <buffer\> <CR\> \:e <C\-r\>\=getline\('\.'\)<CR\><CR\>
" FUNCTION TO SAVE AS SPACES AND SEE AS TABS
function\! Set\_Tabs\(\) abort
if\(&expandtab\) " if using spaces
setlocal noexpandtab " Use setlocal if you want this per\-buffer
" and retab it
exec 'keepjumps %retab\!'
" then show listchars
setlocal list
endif
endfunction
" TODO\: find out how not to write the changes to the changelist so you don't
" have to undo twice after saving if you mess up\. \(This is a general Vim challenge with \:retab\)
function\! Set\_Spaces\(\) abort
if \(\!&expandtab\) " if using tabs \(original had &g\:expandtab \=\= 0\)
setlocal expandtab " Use setlocal
" and retab it
exec 'keepjumps %retab'
" then hide listchars
setlocal nolist
endif
endfunction
function\! ChangeStatuslineColor\(\)
if \(mode\(\) \=\~\# '\\v\(n\|no\)'\)
exe 'hi\! StatusLine ctermfg\=15 ctermbg\=0 guibg\=\#EEEEEE guifg\=\#080002'
elseif \(mode\(\) \=\~\# '\\v\(v\|V\)' \|\| mode\(\) \=\=\# "\\<C\-v\>" \|\| g\:currentmode\[mode\(\)\] \=\=\# 'V·Block' \|\| get\(g\:currentmode, mode\(\), ''\) \=\=\# 't'\) " Fixed check for visual block
exe 'hi\! StatusLine ctermfg\=3 ctermbg\=0 guibg\=\#EAE27C guifg\=\#080002'
elseif \(mode\(\) \=\=\# 'i'\)
exe 'hi\! StatusLine ctermfg\=1 ctermbg\=0 guibg\=\#F08C46 guifg\=\#080002'
else
exe 'hi\! StatusLine ctermfg\=2 ctermbg\=0 guibg\=\#EEEEEE guifg\=\#080002' " Default color
endif
return ''
endfunction
" Open list of oldfiles as something interactionable\:
" command\! MostRecent \.\.\. " This is duplicated, remove one\.
" Search for string in files
function\! MySearch\(\) abort
let grep\_term \= input\("Pattern\: "\)
if \!empty\(grep\_term\)
execute 'silent lgrep\!' grep\_term " \:lgrep uses &grepprg
" silent prevents from opening first result
execute 'lopen'
" remap Ctrl\-T, Ctrl\-X and Ctrl\-V to open splits/tabs
nnoremap <buffer\> <silent\> <CR\> <C\-W\><CR\><C\-W\>K " Open in preview, then move to it\. Or just <C\-W\><CR\> to open and stay\.
nnoremap <buffer\> <silent\> <C\-T\> <C\-W\><CR\><C\-W\>T
nnoremap <buffer\> <silent\> <C\-X\> <C\-W\><CR\><C\-W\>s " <C\-W\>s is horizontal split
nnoremap <buffer\> <silent\> <C\-V\> <C\-W\><CR\><C\-W\>v " <C\-W\>v is vertical split
nnoremap <buffer\> <silent\> <Esc\> \:lclose<CR\>
else
echo "No pattern provided"
endif
redraw\!
endfunction
command\! Search call MySearch\(\)
" Thanks romainl
" make list\-like commands more intuitive
function\! CCR\(\)
let cmdline \= getcmdline\(\)
if cmdline \=\~ '\\v\\C^\(ls\|files\|buffers\)'
return "\\<CR\>\:b " " Added space after \:b for convenience
elseif cmdline \=\~ '\\v\\C/\(\#\|nu\|num\|numb\|numbe\|number\)</span>'
    return "\<CR>:"
  elseif cmdline =~ '\v\C^(dli|il)'
    return "\<CR>:" . cmdline[0] . "j " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
  elseif cmdline =~ '\v\C^(cli|lli)'
    return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
  elseif cmdline =~ '\C^old'
    set nomore
    return "\<CR>:sil se more|e #<"
  elseif cmdline =~ '\C^changes'
    set nomore
    return "\<CR>:sil se more|norm! g;\<S-Left>"
  elseif cmdline =~ '\C^ju'
    set nomore
    return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
  elseif cmdline =~ '\C^marks'
    return "\<CR>:norm! `"
  elseif cmdline =~ '\C^undol'
    return "\<CR>:u "
  else
    return "\<CR>"
  endif
endfunction
cnoremap <expr> <CR> CCR()


" Function to install vim-plug
" IMPORTANT: Paths for Neovim are different.
" plug.vim itself should go into stdpath('data').'/site/autoload/plug.vim'
" e.g. ~/.local/share/nvim/site/autoload/plug.vim
function! InstallPlug() abort
  let l:plug_path = stdpath('data') . '/site/autoload/plug.vim'
  if empty(glob(l:plug_path))
    if executable('curl')
      echomsg "Attempting to install vim-plug to: " . l:plug_path
      silent execute '!curl -fLo ' . shellescape(l:plug_path) . ' --create-dirs ' .
            \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
      if v:shell_error
        echohl ErrorMsg
        echomsg "vim-plug download failed. Please install it manually to " . l:plug_path
        echohl None
        return 0
      else
        " After successful download, you might need to source it or restart Neovim
        " for plug#begin to be found in the same session.
        echomsg "vim-plug downloaded. Restart Neovim or manually source " . l:plug_path
        return 1 " Return 1 to indicate potential success but action needed
      endif
    else
      echomsg 'Cannot install vim-plug. Install curl first, or install vim-plug manually to: ' . l:plug_path
      return 0
    endif
  endif
  return 1 " Already installed or no action needed
endfunction

" We'll call InstallPlug conditionally before plug#begin
" command! -bar InstallPlug call InstallPlug(has('win32')) " This command isn't strictly needed if we call the function directly.
" }}}

" PLUGINS {{{
""""""""""""""
" Attempt to install vim-plug if not present
if !exists('*plug#begin') " Check if plug#begin function exists
  if !InstallPlug()
    echohl ErrorMsg
    echo "vim-plug is not installed and auto-installation failed. Plugins will not be loaded."
    echo "Please install vim-plug manually and restart Neovim."
    echohl None
    finish " Stop processing further if plug can't be set up
  else
    " If InstallPlug just downloaded plug.vim, it needs to be sourced to define plug#begin
    " This is a bit tricky mid-script. A restart is the most reliable.
    " For now, we assume if InstallPlug succeeded and plug.vim exists, it MIGHT be sourceable.
    " The safest bet is for the user to restart after the first run if plug.vim was downloaded.
    " Or, you can try sourcing it:
    " execute 'source ' . shellescape(stdpath('data') . '/site/autoload/plug.vim')
    " However, for simplicity and robustness, this example will rely on restart if plug.vim was freshly installed.
  endif
endif

" IMPORTANT: Change plug#begin path for Neovim.
" It usually is stdpath('data') . '/plugged' -> ~/.local/share/nvim/plugged
call plug#begin(stdpath('data') . '/plugged')

  Plug 'tpope/vim-repeat' 
  Plug 'tpope/vim-commentary'
  " config:
  autocmd FileType php setlocal commentstring=//\ %s
  autocmd FileType html.twig setlocal commentstring={#\ %s\ #}
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
  endfunction
  " config END

  " VimWiki as a way to take notes
  Plug 'vimwiki/vimwiki'

  " UNNECESSARY COMMODITIES
  Plug 'kkoomen/vim-doge'
  Plug 'mattn/emmet-vim'
  Plug 'SirVer/ultisnips'
  Plug 'inkarkat/vim-ingo-library' " Dependency for some inkarkat plugins
  Plug 'inkarkat/vim-mark'       " Requires vim-ingo-library
  Plug 'honza/vim-snippets' " Snippets for UltiSnips
  let g:UltiSnipsExpandTrigger="<c-a>"
  let g:UltiSnipsJumpForwardTrigger="<c-b>"
  let g:UltiSnipsJumpBackwardTrigger="<c-z>"

  " " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"
  " For Neovim, consider placing snippets in ~/.config/nvim/UltiSnips or another path within stdpath('config')
  let g:UltiSnipsSnippetDirectories=[stdpath('config').'/UltiSnips', 'UltiSnips'] " Added 'UltiSnips' for project-local snippets
  " Original: let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
  " You can keep the old path if you share snippets with Vim, or migrate them.
  " For a clean Neovim setup:
  " let g:UltiSnipsSnippetDirectories=[stdpath('config') . '/UltiSnips']
  " Ensure this directory exists: mkdir -p ~/.config/nvim/UltiSnips
  " this trick has proven more useful than expected
  imap ,, <plug>(emmet-expand-abbr) " emmet-vim specific mapping

  let g:user_emmet_settings = {
        \   'php' : {
        \     'snippets' : {
        \       'ake' : "array_key_exists(|)",
        \       'pm' : "preg_match(|)",
        \       'ps' : "preg_replace(|)",
        \       'fun' : "function ${child} (|) {\r\r}",
        \       'puf' : "public function ${child} (|) {\r\r}",
        \       'pusf' : "public static function ${child} (|) {\r\r}",
        \       'psf' : "protected static function ${child} (|) {\r\r}",
        \       'pf' : "protected function ${child} (|) {\r\r}",
        \       'sf' : "static function <span class="math-inline">\{child\} \(\|\) \{\\r\\r\}",
\\       'for' \: "for \(\\$i \= 0; \\$i < \|; \\$i\+\+\) \{\\r\\t\|\\r\}",
\\       'fore' \: "foreach \(\\$</span>{child} as \$${child}_element) {\r\t|\r}",
        \     },
        \   },
        \ }

  " if has fzf, use fzf
  if executable('fzf')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " This assumes fzf is cloned to ~/.fzf
    Plug 'junegunn/fzf.vim'
    " config:
    let g:fzf_preview_window = ['up:50%', 'ctrl-/']
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
    " fzf colors should work fine.
    let g:fzf_colors =
          \ { 'fg':      ['fg', 'Normal'],
          \ 'bg':      ['bg', 'Normal'],
          \ 'hl':      ['fg', 'Statement'],
          \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
          \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
          \ 'hl+':     ['fg', 'Statement'],
          \ 'info':    ['fg', 'PreProc'],
          \ 'prompt':  ['fg', 'Conditional'],
          \ 'pointer': ['fg', 'Exception'],
          \ 'marker':  ['fg', 'Keyword'],
          \ 'spinner': ['fg', 'Label'],
          \ 'header':  ['fg', 'Comment'] }

    if executable('rg')
      command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0) " Adjusted preview options
    endif

  " MAPPINGS
    if !&diff
      augroup FZFPluginMappings " Renamed augroup
        autocmd!
        autocmd VimEnter * call Maps_Plugins() " VimEnter might be too early if plugins aren't fully loaded. Consider User PlugLoaded or similar.
                                             " Or simply define mappings directly if fzf is guaranteed.
      augroup end
    endif

    function! Maps_Plugins() abort
      if exists(":FZF") " Check if FZF command is available (from fzf.vim)
        exec 'nnoremap <silent> <leader>b :Buffers<CR>'
        exec 'nnoremap <silent> <leader>f :Files<CR>'
        if executable('rg') && exists(":Rg") " Check if your Rg command exists
          exec 'nnoremap <silent> ~ :Rg<space>'
        endif
        exec 'nnoremap <silent> <leader>F :History<CR>' " fzf.vim :History
        exec 'nnoremap <silent> <leader>ts :Tags<CR>'  " fzf.vim :Tags
        command! FZFMru call fzf#run({
              \  'source':  v:oldfiles,
              \  'sink':    'e',
              \  'options': '-m -x +s --preview "bat --color=always --style=numbers --line-range :50 {}"', " Added preview if bat is available
              \  'down':    '40%'})
        " let g:fzf_layout = { 'window': 'enew' } " This was inside the function, affecting only FZFMru locally if not global before.
                                                " It's better to set g:fzf_layout outside if it's a general preference.
      endif
    endfunction
    " Consider calling Maps_Plugins() once after plug#end if VimEnter doesn't work as expected.
    " Or define mappings directly here, guarded by if executable('fzf')

    " This function seems to be for Vimwiki, not directly FZF. Move it if so.
    " function! MapVimWiki() abort
    "   if exists(":VimwikiVSplitLink") " Assuming this comes from Vimwiki
    "     exec 'nnoremap <leader>> <Plug>VimwikiVSplitLink'
    "     exec 'nnoremap <leader>v <Plug>VimwikiSplitLink'
    "   endif
    " endfunction
    " autocmd User VimwikiLoaded call MapVimWiki() " Example of a better trigger

  endif " End of if executable('fzf')

    " Colors for gui (and TUI)
    Plug 'sainnhe/vim-color-forest-night' " This seems to be a duplicate of termlimit/vim-color-forest-night or vice-versa. Pick one.
    Plug 'liuchengxu/space-vim-theme'
    Plug 'vim-scripts/norwaytoday' " Older script from vim.org, might be less maintained.
    Plug 'romainl/Apprentice'
    Plug 'termlimit/vim-color-forest-night'
    Plug 'sainnhe/everforest'
    Plug 'arcticicestudio/nord-vim'

    " Language
