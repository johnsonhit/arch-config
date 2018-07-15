" ======= Vim plug settings =======

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ======= User settings =======

" Color scheme
syntax on
colorscheme Tomorrow-Night-Eighties
hi Normal ctermbg=none

" Font size and line height
set guifont=Consolas\ 14
set linespace=3

" Indent and tab
set shiftwidth=4
set tabstop=4
set expandtab

" Line number
set number

" Swap file directory
set directory=$HOME/.vim/swap//
set backupdir=$HOME/.vim/backup//
