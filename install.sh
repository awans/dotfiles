REPOS=(
  'tpope/vim-surround'
  'tpope/vim-abolish'
  'tpope/vim-repeat'
  'tpope/vim-commentary'
  'tpope/vim-rsi'
  'octref/RootIgnore'
  'junegunn/fzf'
  'junegunn/goyo.vim'
  'mhartington/oceanic-next'
  'vim-scripts/BufOnly.vim'
  'scrooloose/nerdtree'
  'zah/nim.vim'
  'awans/agbuf'
  'evanleck/vim-svelte'
  'fatih/vim-go'
  'kburdett/vim-nuuid'
)

cd ./start

for i in "${REPOS[@]}"
do
	gh repo clone $i
done
