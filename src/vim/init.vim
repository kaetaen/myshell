if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd VimEnter *
  \ if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \ | PlugInstall | q
  \ | endif

call plug#begin('$HOME/.config/nvim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'Yggdroot/indentLine'
  Plug 'mattn/emmet-vim'
  Plug 'pseewald/vim-anyfold'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/fzf.vim', { 'do': 'sudo apt-get install ripgrep' }
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ryanoasis/vim-devicons'
  Plug 'sheerun/vim-polyglot'
  Plug 'joshdick/onedark.vim'
call plug#end()

set termguicolors

colorscheme onedark

set inccommand=split
set encoding=UTF-8
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
set splitbelow
set clipboard=unnamed,unnamedplus
"----------------------------------------------"
"---------CONFIGURAÇÕES DE PLUGINS-------------"
"----------------------------------------------"

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

let g:javascript_plugin_flow = 1 
let g:user_emmet_leader_key=','

autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p

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
map <C-d> :NERDTreeToggle <CR>
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 20

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let g:indentLine_color_term = 239
let g:indentLine_char = '│'

autocmd FileType help,nerdtree IndentLinesToggle

"----------------------------------------------"
"---------CONFIGURAÇÕES PESSOAIS---------------"
"----------------------------------------------"


inoremap ;; <C-x><C-o>
inoremap <C-s> <C-\><C-o>:w<CR>
tnoremap <Esc> <C-\><C-n>
inoremap <C-x><C-x> <Esc>:wq! <CR>
noremap <F6> :CocCommand rest-client.request <CR>
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
  elseif &filetype == 'cpp'
    :exec "!time g++ % && ./a.out %% rm -rf ./a.out"
  elseif &filetype == 'sh'
    :exec '!time bash' a:arq
  elseif &filetype == 'php'
    :exec '!time php' a:arq
  elseif &filetype == 'lua'
    :exec '!time lua' a:arq
  elseif &filetype == 'go'
    :exec '!go run' a:arq
  endif
endfunction
inoremap <C-n> <Esc>:call Executar(shellescape(@%, 1))<CR>
nnoremap <F5> :call Executar(shellescape(@%, 1))<CR>

autocmd Filetype * AnyFoldActivate   

if (has("termguicolors"))
 set termguicolors
endif


augroup omni_complete
    autocmd! 
    autocmd FileType css,scss,sass setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
augroup END
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

