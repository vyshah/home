" plugins {{{
" https://github.com/junegunn/vim-plug
call plug#begin('~/.nvim/plugged')

Plug 'scrooloose/syntastic'
Plug 'sjl/gundo.vim'
Plug 'tomasr/molokai'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

call plug#end()
" }}}

let g:rehash256 = 1 " better 256-terminal colors for molokai
colorscheme molokai

" Options {{{

set cursorline
set expandtab
set list
set scrolloff=3 " Try to keep 3 lines after cursor
set splitbelow
set splitright
set virtualedit=all
set wildmode=longest,list:longest

let g:netrw_liststyle = 3

set tabstop=4
set shiftwidth=4
set smartindent

" }}}

" searching {{{
set ignorecase " Do case insensitive matching...
set smartcase  " ...but only if the user didn't explicitly case
set hlsearch   " highlight while searching

" disable hlsearch in insert mode
augroup hlsearch
  autocmd InsertEnter * :setlocal nohlsearch
  autocmd InsertLeave * :setlocal   hlsearch
augroup END

" mappings to make "very magic" the default
nnoremap / /\v
nnoremap ? ?\v
" }}}

" Save undo files in central location {{{
if has("persistent_undo")
  set undofile
  set undodir=$HOME/.nvim/undo
  if !isdirectory(&undodir) && exists("*mkdir")
    call mkdir(&undodir, "p", 0700)
  endif
endif
" }}}

" Save swap files in central location {{{
set swapsync=
set directory=$HOME/.nvim/swap
if exists("*mkdir") && !isdirectory(&directory)
  call mkdir(&directory, "p", 0700)
endif
" }}}

" Spelling {{{
set spell

" ... except for some filetypes
augroup nospell
  autocmd FileType helf setlocal nospell
  autocmd FileType qf setlocal nospell
  autocmd FileType netrw setlocal nospell
augroup END
" }}}

" Folding {{{

" default to indent folding
set foldmethod=indent

" syntax folding for some filetypes
augroup syntax_folding
  autocmd FileType markdown setlocal foldmethod=syntax
  autocmd FileType json setlocal foldmethod=syntax
augroup END
" }}}

" Syntastic {{{
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
" }}}

" Mappings {{{

let mapleader=","

" vimscript editing convenience {{{
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
inoremap <leader>ev <esc>:vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>s% :source %<cr>
" }}}

" easier re-sync for lazy diff algorithm
nnoremap du :diffupdate<cr>

" fugitive bindings {{{
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>g: :Git
nnoremap <leader>g! :Gsplit!
nnoremap <leader>g\| :Gvsplit!
nnoremap <leader>gD :Gsplit! diff<cr>
nnoremap <leader>ga :Git add %<cr>
nnoremap <leader>gp :Git add --patch %<cr>
nnoremap <leader>gr :Git reset %<cr>
nnoremap <leader>go yaw:Gsplit <C-r>"<cr>
" }}}

" moar vinegar!
nmap _ <Plug>VinegarVerticalSplitUp

" GUndo
nnoremap <leader>gu :GundoToggle<CR>

" }}}

" abbreviations {{{
augroup filetype_abbrs
  autocmd FileType javascript :iabbrev <buffer> vst var self = this;
augroup END
" }}}

" vim:set foldmethod=marker foldlevel=0 ts=2 sw=2 expandtab:
