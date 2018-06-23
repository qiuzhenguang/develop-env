 wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz --no-check-certificate
 tar -xzvf ctags-5.8.tar.gz 
 cd ctags-5.8
 ./configure 
 make

mkdir -p ~/.tools
cp ./ctags ~/.tools
cd -


echo '
syntax on
filetype indent plugin on
set modeline
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set nonumber
set cmdheight=1
set laststatus=2
set nu
map <F12> :!~/.tools/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <F4> :TlistToggle<cr>
map <F3> :WMToggle<cr>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
' >> ~/.vimrc

mkdir -p ~/.vim/plugin/
curl "http://www.vim.org/scripts/download_script.php?src_id=3640" -o ~/.vim/plugin/minibufexpl.vim -L

curl "http://www.vim.org/scripts/download_script.php?src_id=19574" -o ./taglist.zip -L

unzip ./taglist.zip

cp doc  plugin ~/.vim/ -r

curl "https://www.vim.org/scripts/download_script.php?src_id=23731" -o ./NERD_tree.zip -L

mkdir NERD_tree
unzip ./NERD_tree.zip -d NERD_tree
cp NERD_tree/* ~/.vim/ -r

echo '
export PATH=~/.tools/:$PATH
' >> ~/.bashrc

source  ~/.bashrc

echo "run: source  ~/.bashrc"


