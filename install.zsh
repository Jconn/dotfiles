mkdir -p ~/.vim/ftplugin/
cp python.vim ~/.vim/ftplugin/
cp init.vim ~/.config/nvim/init.vim
cp .vimrc ~/
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
