if &compatible
  set nocompatible
endif
set runtimepath+=/Users/awans/.vim/bundles/repos/github.com/Shougo/dein.vim

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
  call dein#add('fisadev/vim-isort')
  call dein#add('scrooloose/nerdtree')
  call dein#add('octref/RootIgnore')
  call dein#add('junegunn/fzf')
  call dein#add('vim-syntastic/syntastic')
  call dein#add('vim-airline/vim-airline')
  call dein#add('bling/vim-bufferline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('kana/vim-arpeggio')
  call dein#add('mileszs/ack.vim')
  call dein#add('mhartington/oceanic-next')
  call dein#add('sjbach/lusty')
  call dein#add('vim-scripts/BufOnly.vim')
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable<Paste>

" fuzzy finder is ctrl+o
nnoremap <C-o> :FZF<CR>

" NERDTree
let loaded_netrwPlugin = 1
autocmd StdinReadPre * let s:std_in=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleTree()
  if IsNERDTreeOpen()
    NERDTreeToggle
  else
    NERDTreeFind
  endif
endfunction
nnoremap <C-\> :call ToggleTree()<CR>

let NERDTreeRespectWildIgnore=1
" Tags command based on fzf
function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

" tag finder is ctrl+p
function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()
nnoremap <C-p> :Tags<CR>

set number
" \f to copy filename
nnoremap <Leader>f :let @* = expand("%")<CR>

" \c to open config
nnoremap <Leader>c :e ~/.config/nvim/init.vim<CR>
let g:ackprg = 'ag --vimgrep'

" Theme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
 set termguicolors
endif

autocmd VimEnter * AirlineTheme monochrome
syntax enable
colorscheme OceanicNext

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
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

:inoremap <esc> <nop>
:xnoremap <esc> <nop>
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
map gb :LustyJuggler<cr>
set hidden
set infercase
xnoremap . :norm.<CR>
xnoremap Q :'<,'>:normal @q<CR>

