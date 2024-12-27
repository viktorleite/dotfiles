"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Viktor Leite <viktorleite.s@gmail.com>
" Data de criação: 26/12/2024
" Última atualização: 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

set number
" set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
" set clipboard=unnamedplus
" set wrap
" set cursorline
set termguicolors
" set hlsearch
set incsearch
set ignorecase
set smartcase
set wildmenu

nnoremap <C-s> :w<CR>i
inoremap <C-s> <Esc>:w<CR>i
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> /
nnoremap <C-w> :q<CR>
" Instalar o Vim-Plug:
" Neovim:
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Vim:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


" Para VIM
" call plug#begin('~/.vim/plugged')

" Para NVIM
call plug#begin('~/.local/share/nvim/plugged')
    Plug 'preservim/nerdtree'
    autocmd vimenter * NERDTree
    autocmd VimLeave * NERDTreeClose
call plug#end()
