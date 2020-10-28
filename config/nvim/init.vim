" Global cofiguration file for all files.
" Every language has own configuration in ftplugin directory

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/l0k0123/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/l0k0123/.cache/dein')
  call dein#begin('/Users/l0k0123/.cache/dein')

  " Let dein manage dein
  call dein#add('/Users/l0k0123/.cache/dein/repos/github.com/Shougo/dein.vim')

  " UI for Dein
  call dein#add('wsdjeg/dein-ui.vim')

  " Global plugins:
  call dein#add('neomake/neomake')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('tpope/vim-obsession')
  call dein#add('scrooloose/syntastic')

  " Status bar plugins:
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " Go plugins:
  call dein#add('deoplete-plugins/deoplete-go', {'build': 'make'})
  call dein#add('fatih/vim-go')

  " Arduino plugins:
  call dein#add('stevearc/vim-arduino')

  " Pythong programming plugins:
  call dein#add('davidhalter/jedi-vim')
  call dein#add('jmcantrell/vim-virtualenv')
  call dein#add('nvie/vim-flake8')
  call dein#add('alfredodeza/coveragepy.vim')

  " Ansible plugins:
  call dein#add('pearofducks/ansible-vim')

  " Text editing plugins:
  call dein#add('gu-fan/riv.vim')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('JamshedVesuna/vim-markdown-preview')
  call dein#add('vim-scripts/DrawIt')
  call dein#add('vimwiki/vimwiki')

  " Theme plugins:
  call dein#add('dracula/vim')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('altercation/vim-colors-solarized')

  " Required:
  call dein#end()
  call dein#save_state()
endif

"End dein Scripts-------------------------


" Global tab size configuration
" ==============================
"set tabstop=4
"set shiftwidth=4
"set smarttab
"set expandtab


" Set global indentation method
" ==============================
set foldmethod=indent
set foldnestmax=1


" After saving .vimrc file automatically source it
" =================================================
autocmd! BufWritePost .vimrc source %


" Enable language-dependent indenting
" ====================================
filetype plugin indent on
syntax on


" Configure vim-airline
" =====================
let g:airline_theme='luna'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 1 " enable tmux integration


" General option
" ===============
let mapleader = "," " rebind <Leader> key
nnoremap . <NOP>
set title
set wildmode=list:longest " make TAB behave like in a shell
set autoread " reload file when changes happen in other editors
set tags=./tags
set mouse=a
set bs=2 " make backspace behave like normal again

" Sudo write this
" ================
cmap w! w !sudo tee % >/dev/null


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
" ====================================================================
set nobackup
set nowritebackup
set noswapfile


" Make yank copy to the global system clipboard
" ==============================================
set clipboard+=unnamedplus


" Improving code completion
" ==========================
set completeopt=longest,menuone


" Set working directory
" ======================
" nnoremap <leader>. :lcd %:p:h<CR>


" Remove trailing whitespace on <leader>S
" ========================================
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>


" Select the item in the list with enter
" =======================================
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" Quicksave command
" ==================
noremap <C-z> :update<CR>
vnoremap <C-z> <C-C>:update<CR>
inoremap <C-z> <C-O>:update<CR>


" Quick quit command
" ===================
noremap <Leader>e :quit<CR>


" Bind nohl
" ==========
noremap <C-n> :nohl<CR>


" History level settings
" =======================
set history=700
set undolevels=700


" Disable formatting when pasting large chunks of code
" =====================================================
set pastetoggle=<F2>


" Searching configuration
" ========================
set hlsearch
set incsearch
set ignorecase
set smartcase


" Text wrap, document lenght configuration and line numbers
" ==========================================================
set nowrap " don't automatically wrap on load
"set tw=79  " width of document (used by gd)
"set cc=80  " line on specific column
set fo-=t  " don't automatically wrap text when typing
set relativenumber " show line numbers in files
set number " current line show line number from file


" Easier formatting of paragraphs
" ================================
vmap Q gq
nmap Q gqap


" Movement
" =========
" bind Ctrl+<movement> keys to move around the windows,
" instead of using Ctrl+w + <movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <Leader>, <esc>:tabprevious<CR>
map <Leader>. <esc>:tabnext<CR>
vnoremap <Leader>s :sort<CR>


" Indentation and select
" ================
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation
map <Leader>a ggVG  " select all


" Reload init.vim file
" ===================
map <Leader>v :source ~/.config/nvim/init.vim


" Show trailing whitespace
" =========================
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" map <Leader>x :%s/\s\+$//


" Setting quickfix window size
" =============================
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction


" Settings for jedi-vim
" =====================
let g:jedi#usages_command = "<leader>n"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1

" Fix autocompletion pop up colors
hi Pmenu ctermbg=black ctermfg=white
hi PmenuSel ctermbg=white ctermfg=black


" Settings for vim-powerline
" ===========================
set laststatus=2
" let g:Powerline_symbols = 'fancy'


" Setting for RIV
" ===============
let base = { 'Name': 'Main project', 'path': '~/Documents/riv'}
let digarden = {'Name': 'DiGarden', 'path': '~/src/digarden'}
let g:riv_projects = [base, digarden]
let g:riv_auto_format_table = 0


" Settings for jedi-vim
" =====================
let g:jedi#force_py_version = 3


" Settings for vim-markdown
" ==========================
" let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1


" Settings for vim-markdown-preview
" ==================================
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1


" Settings for ctrlp
" ===================
let g:ctrlp_max_height = 30
let g:ctrlp_working_path_mode = 'ra'


" Move using <C-j> and <C-k> between OmniPopup options
" found here: http://stackoverflow.com/a/2170800/70778
" =====================================================
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction
inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" Configure Neomake to be usable
" ===============================
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 1


" Speed up CtrlP execution time
" ==============================
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
    \ --ignore .git
    \ --ignore .svn
    \ --ignore .hg
    \ --ignore .DS_Store
    \ --ignore "**/*.pyc"
    \ --ignore .tox
    \ --ignore .bundle
    \ --ignore __pycache__
    \ -g ""'


" Use deoplete
" =============
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
