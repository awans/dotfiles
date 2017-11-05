if &compatible
  set nocompatible
endif
set runtimepath+=/Users/awans/.vim/bundles/repos/github.com/Shougo/dein.vim
set mouse=a

if dein#load_state('/Users/awans/.vim/bundles')
  call dein#begin('/Users/awans/.vim/bundles')
  call dein#add('/Users/awans/.vim/bundles/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-abolish')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-sleuth')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-dispatch')
  call dein#add('tpope/vim-vinegar')
  call dein#add('tpope/vim-rsi')
  call dein#add('fisadev/vim-isort')
  call dein#add('octref/RootIgnore')
  call dein#add('junegunn/fzf')
  call dein#add('vim-syntastic/syntastic')
  call dein#add('vim-airline/vim-airline')
  call dein#add('bling/vim-bufferline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('kana/vim-arpeggio')
  call dein#add('mileszs/ack.vim')
  call dein#add('mhartington/oceanic-next')
  call dein#add('vim-scripts/BufOnly.vim')
  call dein#add('majutsushi/tagbar')
  call dein#add('Vimjas/vim-python-pep8-indent')
  call dein#add('scrooloose/nerdtree')
  call dein#add('justinmk/vim-sneak')
  call dein#add('andrew-d/vim-grep-syntax')
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable<Paste>

" fuzzy finder is ctrl+o
nnoremap <C-o> :FZF<CR>
let g:fzf_layout = { 'window': 'enew' }

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

nnoremap <C-\> :e %:p:h<CR>


let NERDTreeRespectWildIgnore=1

" wrap let this respect fzf_layout etc
command! -bar Tags call fzf#run(fzf#wrap({
\   'source': "sed '/^\\!/d;s/\t.*//' " . join(tagfiles()) . ' | uniq',
\   'sink':   'tag',
\ }))

command! -bar Buffers call fzf#run(fzf#wrap({
\ 'source': map(range(1, bufnr('$')), 'bufname(v:val)'),
\ }))

" command! Tags call s:tags()
nnoremap <C-p> :Tags<CR>

set number
" \f to copy filename
nnoremap <Leader>f :let @* = expand("%")<CR>

" \c to open config
nnoremap <Leader>c :e ~/.config/nvim/init.vim<CR>
let g:ackprg = 'ag --vimgrep'
let g:ack_qhandler = "botright copen"

" Theme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
 set termguicolors
endif

autocmd VimEnter * AirlineTheme monochrome
syntax enable
colorscheme OceanicNext

"
" auto remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" suggested syntastic defaults
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

autocmd BufWritePost *.py :Isort
let g:deoplete#enable_at_startup = 1
noswapfile

" \d for pdb
nnoremap <Leader>d oimport pdb; pdb.set_trace();<Esc>

" :inoremap <esc> <nop>
" :xnoremap <esc> <nop>
autocmd VimEnter * Arpeggio inoremap jk  <Esc>
autocmd VimEnter * Arpeggio xnoremap jk  <Esc>
autocmd VimEnter * Arpeggio inoremap JK  <Esc>
autocmd VimEnter * Arpeggio xnoremap JK  <Esc>
" auto close completions on enter
autocmd CompleteDone * pclose!

let g:syntastic_html_checkers = []
let g:syntastic_python_checkers = ['flake8']
set splitbelow
set splitright
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
map gq :close<cr>
map gx :bufdo bd<cr>
map gb :Buffers<cr>
set hidden
set infercase
xnoremap . :norm.<CR>
xnoremap Q :'<,'>:normal @q<CR>

set backupskip=/tmp/*,/private/tmp/*

nmap <Leader>b :TagbarToggle<CR>
nnoremap zz :w\|bd<cr>


function! GotoFileWithLineNum()
    " filename under the cursor
    let file_name = expand('<cfile>')
    if !strlen(file_name)
        echo 'NO FILE UNDER CURSOR'
        return
    endif

    " look for a line number separated by a :
    if search('\%#\f*:\zs[0-9]\+')
        " change the 'iskeyword' option temporarily to pick up just numbers
        let temp = &iskeyword
        set iskeyword=48-57
        let line_number = expand('<cword>')
        exe 'set iskeyword=' . temp
    endif

    " edit the file
    exe 'e '.file_name

    " if there is a line number, go to it
    if exists('line_number')
        exe line_number
    endif
endfunction

map gf :call GotoFileWithLineNum()<CR>

function! Ag(args)
  let cmd = "ag " . a:args
  echo "running: " . cmd
  enew
  setlocal buftype=nofile noswapfile
  setlocal cursorline
  execute "silent 0read !" . cmd
  execute "silent file " . cmd

  nnoremap <buffer> <Cr> ^:call GotoFileWithLineNum()<Cr>
  setlocal nomodifiable
  setlocal syntax=grep
endfunction

command! -nargs=* -complete=file Ag call Ag(<q-args>)
nnoremap <Leader>a :Ag<Space>
nmap <Leader>g :Ag <c-r>=expand("<cword>")<cr><Cr>
