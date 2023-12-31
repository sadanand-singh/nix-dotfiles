" Options
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set cmdheight=1
set noshowmode " Hide INSERT/VISUAL messages
set mouse=a " Copy selected text with mouse to system clipboard
set undofile " Save undos after file closes
set wildmode=longest:list,full " Complete longest common string, then each full match
set updatetime=250 " If this many milliseconds nothing is typed the swap file will be written to disk
set visualbell " Turn off the audio bell (no beeps)
set clipboard^=unnamed  " Make copy work with system clipboard
set gdefault " Always do global substitutions
set title " Set terminal title
set whichwrap+=<,>,[,]
set completeopt-=preview " No annoying scratch preview above
set expandtab " Spaces on tabs
set shiftwidth=4
set softtabstop=2
set undolevels=1000
set smartindent " Indentation
set shortmess+=F " Disable startup message
set fileencoding=utf-8 " Encoding when written to file
set fileformat=unix " Line endings
set timeout timeoutlen=1000 ttimeoutlen=10 " TODO: ?
set autowrite " Automatically save before :next, :make etc
set ignorecase " Search case insensitive:
set smartcase " .. but not when search pattern contains upper case characters
set nocursorcolumn
set nocursorline
set number
set wrap
set textwidth=99
set formatoptions=qrn1
set notimeout
set ttimeout
set ttimeoutlen=10
set nobackup " Don't create annoying backup files
set path=+** " Search down into subfolders

" Folding
set foldcolumn=1
set foldlevel=20
set foldlevelstart=7
set foldmethod=syntax
set foldignore=""
set nofoldenable

" Buffers
set hidden

" Searching
set wrapscan
set ignorecase
set smartcase

" Usable 'Tab'
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" UI
set cursorline  " Highlight current line
set showmatch
set tabstop=4 " Default indentation is 4 spaces long and uses tabs, not spaces
set matchtime=2
set termguicolors " Enable true colors support

set completeopt+=menu,menuone " Completion

let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " True color
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

:autocmd InsertEnter,InsertLeave * set cul! " Notify on mode change visually

set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

set viewoptions=cursor,slash,unix

" Important!!
if has('termguicolors')
  set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'shusia'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
" let g:airline_theme = 'sonokai'
" " let g:airline#extensions#tabline#enabled = 1
" let g:airline_powerline_fonts = 1
" let g:airline_disable_statusline = 1

colorscheme sonokai

" Automatically open & close quickfix window
autocmd QuickFixCmdPost [^l]* nested cwindow
" lightline bar
set laststatus=2
let g:lightline = {
\ 'colorscheme': 'powerline',
\ 'active': {
\ 'left':[ [ 'mode', 'paste' ],
\ [ 'gitbranch', 'readonly', 'absolutepath','modified' ]
\ ]
\ },
\ 'component': {
\ 'lineinfo': ' %3l:%-2v%<'
\ },
\ 'component_function': {
\ 'gitbranch': 'fugitive#head',
\ }
\ }
let g:lightline.separator = {
\ 'left': '', 'right': ''
\}
let g:lightline.subseparator = {
\ 'left': '', 'right': ''
\}
let g:lightline.tabline = {
\ 'left': [ ['tabs'] ],
\ 'right': [ ['close'] ]
\ }
set showtabline=2 " Show tabline
set guioptions-=e " Don't use GUI tabline

" Bufferline
let g:bufferline_echo = 0

let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutToggle = '<C-P>'
au filetype vim let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'", '`':'`'} " Don't autocomplete in vim

" Vim session
let g:session_autosave="no"
let g:session_autoload="no"

" Command mappings
cabbrev rp Rp

" CTRL mappings
nnoremap <C-L> :Files<CR>

" Space mappings
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
let maplocalleader = "\<Space>"
nnoremap <leader>= yypVr=

" Space q
nmap <Leader>q    :q<CR>

" Space w
" Save
nmap <Leader>w :w<CR>

" NerdTree
nmap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Space y
" Copy whole file
nnoremap <Leader>y :%y<CR>

" Space i
nnoremap <Leader>ii :PlugInstall<CR>
" Update plugins
nnoremap <Leader>iu :PlugUpdate<CR>
" Check vim health
nnoremap <Leader>ih :CheckHealth<CR>

" Space a
nnoremap <Leader>a :wq<CR>

" Space s
" Source vimrc
nnoremap <Leader>s :source ~/.config/nvim/init.vim<CR>

" Space d
nmap <Leader>d :bd<CR>

" Auto commands
au FileType dirvish call fugitive#detect(@%)
au FocusLost * :wa " Auto save everything

" Remaps
" Search and replace
xnoremap gs y:%s/<C-r>"//g<Left><Left>

" Copy line
nnoremap Y y$

" Other
set guicursor=n-v-c:hor20,i-ci:ver20 " Make cursor block in insert mode and underline in normal mode
autocmd VimLeave * set guicursor=a:ver25-blinkon25 " Make cursor block when leaving to shell

" Testing
set signcolumn=yes
set foldcolumn=0 " Remove sidebar column

" Python
autocmd BufWritePre *.py execute ':Black'
nnoremap <F9> :Black<CR>
let g:black_linelength = 99
let g:black_skip_string_normalization = 1

" only show active line number
hi LineNr ctermfg=16 guifg=bg