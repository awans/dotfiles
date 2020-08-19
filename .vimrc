" \c edit this file
nnoremap <Leader>c :e ~/.vimrc<CR>

" use the mouse like it's 2020
set mouse=a

" \f to copy filename
nnoremap <Leader>f :let @* = expand("%")<CR>

" turn on syntax
syntax enable
filetype plugin indent on
syntax enable<Paste>

" line numbers
set number

" dont use swapfiles
noswapfile

" recover normal backspace behavior
set backspace=indent,eol,start

" buffer management
map <Leader>n :bn<cr>
map <Leader>p :bp<cr>
map <Leader>d :bd<cr>


" awans/agbuf shortcut
nnoremap <Leader>a :Ag<Space>

" fuzzy finder is ctrl+o
nnoremap <C-o> :FZF<CR>
let g:fzf_layout = { 'window': 'enew' }

command! -bar Buffers call fzf#run(fzf#wrap({
\ 'source': map(range(1, bufnr('$')), 'bufname(v:val)'),
\ }))
nnoremap <C-b> :Buffers<CR>

" NERDTree
let loaded_netrwPlugin = 1
autocmd StdinReadPre * let s:std_in=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeCascadeOpenSingleChildDir = 1
let NERDTreeRespectWildIgnore=1
nnoremap <C-\> :e %:p:h<CR>

" theme

" for vim 8
 if (has("termguicolors"))
  set termguicolors
 endif

colorscheme OceanicNext

" quiet an annoying message
nnoremap <C-c> <silent> <C-c>

" live life on the edge
set noswapfile
