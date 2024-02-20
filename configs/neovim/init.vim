""" neovim/vim
" tabs behaviour
set tabstop=4
set shiftwidth=0
" line numbers
set number
set relativenumber
" unset line numbers on terminal buffer
autocmd TermOpen * setlocal nonumber norelativenumber
" set terminal buffer to allways start in insert mode
autocmd BufEnter,BufNew term://* startinsert

""" plugins
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'joshdick/onedark.vim'
call plug#end()

""" NERDTree
nnoremap <C-n> :NERDTreeFocus<CR>
"nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
"nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-f> :NERDTreeFind<CR>
" Mirror the NERDTree before showing it. This makes it the same on all tabs.
"nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
" Start NERDTree and leave the cursor in it.
"autocmd VimEnter * NERDTree
" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p

""" Themes
colo onedark
