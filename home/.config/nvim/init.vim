"
"                       __   _(_)_ __ ___  _ __ ___
"                       \ \ / / | '_ ` _ \| '__/ __|
"                        \ V /| | | | | | | | | (__
"                       (_)_/ |_|_| |_| |_|_|  \___|
"

" Check OS {{{
let os = substitute(system('uname'), "\n", "", "")
" END CHECKOS }}}

" Plugins (administrated by vim-plug) {{{
call plug#begin('~/.nvim/plugged')
Plug 'Shougo/junkfile.vim'
Plug 'jlnelson/vim-molokai256'
Plug 'kien/ctrlp.vim'
" Plug 'airblade/vim-gitgutter'
Plug 'rking/ag.vim'
Plug 'Yggdroot/indentLine'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/syntastic'
Plug 'godlygeek/tabular'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
" Plug 'tpope/vim-fugitive'
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
Plug 'tpope/vim-characterize'
Plug 'othree/yajs.vim'
Plug 'Shougo/vimproc.vim'
Plug 'fatih/vim-go'
Plug 'f-person/git-blame.nvim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'kana/vim-textobj-entire' " ae, ie
Plug 'kana/vim-textobj-indent' " ai, ii, aI, iI
Plug 'kana/vim-textobj-lastpat' " a/, i/, a?, i?
Plug 'kana/vim-textobj-line' " al, il
Plug 'kana/vim-textobj-underscore' " a_, i_
Plug 'kana/vim-textobj-user'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/zoomwintab.vim'
Plug 'jimsei/winresizer'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()
" END BUNDLES }}}

" VIM KEYBINDINGS {{{ ===============================================================
"
let mapleader=' '

map <Leader>0 :WinResizerStartResize<CR>
nnoremap <leader>a <cmd>Telescope live_grep<cr>
vnoremap <Leader>a "zy:<C-u>Ag <C-r>z<CR>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <Leader>l <C-^>
nmap <Leader>c <Plug>CommentaryLine
xmap <Leader>c <Plug>Commentary
noremap <Leader>du :diffupdate<CR>
nnoremap <Leader>eu :EnableUltiSnips<CR>
nnoremap <Leader>ev :e $MYVIMRC<CR>
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope git_files<cr>
nnoremap <leader>gb <cmd>GitBlameToggle<cr>
tnoremap <silent><esc> <C-\><C-n>
nnoremap <Leader>h <C-w>s
map <silent> <Leader>j :JunkfileOpen<CR><CR>
nnoremap <Leader>k <C-w>c
map <Leader>p "*p
nnoremap <silent> <Leader>q :ToggleQuickfix<CR>
map <Leader>r cw<C-r>0<ESC>
nnoremap <Leader>s :term<CR>
nmap <Leader>th :set list!<CR>
map <silent> <Leader>ti :IndentLinesToggle<CR>
nnoremap <silent><Leader>tl :call ToggleRelativeAbsoluteNumber()<CR>
map <silent><Leader>ts :set invhlsearch<CR>
nnoremap <leader>tc :if exists("g:syntax_on") <Bar>
	\   syntax off <Bar>
	\ else <Bar>
	\   syntax enable <Bar>
	\ endif <CR>
nmap <silent><Leader>tw :call ToggleWrap()<CR>
nnoremap <Leader>u :MundoToggle<CR>
nnoremap <Leader>v <C-w>v
nmap <silent> <Leader>w :update<CR>
map <Leader>y :'<,'>w !xclip -sel clip<CR><CR>
nnoremap <silent><Leader>K :bd<CR>
nmap <silent><Leader>N :SyntasticToggleMode<CR>
map <Leader>P :set invpaste<CR>
nnoremap <Leader>z :ZoomWinTabToggle<CR>
nnoremap <Leader>Z :qa!<CR>

command! -nargs=0 -bar EnableUltiSnips call plug#load('ultisnips')

" OSX keybindings {{{

if os == "Darwin"
    map <Leader>y :w !pbcopy<CR><CR>
endif

" OSX KEYBINDINGS }}}

" Fugitive {{{

" nnoremap <Leader>gs :Gstatus<CR>
" nnoremap <Leader>gw :Gwrite<CR>
" nnoremap <Leader>go :Gread<CR>
" nnoremap <Leader>gR :Gremove<CR>
" nnoremap <Leader>gm :Gmove<Space>
" nnoremap <Leader>gc :Gcommit<CR>
" nnoremap <Leader>gd :Gdiff<CR>
" nnoremap <Leader>gb :Gblame<CR>
" nnoremap <Leader>gB :Gbrowse<CR>
" nnoremap <Leader>gp :Git! push<CR>
" nnoremap <Leader>gP :Git! pull<CR>
" nnoremap <Leader>gi :Git!<Space>
" nnoremap <Leader>ge :Gedit<CR>
" nnoremap <Leader>gE :Gedit<Space>

