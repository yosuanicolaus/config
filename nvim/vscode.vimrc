" @yosuanicolaus 2023
" copied from ~/.ideavimrc at 2023-12-14
" updated at 240229,240522

" -------------------------

" Normal mode

nnoremap H ^
nnoremap L $
nnoremap dH d^
nnoremap dL d$
nnoremap cH c^
nnoremap cL c$
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap J mzJ`z
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <ESC> <ESC>:noh<CR>
nnoremap > >>
nnoremap < <<
nnoremap zh 40zh
nnoremap zl 40zl

" -------------------------

" Insert mode

inoremap <C-CR> <ESC>o
inoremap <S-CR> <ESC>O
inoremap <C-h> <ESC>I
inoremap <C-l> <ESC>A

" -------------------------

" Visual mode

vnoremap H ^
vnoremap L $h
vnoremap / y /<C-r>+<CR>zz
vnoremap ? y ?<C-r>+<CR>zz
vnoremap n y /<C-r>+<CR>zz
vnoremap N y ?<C-r>+<CR>zz
" vnoremap J mzJ`z
vnoremap <C-d> <C-d>zz
vnoremap <C-u> <C-u>zz
vnoremap < <gv
vnoremap > >gv

" TODO change/remove
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" -------------------------

" All / Others

map <C-a> <ESC>GVgg
map <C-s> <ESC> :w<CR>
cnoremap <C-v> <C-r>+

" 240229 in vscode, no need for this. they have their own way
" xnoremap p p:let @+=@0<CR>:let @"=@0<CR>

" 240222
map zO zR
map zC zM
