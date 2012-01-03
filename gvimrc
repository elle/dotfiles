" Example Vim graphical configuration.
" Copy to ~/.gvimrc or ~/_gvimrc.

" Font
set guifont=Inconsolata:h16.00

" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

" Local config
if filereadable($HOME . "/.gvimrc.local")
  source ~/.gvimrc.local
endif