" nnoremap <Leader>ggc :silent! Ggrep -i<Space>

" for the diffmode
" noremap <Leader>dq :Gdiffoff<CR>

" }}}

" END KEYBINDINGS }}}

" VIM Setup {{{ ===============================================================

" Basic options {{{

scriptencoding utf-8
set encoding=utf-8              " setup the encoding to UTF-8
set ls=2                        " status line always visible
set go-=T                       " hide the toolbar
set go-=m                       " hide the menu
" The next two lines are quite tricky, but in Gvim, if you don't do this, if you
" only hide all the scrollbars, the vertical scrollbar is showed anyway
set go+=rRlLbh                  " show all the scrollbars
set go-=rRlLbh                  " hide all the scrollbars
set visualbell                  " turn on the visual bell
set cursorline                  " highlight the line under the cursor
set fillchars+=vert:│           " better looking for windows separator
set title                       " set the terminal title to the current file
set showcmd                     " shows partial commands
set hidden                      " hide the inactive buffers
set ruler                       " sets a permanent rule
set lazyredraw                  " only redraws if it is needed
set autoread                    " update a open file edited outside of Vim
set ttimeoutlen=0               " toggle between modes almost instantly
set backspace=indent,eol,start  " defines the backspace key behavior
set virtualedit=all             " to edit where there is no actual character
set relativenumber
set number
set nofixendofline

" }}}

" Searching {{{

set incsearch                   " incremental searching
set showmatch                   " show pairs match
set hlsearch                    " highlight search results
set smartcase                   " smart case ignore
set ignorecase                  " ignore case letters

" }}}

" History and permanent undo levels {{{

set history=1000
set undofile
set undoreload=1000

" }}}

" Make a dir if no exists {{{

function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction

" }}}

" Backups {{{

set backup
set noswapfile
set backupdir=$HOME/.config/nvim/tmp/backup/
set undodir=$HOME/.config/nvim/tmp/undo/
set directory=$HOME/.config/nvim/tmp/swap/
set viminfo+=n$HOME/.config/nvim/tmp/viminfo

" make this dirs if no exists previously
silent! call MakeDirIfNoExists(&undodir)
silent! call MakeDirIfNoExists(&backupdir)
silent! call MakeDirIfNoExists(&directory)

" }}}

" Wildmenu {{{

set wildmenu                        " Command line autocompletion
set wildmode=list:longest,full      " Shows all the options

set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.bak,*.?~,*.??~,*.???~,*.~      " Backup files
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.jar                            " java archives
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.stats                          " Pylint stats

" }}}

" Tabs, space and wrapping {{{

set expandtab                  " spaces instead of tabs
set tabstop=2                  " a tab = four spaces
set shiftwidth=2               " number of spaces for auto-indent
set softtabstop=2              " a soft-tab of two spaces
set autoindent                 " set on the auto-indent
set nowrap

" set formatoptions=qrn1ct
"set textwidth=80
set colorcolumn=121

function! ToggleWrap()
    let s:nowrap_cc_bg = [22, '#005f00']
    redir => s:curr_cc_hi
    silent hi ColorColumn
    redir END
    let s:curr_cc_ctermbg = matchstr(s:curr_cc_hi, 'ctermbg=\zs.\{-}\s\ze\1')
    let s:curr_cc_guibg = matchstr(s:curr_cc_hi, 'guibg=\zs.\{-}\_$\ze\1')
    if s:curr_cc_ctermbg != s:nowrap_cc_bg[0]
        let g:curr_cc_ctermbg = s:curr_cc_ctermbg
    endif
    if s:curr_cc_guibg != s:nowrap_cc_bg[1]
        let g:curr_cc_guibg = s:curr_cc_guibg
    endif
    if &textwidth == 80
        set textwidth=0
        exec 'hi ColorColumn ctermbg='.s:nowrap_cc_bg[0].
                    \' guibg='.s:nowrap_cc_bg[1]
    elseif &textwidth == 0
        set textwidth=80
        exec 'hi ColorColumn ctermbg='.g:curr_cc_ctermbg.
                    \' guibg='.g:curr_cc_guibg
    endif
endfunction

" }}}

" Ok, a vim for men, get off the cursor keys {{{

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" }}}

" Colorscheme {{{

syntax on                  " enable the syntax highlight
autocmd BufEnter * syntax sync fromstart
set synmaxcol=250
set background=dark            " set a dark background
set t_Co=256                   " 256 colors for the terminal
colorscheme molokai256

" }}}

" Font {{{

set guifont=Dejavu\ Sans\ Mono\ for\ Powerline\ 11

" }}}

" Resize the divisions if the Vim window size changes {{{

