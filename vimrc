" General "{{{
set nocompatible               " be iMproved

" :/\%>80v./+                    " highlight characters beyond 80 as 'errors'
scriptencoding utf-8           " utf-8 all the way
set encoding=utf-8
"
set history=256                " Number of things to remember in history.
set timeoutlen=250             " Time to wait after ESC (default causes an annoying delay)
set clipboard+=unnamed         " Yanks go on clipboard instead.
set pastetoggle=<F10>          " toggle between paste and normal: for 'safer' pasting from keyboard
set shiftround                 " round indent to multiple of 'shiftwidth'
set tags=.git/tags;$HOME       " consider the repo tags first, then
                               " walk directory tree upto $HOME looking for tags
                               " note `;` sets the stop folder. :h file-search

" set termguicolors
set modeline
set modelines=5                " default numbers of lines to read for modeline instructions

set autowrite                  " Writes on make/shell commands
set autoread

set nobackup
set nowritebackup
set directory=/tmp//           " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
set noswapfile                 "

set hidden                     " The current buffer can be put to the background without writing to disk

set hlsearch                   " highlight search
set ignorecase                 " be case insensitive when searching
set smartcase                  " be case sensitive when input has a capital letter
set incsearch                  " show matches while typing

let g:is_posix = 1             " vim's default is archaic bourne shell, bring it up to the 90s
let mapleader = ','
let maplocalleader = '	'      " Tab as a local leader
let g:netrw_banner = 0         " do not show Netrw help banner
" "}}}

" Formatting "{{{
set fo+=o                      " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r                      " Do not automatically insert a comment leader after an enter
set fo-=t                      " Do no auto-wrap text using textwidth (does not apply to comments)

set nowrap
set textwidth=0                " Don't wrap lines by default


set tabstop=4                  " tab size eql 4 spaces
set softtabstop=4
set shiftwidth=4               " default shift width for indents
set expandtab                  " replace tabs with ${tabstop} spaces
set smarttab                   "

set backspace=indent
set backspace+=eol
set backspace+=start

set autoindent
set cindent
set indentkeys-=0#            " do not break indent on #
set cinkeys-=0#
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do
set cinwords+=for,switch,case
" "}}}

" Visual "{{{
syntax on                      " enable syntax

" set synmaxcol=250              " limit syntax highlighting to 128 columns

set mouse=a "enable mouse in GUI mode
set mousehide                 " Hide mouse after chars typed

set nonumber                  " line numbers Off
set showmatch                 " Show matching brackets.
set matchtime=2               " Bracket blinking.

set wildmode=longest,list     " At command line, complete longest common string, then list alternatives.

set completeopt-=preview      " disable auto opening preview window

set novisualbell              " No blinking
set noerrorbells              " No noise.
set vb t_vb=                  " disable any beeps or flashes on error

set laststatus=2              " always show status line.
set shortmess=atI             " shortens messages
set showcmd                   " display an incomplete command in statusline

set statusline=%<%f\          " custom statusline
set stl+=[%{&ff}]             " show fileformat
set stl+=%y%m%r%=
set stl+=%-14.(%l,%c%V%)\ %P


set foldenable                " Turn on folding
set foldmethod=marker         " Fold on the marker
set foldlevel=100             " Don't autofold anything (but I can still fold manually)

set foldopen=block,hor,tag    " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix

set virtualedit=block

set splitbelow
set splitright

set list                      " display unprintable characters f12 - switches
set listchars=tab:\ ·,eol:¬
set listchars+=trail:·
set listchars+=extends:»,precedes:«
set list!
map <silent> <F12> :set invlist<CR>

if has('gui_running')
  set guioptions=cMg " console dialogs, do not show menu and toolbar

  " Fonts
  " :set guifont=* " to launch a GUI dialog
  if has('mac')
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12  else
  let g:Powerline_symbols = 'fancy'
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:12
  end
  if has('mac')
  " set noantialias
  " set fullscreen
  set fuoptions=maxvert,maxhorz ",background:#00AAaaaa
  endif
endif
" "}}}

