#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Ce script doit etre lancé en root"
  exit
fi

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Update
apt update -y
apt upgrade -y

# Install Neovim
apt-get install software-properties-common -y
apt-get install python-software-properties -y
add-apt-repository ppa:neovim-ppa/stable -y
apt-get update -y
apt-get install neovim -y

# Install all packages
apt install curl -y
apt-get install zsh -y

# Make config directory for Neovim's init.vim
echo '${RED}[*] Installation de nvim${NC}'
mkdir -p ~/.config/nvim/plug-config

# Install vim-plug plugin manager
echo '${RED}[*] Téléchargement de vim-plug${NC}'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Create a backup of your current coc-settings.json if you have one
if [ -f ~/.config/nvim/coc-settings.json ]; then
  echo '${RED}[*] Backup existing coc-settings.json${NC}'
  cp ~/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json.backup
fi

# Copy coc-settings.json in current working directory to nvim's config location. This is for custom diagnostic signs
echo '${RED}[*] Copying .config folder .config -> ~/.config${NC}'
cp .config/nvim/plug-config/coc.vim ~/.config/nvim/plug-config/

# Create a backup of your current init.vim if you have one
if [ -f ~/.config/nvim/init.vim ]; then
  echo '${RED}[*] Backup existing init.vim${NC}'
  cp ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup
fi

# Enter Neovim and install plugins with vim-plug's :PlugInstall and coc extensions with CoC's :CocInstall using a temporary init.vim, which avoids warnings about missing colorschemes, functions, etc
echo -e '${RED}[*] Running :PlugInstall within nvim ...${NC}'
sed '/call plug#end/q' .config/nvim/init.vim > ~/.config/nvim/init.vim
nvim -c 'PlugInstall' -c 'qa'
rm ~/.config/nvim/init.vim

# Copy init.vim in current working directory to nvim's config location
echo '${RED}[*] Copying init.vim -> ~/.config/nvim/init.vim${NC}'
cp .config/nvim/init.vim ~/.config/nvim/

echo -e "${RED}[+] Installation de neovim terminé.${NC}"

# Install nodejs
echo '${RED}[*] Installation de nodejs${NC}'
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt install -y nodejs

npm install -g yarn

(cd ~/.vim/plugged/coc.nvim && yarn install)

echo '${RED}Installation OhMyZSH'
cp .zshrc ~/
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
chsh -s $(which zsh)
source .zshrc
