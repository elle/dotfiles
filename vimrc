" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

set shell=$SHELL\ -l

" Leader
let mapleader = ","

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set ignorecase    " searches are case insensitive...
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set hlsearch

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  " Source the vimrc file after saving it
  autocmd bufwritepost .vimrc source $MYVIMRC
augroup END

" ,v opens the vimrc file in a new tab
nmap <leader>v :tabedit $MYVIMRC<CR>

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
" set list listchars=tab:»·,trail:·,nbsp:·,eol:¬
set list listchars=tab:»·,trail:·,nbsp:·

" F3: Toggle list (display unprintable characters).
nmap <F3> :set list!<CR>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Color scheme
set background=dark " for the dark version
colorscheme one
highlight NonText ctermbg=0 cterm=NONE gui=NONE
highlight Folded  guibg=#0A0A0A guifg=#9090D0

set guifont=Inconsolata:h14.00 "best font ever

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set relativenumber
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Save files with leader-w
nnoremap <Leader>w :w<CR>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Hitting F5 will clean out all trailing whitespaces and tabs
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>

" Bubble single lines, in normal mode cmd + up/down
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines in visual mode, hold ctrl + opn + cmd + up/down
vmap <C-D-M-Up> xkP`[V`]
vmap <C-D-M-Down> xp`[V`]

" Hitting D will duplicate whatever is selected directly below
" Handy when writing tests
vmap D y'>p

" Opening files located in the same directory as the current file
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Use the os_x_iterm2 runner
let g:rspec_runner = 'os_x_iterm'

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Set region to British English
set spelllang=en_gb

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif


filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" Let Vundle manage Vundle
Bundle 'gmarik/Vundle.vim'

" Define bundles via Github repos
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'janko-m/vim-test'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary'
Bundle 'slim-template/vim-slim.git'
Bundle 'cohama/lexima.vim'
Bundle 'christoomey/vim-titlecase'
Bundle 'urso/haskell_syntax.vim'
Bundle 'elixir-lang/vim-elixir'
Bundle 'chrisbra/Colorizer'

call vundle#end()
filetype on

" a new operator to titlecase text
let g:titlecase_map_keys = 0
nmap <leader>gt <Plug>Titlecase
vmap <leader>gt <Plug>Titlecase
nmap <leader>gT <Plug>TitlecaseLine

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden --ignore-dir .git -g "" %s'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.obj,.git,bower_components/**,**/node_modules/**,_build/**,deps/**

" vim-test mappings
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>gt :TestVisit<CR>

" turn colorizer on for specific file types, but not in comments
let g:colorizer_auto_filetype='css,html'
let g:colorizer_skip_comments = 1

set exrc
