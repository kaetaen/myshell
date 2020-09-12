if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd VimEnter *
  \ if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \ | PlugInstall | q
  \ | endif

call plug#begin('$HOME/.config/nvim/plugged')
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/nerdcommenter'
    Plug 'sheerun/vim-polyglot'
    Plug 'Yggdroot/indentLine'
    Plug 'pangloss/vim-javascript'
    Plug 'mattn/emmet-vim'
    Plug 'pseewald/vim-anyfold'
    Plug 'jiangmiao/auto-pairs'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'toupeira/vim-desertink'
    Plug 'dracula/vim'
call plug#end()

colorscheme dracula


set softtabstop=2
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
filetype plugin indent on
set number
set autoindent
set cindent
set smartindent
set encoding=utf-8
set iskeyword+=\-
set splitright
set history=300
set undolevels=300
set incsearch
set ignorecase
set hlsearch
set scrolloff=5
set foldmethod=indent
set foldnestmax=10
set nofoldenable 
set wrap
set mouse=a
filetype plugin on
syntax on
set foldlevel=2
set statusline+=%F
set laststatus=2

"----------------------------------------------"
"---------CONFIGURAÇÕES DE PLUGINS-------------"
"----------------------------------------------"

let g:javascript_plugin_flow = 1 
let g:user_emmet_leader_key=','

autocmd vimenter * NERDTree
map <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore = [
  \'\.git[[dir]]',
  \'\.sass-cache[[dir]]',
  \'node_modules[[dir]]',
  \'bower_components[[dir]]',
  \'\.pyc$',
  \'\.pyo$',
  \'\.idea$',
  \'\.vscode$',
  \'\.tags$'
\]
let NERDTreeShowHidden=1
let g:NERDSpaceDelims = 1
map <C-f> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 20

let g:indentLine_color_term = 239
let g:indentLine_char = '│'

autocmd FileType help,nerdtree IndentLinesToggle

"----------------------------------------------"
"---------CONFIGURAÇÕES PESSOAIS---------------"
"----------------------------------------------"


inoremap <C-f>  <C-x><C-o>
inoremap ;; <Esc>
inoremap <C-s> <C-\><C-o>:w<CR>
tnoremap <Esc> <C-\><C-n>
inoremap <C-x><C-x> <Esc>:wq! <CR>
nnoremap <C-t> :sp+terminal<CR>
nnoremap z za
nnoremap n gt
vnoremap <F9> :sort<CR>
vnoremap < <gv
vnoremap > >gv
cab W! w!
cab Q! q!
cab Wq wq
cab Wa wa
cab wQ wq
cab WQ wq
cab W w
cab Q q
ca w!! w !sudo tee "%"

function! Executar(arq) 
  :w
  if &filetype == 'javascript.jsx'
    :exec '!time node' a:arq
  elseif &filetype == 'javascript'
    :exec '!time node' a:arq 
  elseif &filetype == 'java'
    :exec "!javac %"
    :exec "!time java -cp %:p:h %:t:r"
  elseif &filetype == 'python'
    :exec "!time python3" a:arq
  elseif &filetype == 'ruby'
    :exec "!time ruby" a:arq      
  elseif &filetype == 'html'
    :exec "!live-server %:p:h"
  elseif &filetype == 'racket'
    :exec "!racket" a:arq
  elseif &filetype == 'c'
    :exec "!time clang % && ./a.out %% rm -rf ./a.out"
  elseif &filetype == 'sh'
    :exec '!time bash' a:arq
  elseif &filetype == 'php'
    :exec '!time php' a:arq
  elseif &filetype == 'lua'
    :exec '!time lua' a:arq
  else
    :exec "!live-server %:p:h"
  endif
endfunction
inoremap <C-n> <Esc>:call Executar(shellescape(@%, 1))<CR>
nnoremap <F5> :call Executar(shellescape(@%, 1))<CR>

autocmd Filetype * AnyFoldActivate   

if (has("termguicolors"))
 set termguicolors
endif

let mapleader = ","

augroup omni_complete
    autocmd! 
    autocmd FileType css,scss,sass setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
augroup END
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

hi Normal guibg=#161616
