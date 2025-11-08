" © yosuanicolaus 2024
" obsidian vimrc
" inspired by https://gist.github.com/jiyee/cfa8dc2f37359004b34820543f691db3

" nnoremap j gj
" nnoremap k gk
set clipboard=unnamed

" Surround
" NOTE: must use 'map' and not 'nmap'
nunmap S
vunmap S
nmap S" :surround<space>"<space>"<CR>
nmap S' :surround<space>'<space>'<CR>
nmap S( :surround<space>(<space>)<CR>
nmap S) :surround<space>(<space>)<CR>
nmap S[ :surround<space>[<space>]<CR>
nmap S] :surround<space>[<space>]<CR>
nmap S{ :surround<space>{<space>}<CR>
nmap S} :surround<space>{<space>}<CR>
vmap S" :surround<space>"<space>"<CR>
vmap S' :surround<space>'<space>'<CR>
vmap S( :surround<space>(<space>)<CR>
vmap S) :surround<space>(<space>)<CR>
vmap S[ :surround<space>[<space>]<CR>
vmap S] :surround<space>[<space>]<CR>
vmap S{ :surround<space>{<space>}<CR>
vmap S} :surround<space>{<space>}<CR>

"nmap [[ :surround<space>[<space>]<CR>
" map Sb :surround<space>_<space>_
" map Si :surround<space>_<space>_

nmap gd :obcommand<space>editor:open-link-in-new-leaf<CR>
nmap gf :obcommand<space>editor:follow-link<CR>


" -------------------------
" 240814
" copied from vscode.vimrc (config/nvim)
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
nnoremap G Gzz
nnoremap > >>
nnoremap < <<
nnoremap zh 40zh
nnoremap zl 40zl

" -------------------------

" Insert mode

inoremap <C-CR> <Esc>o
inoremap <S-CR> <Esc>O
inoremap <C-h> <Esc>I
inoremap <C-l> <Esc>A

" -------------------------

" Visual mode

vnoremap H ^
vnoremap L $
vnoremap / y/<C-v><CR>zz
vnoremap ? y?<C-v><CR>zz
vnoremap n y/<C-v><CR>zz
vnoremap N y?<C-v><CR>zz
vnoremap <C-d> <C-d>zz
vnoremap <C-u> <C-u>zz
vnoremap < <gv
vnoremap > >gv

" TODO change/remove
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" -------------------------

" All / Others

map <C-a> <Esc>GVgg
map <C-s> <Esc>:w<CR>

" 240814 doesnt work in obsidian, need to change
" cnoremap <C-v> <C-r>+

" 240229 in vscode, no need for this. they have their own way
" xnoremap p p:let @+=@0<CR>:let @"=@0<CR>
" vnoremap J mzJ`z

" 240222
map zO zR
map zC zM