au VimResized * exe "normal! \<c-w>="

" }}}

" Use ctrl-g to move to markers {{{

nnoremap <C-g> `

" }}}

" Fast window moves {{{

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" }}}

" Toggle line numbers {{{

function! ToggleRelativeAbsoluteNumber()
  if !&number && !&relativenumber
      set number
      set norelativenumber
  elseif &number && !&relativenumber
      set nonumber
      set relativenumber
  elseif !&number && &relativenumber
      set number
      set relativenumber
  elseif &number && &relativenumber
      set nonumber
      set norelativenumber
  endif
endfunction

" }}}

" Show hidden chars {{{

set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶

" }}}

" Folding {{{

set foldmethod=marker

" Toggle folding

nnoremap \ za
vnoremap \ za

" }}}

" Save as root {{{

cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" }}}

" Toggle the Quickfix window {{{

function! s:QuickfixToggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            lclose
            return
        endif
    endfor
    copen
endfunction
command! ToggleQuickfix call <SID>QuickfixToggle()

" }}}

" Move between Vim and Tmux windows {{{

if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    execute "wincmd " . a:wincmd
    echo a:wincmd
    if previous_winnr == winnr()
      " The sleep and & gives time to get back to vim so tmux's focus tracking
      " can kick in and send us our ^[[O
      execute "silent !sh -c 'sleep 0.01; tmux select-pane -" . a:tmuxdir . "' &"
      redraw!
    endif
  endfunction
  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<CR>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<CR>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<CR>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<CR>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif

" }}}

" Execution permissions by default to shebang (#!) files {{{

augroup shebang_chmod
  autocmd!
  autocmd BufNewFile  * let b:brand_new_file = 1
  autocmd BufWritePost * unlet! b:brand_new_file
  autocmd BufWritePre *
        \ if exists('b:brand_new_file') |
        \   if getline(1) =~ '^#!' |
        \     let b:chmod_post = '+x' |
        \   endif |
        \ endif
  autocmd BufWritePost,FileWritePost *
        \ if exists('b:chmod_post') && executable('chmod') |
        \   silent! execute '!chmod '.b:chmod_post.' "<afile>"' |
        \   unlet b:chmod_post |
        \ endif
augroup END

" }}}

" Load matchit by default {{{

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" }}}

" Make the Y behavior similar to D & C {{{

nnoremap Y y$

" }}}
"
" Strikethrough {{{


" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

" }}}

" END VIM SETUP }}}

" PLUGINS Setup {{{ ===========================================================

" Airline {{{

set noshowmode

let g:airline_theme='wombat'
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1

" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#buffer_min_count = 1

" }}}

" Commentary {{{ -------------------------------------------------------------

augroup plugin_commentary
    au!
    au FileType python setlocal commentstring=#%s
    au FileType htmldjango setlocal commentstring={#\ %s\ #}
    au FileType puppet setlocal commentstring=#\ %s
augroup END

" }}}

" Ctrl-P {{{

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]((\.(git|hg|svn))|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }

let g:ctrlp_user_command = 'ag %s -g ".*"'  

" }}}

" delimitmate {{{

let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1

" }}}

" Fugitive {{{

if !exists(":Gdiffoff")
    command Gdiffoff diffoff | q | Gedit
endif
" }}}

" Mundo {{{ ------------------------------------------------------------------

let g:mundo_preview_bottom = 1

" }}}

" indentLine {{{

let g:indentLine_enabled = 1
let g:indentLine_char = '┊'
let g:indentLine_color_term = 239

" }}}

" Syntastic {{{

let g:syntastic_python_pylint_exe = "pylint2"
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['python'] }
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_php_checkers = ['php']

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol  = '⚡'
let g:syntastic_style_warning_symbol  = '⚡'
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_eslint_exe = 'eslint'

" }}}

" winresizer {{{

let g:winresizer_start_key = '<C-C><C-W>'
" cancelar pulsando ESC
" let g:winresizer_finish_with_escape = 1
let g:winresizer_keycode_finish = 27

" }}}

" tabular {{{
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

" }}}

" vimgo {{{
" }}}

" UltiSnips {{{

let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips"

" }}}

" Git-blame {{{

let g:gitblame_enabled = 0
lua require('gitsigns').setup()

" }}}

" END PLUGINS SETUP }}}

" FILETYPES  {{{ ==============================================================

" JSON {{{ -------------------------------------------------------------------

autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.ds set ft=javascript
autocmd BufNewFile,BufRead *.isml set ft=html
let g:vim_json_conceal=0

" }}}

" JS {{{ -------------------------------------------------------------------

autocmd FileType js UltiSnipsAddFiletypes javascript_sfcc

" }}}

" YAML {{{ -------------------------------------------------------------------

autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab

" }}}

" END FILETYPES }}}
