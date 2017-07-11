# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

# If needed, add PPA needed for neovim
if type "$nvim" > /dev/null; then
  sudo add-apt-repository -y ppa:neovim-ppa/stable
fi

# Update APT.
e_header "Updating APT"
sudo apt-get -qq update
#sudo apt-get -qq dist-upgrade

# Install APT packages.
packages=(
  build-essential
  git
  htop
  nmap
  tree
  neovim
  zsh
)

packages=($(setdiff "${packages[*]}" "$(dpkg --get-selections | grep -v deinstall | awk '{print $1}')"))

if (( ${#packages[@]} > 0 )); then
  e_header "Installing APT packages: ${packages[*]}"
  for package in "${packages[@]}"; do
    sudo apt-get -qq -y install "$package"
  done
fi

# Install Git Extras
if [[ ! "$(type -P git-extras)" ]]; then
  e_header "Installing Git Extras"
  (
    cd $DOTFILES/vendor/git-extras &&
    sudo make install
  )
fi
