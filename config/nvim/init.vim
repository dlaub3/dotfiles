let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
  if executable('curl')
    let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
    if v:shell_error
      echom "Error downloading vim-plug. Please install it manually.\n"
      exit
    endif
  else
    echom "vim-plug not installed. Please install it manually or install curl.\n"
    exit
  endif
endif


" visit https://vimawesome.com to find plugins
call plug#begin('~/.local/share/nvim/plugged')
" theme  --------------------------------------------------------------------------------
Plug 'dracula/vim', { 'name': 'dracula' } " colorscheme
Plug 'tyrannicaltoucan/vim-deep-space' " colorscheme
Plug 'altercation/vim-colors-solarized' " colorscheme
Plug 'drewtempelmeyer/palenight.vim' " colorscheme
Plug 'cocopon/iceberg.vim' " colorscheme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons' " icons for nerdtree
" navigation  ----------------------------------------------------------------------------
Plug 'easymotion/vim-easymotion' " move to characters in a window
Plug 'scrooloose/nerdtree' " file navigation Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " advanced fuzzy finder
Plug 'junegunn/fzf.vim' " https://github.com/junegunn/fzf.vim#installation
Plug 'mileszs/ack.vim' " grep like word search
Plug 'ctrlpvim/ctrlp.vim' " file search 
Plug 'shougo/denite.nvim' " It is like a fuzzy finder, but is more generic. 
" completion   ---------------------------------------------------------------------------
"Plug 'shougo/deoplete.nvim'
" git   ----------------------------------------------------------------------------------
Plug 'tpope/vim-fugitive' " a git wrapper
Plug 'tpope/vim-git' " support git filetypes
Plug 'airblade/vim-gitgutter' " git changes denoted next to line numbers
Plug 'junegunn/gv.vim'
" yaml   ---------------------------------------------------------------------------------
Plug 'avakhov/vim-yaml'
" markdown  ------------------------------------------------------------------------------
Plug 'suan/vim-instant-markdown' " open browser for markdown preview
Plug 'plasticboy/vim-markdown'
" JS/TS   --------------------------------------------------------------------------------
"Plug 'leafgarland/typescript-vim' " TS Syntax
"Plug 'othree/yajs.vim' " JS syntax
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'ianks/vim-tsx'
"Plug 'maxmellon/vim-jsx-pretty'
" editing --------------------------------------------------------------------------------
Plug 'raimondi/delimitmate' "automatic closing of quotes, parenthesis, brackets, etc.
Plug 'godlygeek/tabular' " line up text
Plug 'tpope/vim-surround' " sounds words,groups with almost anything
Plug 'scrooloose/nerdcommenter' " easily apply/remove comments
Plug 'mattn/emmet-vim' " code completion/generation
Plug 'gorodinskiy/vim-coloresque' " css/sass/html color preview
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sjl/gundo.vim'
Plug 'terryma/vim-smooth-scroll'
"Plug 'w0rp/ale' " linting, Language Server Protocal, completion, fixing {{{
"Plug 'mbbill/undotree' " visualizes undo history and makes it easier to browse
 Plug 'neoclide/coc.nvim', {'branch': 'release'} 
call plug#end()

" ============================================================================ "
"
"
" ===                             PLUGINS SETTINGS                         === "
"
"
" ============================================================================ "

" Add some emoji
ab :construction: 🚧
ab :kiss: 💋
ab :check: ✅
ab :facepalm: 🤦
ab :poop: 💩

" 
set listchars=tab:▸\ ,eol:¬

" better list formatting 
" support for more than numbered lists
" https://vimways.org/2018/formatting-lists-with-vim
set formatlistpat=^\\s*                     " Optional leading whitespace
set formatlistpat+=[                        " Start character class
set formatlistpat+=\\[({]\\?                " |  Optionally match opening punctuation
set formatlistpat+=\\(                      " |  Start group
set formatlistpat+=[0-9]\\+                 " |  |  Numbers
set formatlistpat+=\\\|                     " |  |  or
set formatlistpat+=[a-zA-Z]\\+              " |  |  Letters
set formatlistpat+=\\)                      " |  End group
set formatlistpat+=[\\]:.)}                 " |  Closing punctuation
set formatlistpat+=]                        " End character class
set formatlistpat+=\\s\\+                   " One or more spaces
set formatlistpat+=\\\|                     " or
set formatlistpat+=^\\s*[-–+o*•]\\s\\+      " Bullet points

" Improved highlighting / unhighliting 
noremap <expr> <Plug>(StopHL) execute('nohlsearch')[-1]
noremap! <expr> <Plug>(StopHL) execute('nohlsearch')[-1]

fu! HlSearch()
    let s:pos = match(getline('.'), @/, col('.') - 1) + 1
    if s:pos != col('.')
        call StopHL()
    endif
endfu

fu! StopHL()
    if !v:hlsearch || mode() isnot 'n'
        return
    else
        sil call feedkeys("\<Plug>(StopHL)", 'm')
    endif
endfu

augroup SearchHighlight
au!
    au CursorMoved * call HlSearch()
    au InsertEnter * call StopHL()
augroup end
         
" let mapleader = " "

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

"colorscheme iceberg
"let g:airline_theme='iceberg'
"let g:iceberg_terminal_italics=1

colorscheme dracula
let g:airline_theme='dracula'
let g:dracula_terminal_italics=1
let g:airline#extensions#tabline#buffer_nr_show = 1


inoremap jk <ESC>

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-e>"
let g:UltiSnipsListSnippets="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsEditSplit="vertical"

" move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

function NERDTreeToggleRelative() 
  if len(expand("%"))
    NERDTreeToggle %
  else
    NERDTreeToggle
  endif
endfunction


noremap <C-t> :call NERDTreeToggleRelative()<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeQuitOnOpen=1
let NERDTreeChDirMode=2

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

nnoremap <F5> :UndotreeToggle<cr>
if has("persistent_undo")
    set undofile
endif

" COC {{{  Language Server Protocal, completion,
let g:coc_enable_locationlist = 1
let g:coc_global_extensions = ['coc-lists','coc-tslint-plugin', 'coc-tsserver', 'coc-eslint', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"}}}

function s:ExpandTab()
  if pumvisible()
    return "\<C-n>"
  endif

  let l:snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return ""
  endif

  if s:IsEmmetInstalled()
    if s:IsInsideEmmetExpansion()
      call feedkeys("\<A-,>n")
      return ""
    endif

    if emmet#isExpandable()
      call feedkeys("\<A-,>,")
      return ""
    endif
  endif

  return "\<Tab>"
endfunction

" DENITE {{{

" Wrap in try/catch to avoid errors on initial install before plugin is available
try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of grep
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'floating_preview': 1,
\ 'preview_height': 15,
\ 'preview_width': 70,
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'auto_preview': 1,
\ 'vertical_preview': 0,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'statusline': 0,
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': &lines / 2 - 5,
\ 'winheight': 15,
\ 'reversed': 1,
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap <leader>b :Denite buffer<CR>
nmap <leader>p :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction
" }}}

" depolete and ale as an alternative to Coc
"let g:deoplete#enable_at_startup = 1
"let b:ale_linters = {
      "\   'vue': ['eslint'],
      "\   'css': ['stylelint']
      "\}

"let b:ale_fixers = {
      "\    '*': ['remove_trailing_lines', 'trim_whitespace'],
      "\    'vue': ['eslint'],
      "\    'scss': ['prettier'],
      "\    'css': ['prettier'],
      "\    'html': ['prettier']
      "\}

"let g:ale_linters_explicit = 1
"let g:ale_lint_on_enter = 1
"let g:ale_sign_error = '●'
"let g:ale_sign_warning = '.'
"let g:ale_fix_on_save = 1
"let g:ale_disable_lsp = 1

"function! LinterStatus() abort
  "let l:counts = ale#statusline#Count(bufnr(''))
  "let l:all_errors = l:counts.error + l:counts.style_error
  "let l:all_non_errors = l:counts.total - l:all_errors
  "return l:counts.total == 0 ? 'OK' : printf(
        "\   '%d⨉ %d⚠ ',
        "\   all_non_errors,
        "\   all_errors
        "\)
"endfunction

"set statusline+=%=
"set statusline+=\ %{LinterStatus()}
" }}}




" ============================================================================ "
"
"
" ===                             VIM SETTINGS                             === "
"
"
" ============================================================================ "



let g:search_ignore_dirs = ['.git', 'node_modules']
" THEME {{
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set t_Co=256 "set termguicolors
set background=dark
if (has("termguicolors"))
  set termguicolors
endif

"}}
"

" match git conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set shada+=%
syntax enable
set mouse=a " enable scroll with trackpad
au BufEnter * :syntax sync minlines=100 fromstart
set redrawtime=1000
autocmd Filetype gitcommit setlocal spell
set clipboard=unnamed " use system clipboard
set clipboard=unnamedplus " use system clipboard
set encoding=UTF-8
set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set backspace=indent,eol,start    " Intuitive backspacing.
set hidden                        " Handle multiple buffers better.
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set number                        " Show line numbers.
set relativenumber
set ruler                         " Show cursor position.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.
set title                         " Set the terminal's title
set visualbell                    " No beeping.

set backup
set noswapfile
"set nobackup
"set nowritebackup
" autoread and autowrite
set autoread
autocmd FocusGained,CursorHold,BufEnter ?* if getcmdwintype() == '' | checktime | endif
augroup save
  au!
  au FocusLost * wall
augroup END
set nohidden
set nobackup
set noswapfile
set nowritebackup
set autoread
set autowrite
set autowriteall

" persistent-undo
set undodir=~/.vim/undo
set undofile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

set cmdheight=2 " Better display for messages
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c " don't give |ins-completion-menu| messages.
set signcolumn=yes " always show signcolumns
set expandtab                     " Use spaces instead of tabs
set laststatus=2                  " Show the status line all the time
set tabstop=2                     " Global tab width.
set shiftwidth=2                  " And again, related.

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif


" File Type Setting  {{{ 
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescriptreact
au BufNewFile,BufRead .tsx UltiSnipsAddFiletypes *.ignore.tsx
au BufNewFile,BufRead .ts UltiSnipsAddFiletypes *.ignore.ts

" for html/yml files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab
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
" }}}

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
"  Some Custom Functions
"
" Rename tabs to show tab numbero.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif

" OS-specific settings ----------------------------------------------------- {{{

if has("win32")
  "Windows options here
else
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      " Mac options here
      set shell=/usr/local/bin/fish
      let g:python3_host_prog='/usr/bin/python3'
      let g:python_host_prog = '/usr/local/bin/python2'
    else
      " linux options here
      " configure python path
      set shell=/usr/bin/fish
      let g:python_host_prog = '/usr/bin/python2'
      let g:python3_host_prog = '/usr/bin/python3'
    endif
  endif
endif

" }}}
" PLUGIN: fzf.vim{{{

let g:fzf_layout = { 'down': '~40%' }

" Populate quickfix list with selected files
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  botright copen
  cc
endfunction

"Ctrl-q allows to select multiple elements an open them in quick list
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" Add namespace for fzf.vim exported commands
let g:fzf_command_prefix = 'Fzf'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" File path completion in Insert mode using fzf
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" Use preview when FzfFiles runs in fullscreen
command! -nargs=? -bang -complete=dir FzfFiles
      \ call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : {}, <bang>0)




" Mappings
nnoremap <silent> <leader>o :FzfFiles<CR>
nnoremap <silent> <leader>O :FzfFiles!<CR>
"nnoremap <silent> <leader>l  :FzfBuffers<CR>
"nnoremap <silent> <leader>b :FzfBLines<CR>
nnoremap <silent> <leader>`  :FzfMarks<CR>
"nnoremap <silent> <leader>p :FzfCommands<CR>
"nnoremap <silent> <leader>t :FzfFiletypes<CR>
nnoremap <silent> <F1> :FzfHelptags<CR>
inoremap <silent> <F1> <ESC>:FzfHelptags<CR>
cnoremap <silent> <expr> <C-p> getcmdtype() == ":" ? "<C-u>:FzfHistory:\<CR>" : "\<ESC>:FzfHistory/\<CR>"
cnoremap <silent> <C-_> <C-u>:FzfCommands<CR>

" fzf.Tags uses existing 'tags' file or generates it otherwise
nnoremap <silent> <leader>] :FzfTags<CR>
xnoremap <silent> <leader>] "zy:FzfTags <C-r>z<CR>

" fzf.BTags generate tags on-fly for current file
nnoremap <silent> <leader>} :FzfBTags<CR>
xnoremap <silent> <leader>} "zy:FzfBTags <C-r>z<CR>

" Show list of change in fzf
" Some code is borrowed from ctrlp.vim and tweaked to work with fzf
command! FzfChanges call s:fzf_changes()
nnoremap <silent> <leader>; :FzfChanges<CR>

function! s:fzf_changelist()
  redir => result
  silent! changes
  redir END

  return map(split(result, "\n")[1:], 'tr(v:val, "	", " ")')
endf

function! s:fzf_changeaccept(line)
  let info = matchlist(a:line, '\s\+\(\d\+\)\s\+\(\d\+\)\s\+\(\d\+\).\+$')
  call cursor(get(info, 2), get(info, 3))
  silent! norm! zvzz
endfunction

function! s:fzf_changes()
  return fzf#run(fzf#wrap({
        \ 'source':  reverse(s:fzf_changelist()),
        \ 'sink': function('s:fzf_changeaccept'),
        \ 'options': '+m +s --nth=3..'
        \ }))
endfunction

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" }}}

" PLUGIN: vim-smooth-scroll {{{
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>
" }}}