" Key mappings " {{{
" Duplication
nnoremap <leader>c mz"dyy"dp`z
vnoremap <leader>c "dymz"dP`z

nnoremap <leader>rs :source ~/.vimrc<CR>
nnoremap <leader>rt :tabnew ~/.vim/vimrc<CR>
nnoremap <leader>re :e ~/.vim/vimrc<CR>
nnoremap <leader>rd :e ~/.vim/ <CR>
nnoremap <leader>rc :silent ! cd ~/.vim/ && git commit ~/.vim/vimrc -v <CR>

" Tabs
nnoremap <M-h> :tabprev<CR>
nnoremap <M-l> :tabnext<CR>

" Buffers
nnoremap <localleader>- :bd<CR>
nnoremap <localleader>-- :bd!<CR>
" Split line(opposite to S-J joining line)
nnoremap <C-J> gEa<CR><ESC>ew

" map <silent> <C-W>v :vnew<CR>
" map <silent> <C-W>s :snew<CR>

" copy filename
map <silent> <leader>. :let @+=expand('%:p').':'.line('.')<CR>
map <silent> <leader>/ :let @+=expand('%:p:h')<CR>
" copy path


map <S-CR> A<CR><ESC>

map <leader>E :Explore<CR>
map <leader>EE :Vexplore!<CR><C-W>=

" toggle search highlighting
nnoremap <silent> <space> :let &hls=1-&hls<cr>

" Make Control-direction switch between windows (like C-W h, etc)
nmap <silent> <C-k> <C-W><C-k>
nmap <silent> <C-j> <C-W><C-j>
nmap <silent> <C-h> <C-W><C-h>
nmap <silent> <C-l> <C-W><C-l>

  " vertical paragraph-movement
nmap <C-K> {
nmap <C-J> }

" vertical split with fuzzy-searcher
nnoremap <leader>v :exec ':vnew \| CtrlP'<CR>
" and without
nnoremap <leader>V :vnew<CR>

" when pasting copy pasted text back to 
" buffer instead replacing with owerride
xnoremap p pgvy

if has('mac')

  if has('gui_running')
    set macmeta
  end

" map(range(1,9), 'exec "imap <D-".v:val."> <C-o>".v:val."gt"')
" map(range(1,9), 'exec " map <D-".v:val."> ".v:val."gt"')

" Copy whole line
nnoremap <silent> <D-c> yy

" close/delete buffer when closing window
map <silent> <D-w> :bdelete<CR>
endif

" Control+S and Control+Q are flow-control characters: disable them in your terminal settings.
" $ stty -ixon -ixoff
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
"
" generate HTML version current buffer using current color scheme
map <leader>2h :runtime! syntax/2html.vim<CR>

" " }}}

" AutoCommands " {{{
au BufRead,BufNewFile {*.go}                                          setl ft=go tabstop=2 softtabstop=2 noexpandtab smarttab
au BufRead,BufNewFile {*.coffee}                                      setl ft=coffee tabstop=2 softtabstop=2 expandtab smarttab
au BufRead,BufNewFile {Gemfile,Rakefile,*.rake,config.ru,*.rabl}      setl ft=ruby tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
au BufRead,BufNewFile {*.local}                                       setl ft=sh
au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         setl ft=markdown
au BufRead,BufNewFile {*.scala}                                       setl ft=scala
au! BufReadPost       {COMMIT_EDITMSG,*/COMMIT_EDITMSG}               exec 'setl ft=gitcommit noml list spell' | norm 1G
au! BufWritePost      {*.snippet,*.snippets}                          call ReloadAllSnippets()

" open help in vertical split
" au BufWinEnter {*.txt} if 'help' == &ft | wincmd H | nmap q :q<CR> | endif
" " }}}

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Scripts and Plugins " {{{
filetype off
runtime macros/matchit.vim
" set rtp+=~/.vim/bundle/Vundle.vim/
"call vundle#begin()

call plug#begin('~/.vim/plugged')
" Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle

" Colorscheme
"Plugin 'gmarik/ingretu'

"if has("gui_running")
"  set background=dark
"  colorscheme ingretu
"endif

" Programming
" Plugin 'Blackrush/vim-gocode'
" Plug 'fatih/vim-go'
" Plug 'derekwyatt/vim-scala'
" Plugin 'tpope/vim-rails'
" Js
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Snippets
Plug 'msanders/snipmate.vim'
nnoremap <leader>so :Explore ~/.vim/bundle/snipmate.snippets/snippets/<CR>

" Dash.app
Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/dash.vim'

" Syntax highlight
Plug 'gmarik/vim-markdown'
Plug 'timcharper/textile.vim'
Plug 'leafgarland/typescript-vim'

" Git integration
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'

