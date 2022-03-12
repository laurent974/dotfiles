#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Ce script doit etre lancé en root"
  exit
fi

# Update
apt update -y
apt upgrade -y

# Install all packages
apt install curl neovim -y

# Make config directory for Neovim's init.vim
echo '[*] Creation du dossier de configuration de nvim'
mkdir -p ~/.config/nvim

# Install vim-plug plugin manager
echo '[*] Downloading vim-plug, the best minimalistic vim plugin manager ...'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Create a backup of your current coc-settings.json if you have one
if [ -f ~/.config/nvim/coc-settings.json ]; then
  echo '[*] Backing up existing coc-settings.json'
  cp ~/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json.backup
fi

# Copy coc-settings.json in current working directory to nvim's config location. This is for custom diagnostic signs
echo '[*] Copying coc-settings.json -> ~/.config/nvim/coc-settings.json'
cp coc-settings.json ~/.config/nvim/

# Create a backup of your current init.vim if you have one
if [ -f ~/.config/nvim/init.vim ]; then
    echo '[*] Backing up existing init.vim'
    cp ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup
fi

# Enter Neovim and install plugins with vim-plug's :PlugInstall and coc extensions with CoC's :CocInstall using a temporary init.vim, which avoids warnings about missing colorschemes, functions, etc
echo -e '[*] Running :PlugInstall within nvim ...'
sed '/call plug#end/q' init.vim > ~/.config/nvim/init.vim
nvim -c 'PlugInstall' -c 'qa'
rm ~/.config/nvim/init.vim

# Copy init.vim in current working directory to nvim's config location
echo '[*] Copying init.vim -> ~/.config/nvim/init.vim'
cp init.vim ~/.config/nvim/

echo -e "[+] Done, welcome to your new \033[1m\033[92mNeovim\033[0m experience! Try it by running: nvim. Want to customize it? Modify ~/.config/nvim/init.vim! Remember to change your terminal font to Iosevka Term Nerd Font, or any other preferred nerd font :)"


# Install nodejs
echo '[*] Installation de nodejs'
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt install -y nodejs
