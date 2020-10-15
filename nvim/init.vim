call plug#begin("~/.vim/plugged")
  " Plugin Section
  
  " Theme
  " Plug 'gruvbox-community/gruvbox'
  Plug 'ayu-theme/ayu-vim'

  " Language Client
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

  " TypeScript Highlighting
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  
  " File Search
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter'

  Plug 'editorconfig/editorconfig-vim'
call plug#end()

"Config Section

" Enable theming support
 set termguicolors

" Theme
syntax enable
let ayucolor="dark"
colorscheme ayu
" colorscheme gruvbox

" requires silversearcher-ag
" used to ignore gitignore files
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

nnoremap <C-p> :FZF<CR>

let mapleader = " "

"Remap keys for applying codeAction to the current line.
nmap <a-cr>  <Plug>(coc-codeaction)
"Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

set number relativenumber
set expandtab

