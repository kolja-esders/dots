# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim

#if [ ! -d "~/.local/share/nvim/site/autoload/plug.vim" ]; then
#    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#fi

# Download Vim plugins.
#if [[ "$(type -P vim)" ]]; then
#  vim +PlugUpgrade +PlugUpdate +qall
#fi
