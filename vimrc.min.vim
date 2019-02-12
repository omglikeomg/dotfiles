set bg=dark
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
set tabstop=4
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
if &history < 1000
  set history=1000
endif
