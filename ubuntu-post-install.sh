#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Ce script doit etre lancé en root"
  exit
fi

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function help() {
  printf "Arguments possible pour l'installation\n"
  printf "\t--nvim                 : Installation de neovim + dotfiles ;\n"
  printf "\t--omzsh                : Installation d'OhMyZSH ;\n"
  printf "\t--tmux                 : Installation de tmu + tmuxinator ;\n"
  printf "\t-h                     : Voir l'aide.\n"
}

function all_installer() {
  neovim_installer
  omzsh_installer
  tmux_installer
}

if [ $# -eq 0 ]
then
  all_installer
fi

function update() {
  # Update
  echo -e '${RED}Update & Upgrade apt'
  apt update -y
  apt upgrade -y
  apt-get update -y
}

function neovim_installer() {
  update
  # Install Neovim
  apt-get install software-properties-common -y
  apt-get install python-software-properties -y
  add-apt-repository ppa:neovim-ppa/stable -y
  apt-get install neovim -y

  # Make config directory for Neovim's init.vim
  echo -e '${RED}[*] Installation de nvim${NC}'
  mkdir -p ~/.config/nvim/plug-config

  # Install vim-plug plugin manager
  echo -e '${RED}[*] Téléchargement de vim-plug${NC}'
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # Create a backup of your current coc-settings.json if you have one
  if [ -f ~/.config/nvim/coc-settings.json ]; then
    echo -e '${RED}[*] Backup existing coc-settings.json${NC}'
    cp ~/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json.backup
    fi

  # Copy coc-settings.json in current working directory to nvim's config location. This is for custom diagnostic signs
  echo -e '${RED}[*] Copying .config folder .config -> ~/.config${NC}'
  cp .config/nvim/plug-config/coc.vim ~/.config/nvim/plug-config/

  # Create a backup of your current init.vim if you have one
  if [ -f ~/.config/nvim/init.vim ]; then
    echo -e '${RED}[*] Backup existing init.vim${NC}'
    cp ~/.config/nvim/init.vim ~/.config/nvim/init.vim.backup
  fi

  # Enter Neovim and install plugins with vim-plug's :PlugInstall and coc extensions with CoC's :CocInstall using a temporary init.vim, which avoids warnings about missing colorschemes, functions, etc
  echo -e '${RED}[*] Running :PlugInstall within nvim ...${NC}'
  sed '/call plug#end/q' .config/nvim/init.vim > ~/.config/nvim/init.vim
  nvim -c 'PlugInstall' -c 'qa'
  rm ~/.config/nvim/init.vim

  # Copy init.vim in current working directory to nvim's config location
  echo -e '${RED}[*] Copying init.vim -> ~/.config/nvim/init.vim${NC}'
  cp .config/nvim/init.vim ~/.config/nvim/

  echo -e "${RED}[+] Installation de neovim terminé.${NC}"

  # Install nodejs
  echo -e '${RED}[*] Installation de nodejs${NC}'
  curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
  apt install -y nodejs

  npm install -g yarn

  (cd ~/.vim/plugged/coc.nvim && yarn install)
}

function omzsh_installer() {
  update

  # Install all packages
  apt install curl -y
  apt-get install zsh sudo -y
  useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

  echo -e '${GREEN}Installation OhMyZSH'
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  cp .zshrc ~/
  chsh -s $(which zsh)
  source .zshrc
}

function tmux_installer() {
  echo -e '${RED}Installation de tmux/tmuxinator'
}

# Boucle qui va determiner les packages à installer
OPTS=$( getopts -o h -l nvim,omzsh,tmux: -- "$@" )
while true ; do
  case "$1" in
    "-h") help
      exit 0
      ;;
    "--nvim")
      neovim_installer
      shift
      ;;
    "--ohmzsh")
      ohmzsh_installer
      shift
      ;;
    "--tmux")
      tmux_installer
      shift
      ;;
    "--")
      shift
      break
      ;;
  esac
done

exit 0
