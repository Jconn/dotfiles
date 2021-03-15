apt install zsh neovim
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir -p ~/.vim/ftplugin/
cp python.vim ~/.vim/ftplugin/
mkdir -p  ~/.config/nvim/
cp init.vim ~/.config/nvim/init.vim
cp .vimrc ~/
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir - ~/.vim/colors
cp badwolf.vim ~/.vim/colors
vim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall
