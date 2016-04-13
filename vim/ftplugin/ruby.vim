" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
finish
endif
let b:did_ftplugin = 1

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
" disable formatting when pasting large chunks of code
set pastetoggle=<F2>

set hlsearch
set incsearch
set ignorecase
set smartcase

set nowrap " don't automatically wrap on load
set tw=79  " width of document (used by gd)
set fo-=t  " don't automatically wrap text when typing
set number
