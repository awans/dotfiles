if &compatible
  set nocompatible
endif
set runtimepath+=/Users/awans/.vim/bundles/repos/github.com/Shougo/dein.vim

if dein#load_state('/Users/awans/.vim/bundles')
  call dein#begin('/Users/awans/.vim/bundles')

  call dein#add('/Users/awans/.vim/bundles/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-abolish')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-sleuth')
  call dein#add('tpope/vim-commentary')
  call dein#add('fisadev/vim-isort')
  call dein#add('scrooloose/nerdtree')
  call dein#add('octref/RootIgnore')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('junegunn/fzf')
  call dein#add('nvie/vim-flake8')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('mileszs/ack.vim')
  call dein#add('mhartington/oceanic-next')
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

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" lint on save and ctrl+l
autocmd FileType python nnoremap <C-l> :call Flake8()<CR>

autocmd BufWritePost *.py call Flake8()
autocmd BufWritePost *.py :Isort

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
" auto remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e