nnoremap <leader>W :Gwrite<CR>
nnoremap <leader>C :Gcommit -v<CR>
nnoremap <leader>S :Gstatus \| 7<CR>
inoremap <leader>W <Esc><leader>W
inoremap <leader>C <Esc><leader>C
inoremap <leader>S <Esc><leader>S

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" bubble current line
nmap <M-j> ]e
nmap <M-k> [e
" bubble visual selection lines
vmap <M-j> ]egv
vmap <M-k> [egv

" Utility
Plug 'AndrewRadev/splitjoin.vim'
nmap sj :SplitjoinJoin<cr>
nmap sk :SplitjoinSplit<cr>

Plug 'gmarik/github-search.vim'

Plug 'gmarik/ide-popup.vim'
Plug 'gmarik/sudo-gui.vim'

Plug 'sjl/gundo.vim'

Plug 'mkitt/browser-refresh.vim'
com! ONRRB :au! BufWritePost <buffer> :RRB
com! NORRB :au! BufWritePost <buffer>


" Plugin 'SuperTab'
" Plugin 'bogado/file-line'
Plug 'junegunn/vim-easy-align'
" Plug 'vim-scripts/lastpos.vim'

Plug 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key='<LocalLeader>'

" Plug 'ZoomWin'
" noremap <leader>o :ZoomWin<CR>
" vnoremap <leader>o <C-C>:ZoomWin<CR>
" inoremap <leader>o <C-O>:ZoomWin<CR>
"
Plug 'tomtom/tlib_vim'
Plug 'tomtom/tcomment_vim'
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

Plug 'gmarik/hlmatch.vim'
nnoremap # :<C-u>HlmCword<CR>
nnoremap <leader># :<C-u>HlmGrepCword<CR>
vnoremap # :<C-u>HlmVSel<CR>
vnoremap <leader># :<C-u>HlmGrepVSel<CR>

nnoremap ## :<C-u>HlmPartCword<CR>
nnoremap <leader>## :<C-u>HlmPartGrepCword<CR>
vnoremap ## :<C-u>HlmPartVSel<CR>
vnoremap <leader>## :<C-u>HlmPartGrepVSel<CR>

" FuzzyFinder
"Plug 'L9'
Plug 'junegunn/fzf'
" FuF customisations "{{{
let g:fuf_modesDisable = []
nnoremap <leader>h :FufHelp<CR>
nnoremap <leader>1  :FufTagWithCursorWord<CR>
nnoremap <leader>11 :FufTag<CR>
nnoremap <leader>2  :FufFileWithCurrentBufferDir<CR>
nnoremap <leader>22 :FufFile<CR>
nnoremap <leader>3  :FufBuffer<CR>
nnoremap <leader>4  :FufDirWithCurrentBufferDir<CR>
nnoremap <leader>44 :FufDir<CR>
nnoremap <leader>5  :FufBufferTag<CR>
nnoremap <leader>55 :FufBufferTagAll<CR>
nnoremap <leader>6  :FufMruFile<CR>
nnoremap <leader>7  :FufLine<CR>
nnoremap <leader>8  :FufChangeList<CR>
nnoremap <leader>9  :FufTaggedFile<CR>

nnoremap <leader>p :FufDir ~/src/<CR>
nnoremap <leader>ge :FufDir ~/.rvm/gems/<CR>

nnoremap <leader>gn :vnew \| :FufFile ~/src/notes/<CR>

" " }}}

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<leader>t'
let g:ctrlp_max_height = 30
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height = 20
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_switch_buffer = 'e'
nnoremap <leader>ev :CtrlP app/views<cr>
nnoremap <leader>ec :CtrlP app/controllers<cr>
nnoremap <leader>em :CtrlP app/models<cr>
nnoremap <leader>el :CtrlP lib<cr>
nnoremap <leader>ea :CtrlP app/assets<cr>
nnoremap <leader>ep :CtrlP public<cr>
nnoremap <leader>er :topleft :vsplit config/routes.rb<cr>
nnoremap <leader>eg :topleft :vsplit Gemfile<cr>


" Plugin 'int3/vim-extradite'
" Plugin 'Lokaltog/vim-powerline'

Plug 'junegunn/seoul256.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'kien/rainbow_parentheses.vim'
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
"let g:airline_section_a = airline#section#create(['%<', 'file', 'readonly'])
"let g:airline_section_b = '' " airline#section#create_left(['mode', 'paste', 'iminsert'])
"let g:airline_section_c = '' " airline#section#create(['hunks'])
"let g:airline_section_gutter = airline#section#create(['%=%y%m%r[%{&ff}]'])
let g:airline_section_x = '' " airline#section#create_right(['filetype'])
" let g:airline_section_y = '%y%m%r%=[%{&ff}]' "airline#section#create_right(['ffenc'])
"let g:airline_section_z = airline#section#create(['%(%l,%c%V%) %P'])
let g:airline_section_warning = '' "airline#section#create(['whitespace'])

Plug 'gregsexton/gitv'
Plug 'Rigellute/shades-of-purple.vim'

function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  " ...
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

Plug 'junegunn/goyo.vim'
Plug 'rust-lang/rust.vim'
" Plugin 'mattn/emmet-vim'
call plug#end()
"call vundle#end()
"colorscheme shades_of_purple 
let g:shades_of_purple_airline = 1
let g:airline_theme = 'shades_of_purple'
filetype plugin indent on      " Automatically detect file types.
" " }}}
set shortmess+=O

