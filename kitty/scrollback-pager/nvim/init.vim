" Minimal vim setup for kitty scrollback in neovim
" Mostly copied from ~/.ideavimrc

set relativenumber
set number
set clipboard^=unnamed,unnamedplus

set mouse=a
set virtualedit=all

" Normal mode
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <ESC> <ESC>:noh<CR>
nnoremap zh 40zh
nnoremap zl 40zl

" Visual mode
vnoremap / y /<C-r>+<CR>zz
vnoremap ? y ?<C-r>+<CR>zz
vnoremap <C-d> <C-d>zz
vnoremap <C-u> <C-u>zz

" Others
map <C-a> <ESC>GVgg
cnoremap <C-v> <C-r>+

" Unused in scrollback (because modifiable is off)
" (All of Insert mode)
" nnoremap J mzJ`z
" nnoremap > >>
" nnoremap < <<
" vnoremap <A-j> :m '>+1<CR>gv=gv
" vnoremap <A-k> :m '<-2<CR>gv=gv
" vnoremap J mzJ`z
" vnoremap < <gv
" vnoremap > >gv
" map <C-s> <ESC> :w<CR>
" xnoremap p p:let @+=@0<CR>:let @"=@0<CR>
