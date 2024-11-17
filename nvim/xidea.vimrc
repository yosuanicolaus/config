" ©yosuanicolaus 2023-2024
" .ideavimrc setup
" file locations:
" ~/.ideavimrc (real file)
" ~/.config/nvim/xidea.vimrc (symlink file)
" ~/repos/config/.ideavimrc (backup file)

" Manual configuration
" download and set VSCode shortcut plugin in Keymap setting
" Searh <C-d>, Add Selection for Next Occurrence <Ctrl+N>
" Searh <C-S-e>, Tool Windows > Project <C-h>
" Editor Actions > Focus Editor <C-l>
" Other > Select Opened File && Select File in Project View <C-S-o>
" Search 'Reformat code' <C-S-i>
" Search <Alt+0> -> <C-S-g>
"
" Actions on Save
" format

" Basic setup

" map <space> <nop>
" let mapleader="\<space>"
let mapleader = " "

set relativenumber
set number
set clipboard^=unnamed,unnamedplus
set hlsearch
set ignorecase smartcase
set idearefactormode=keep
set showcmd
set showmode

" Plugins

" multiple cursor by IDE <C-n>
set visualbell
set surround
set highlightedyank
set ideamarks
set ideajoin
set commentary
set argtextobj
set NERDTree
set vim-paragraph-motion
set textobj-indent
set exchange
set easymotion

" plugins settings
let g:argtextobj_pairs="[:],(:),<:>"

" -------------------------------------------------------------------------

" Handler - default vim, exception set for IDE
" if something is set to vim, before the next reset, erase them
" sethandler <C-s> a:ide   " save (not needed, PyCharm always auto-saves)
sethandler <C-w> n-v:ide " close tab
sethandler <C-v> i:ide   " paste in insert mode
sethandler <C-d> i:ide   " select multiple cursor from insert mode (unused)
sethandler <C-n> v:ide   " select multiple cursor (set manually)
sethandler <C-S-e> a:ide " select file tree
sethandler <C-b> a:ide   " hide file tree
sethandler <C-f> a:vim   " 
sethandler <C-h> n:ide   " also select file tree (set manually)
sethandler <C-l> n:ide   " also select file tree (set manually) 240502

" -------------------------------------------------------------------------

" Built-in IDE Actions

map <C-o> <Action>(Back)
map <C-i> <Action>(Forward)
map <C-j> <Action>(PreviousTab)
map <C-k> <Action>(NextTab)
map <C-S-Tab> <Action>(PreviousTab)
map <C-Tab> <Action>(NextTab)
map <C-S-n> <Action>(NewFile)
map <C-S-p> <Action>(GotoFile)
map <C-f> <ESC><C-S-f>

map <C-S-.> :e ~/.ideavimrc<CR>
map <leader>r <Action>(IdeaVim.ReloadVimRc.reload)
map <leader>f <Action>(AceAction)
map <C-S-k> <Action>(ShowErrorDescription)

" -------------------------------------------------------------------------
" -------------------------------------------------------------------------
" -------------------------------------------------------------------------

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
vnoremap L $
vnoremap / y /<C-r>+<CR>zz
vnoremap ? y ?<C-r>+<CR>zz
vnoremap n y /<C-r>+<CR>zz
vnoremap N y ?<C-r>+<CR>zz
vnoremap J mzJ`z
vnoremap <C-d> <C-d>zz
vnoremap <C-u> <C-u>zz
vnoremap < <gv
vnoremap > >gv
vnoremap p pgvy

" TODO - doesn't work now, change or remove it?
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" -------------------------

" All / Others

map <C-a> <ESC>GVgg
map <C-s> <ESC>:w<CR>
cnoremap <C-v> <C-r>+

" 240222
map zO zR
map zC zM

" unused anymore
" nnoremap <C-s> <ESC>:w<CR>
" nnoremap <leader>s :%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>
" set textobj-entire
" inoremap <C-s> <ESC> :w<CR>
" xnoremap p p:let @+=@0<CR>:let @"=@0<CR>

