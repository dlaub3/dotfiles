call plug#begin('~/.local/share/nvim/plugged')
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'mileszs/ack.vim'
Plug 'shougo/denite.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'avakhov/vim-yaml'
Plug 'suan/vim-instant-markdown'
Plug 'plasticboy/vim-markdown'
Plug 'mxw/vim-jsx'
Plug 'ianks/vim-tsx'
Plug 'othree/yajs.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
Plug 'gorodinskiy/vim-coloresque'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'cocopon/iceberg.vim'
Plug 'mattn/emmet-vim'
Plug 'w0rp/ale'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdcommenter'
Plug 'shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
Plug 'mbbill/undotree'
call plug#end()
"
"
"
"
"
"                             VIM Configuration
"
"
"
syntax enable
set clipboard=unnamed
set encoding=UTF-8
set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set backspace=indent,eol,start    " Intuitive backspacing.
set hidden                        " Handle multiple buffers better.
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set number                        " Show line numbers.
set ruler                         " Show cursor position.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.
set title                         " Set the terminal's title
set visualbell                    " No beeping.
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location
set expandtab                    " Use spaces instead of tabs
set laststatus=2                  " Show the status line all the time
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
" for html/yml files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype yml setlocal ts=2 sw=2 expandtab
" for js/coffee/php files, 4 spaces
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype php setlocal ts=4 sw=4 sts=0 expandtab
" Automatic fold settings for specific files. Uncomment to use.
autocmd FileType ruby setlocal foldmethod=syntax
autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

"
"
"
"
"                            Plug Settings
"
"
"
"
set background=dark
if (has("termguicolors"))
  set termguicolors
endif

let g:Guifont='FuraCode Nerd Font'

"colorscheme solarized
"let g:airline_theme=solarized
"let g:airline_solarized_bg='dark'

"colorscheme deep-space
"let g:airline_theme='deep_space'
"let g:deepspace_italics=1

"colorscheme palenight
"let g:airline_theme='palenight'
"let g:palenight_terminal_italics=1

colorscheme dracula
let g:airline_theme='dracula'
let g:palenight_terminal_italics=1

"colorscheme iceberg
"let g:airline_theme='iceberg'
"let g:iceberg_terminal_italics=1


let g:airline#extensions#tabline#buffer_nr_show = 1

"ALE
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'typescript': ['tsserver', 'tslint'],
      \   'vue': ['eslint'],
      \   'css': ['stylelint']
      \}

let g:ale_fixers = {
      \    'javascript': ['prettier', 'eslint'],
      \    'typescript': ['prettier', 'tslint'],
      \    'vue': ['eslint'],
      \    'scss': ['prettier'],
      \    'css': ['prettier'],
      \    'html': ['prettier']
      \}
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1

"Nerd Tree
map <C-t> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeQuitOnOpen=1

"Snippets Config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']


set t_Co=256

"set termguicolors
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

