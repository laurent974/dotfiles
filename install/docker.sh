echo -e "\u001b[37;1m\u001b[4mDémarrage de l'installation de docker..."

function install_docker() {
  echo -e "\u001b[7m Installation du package... \u001b[0m"
  sudo pacman -S docker

  echo -e "\u001b[7m Activation des services lié à docker... \u001b[0m"
  sudo systemctl start docker
  sudo systemctl enable docker

  echo -e "\u001b[7m Modification des droits... \u001b[0m"
  sudo usermod -aG docker $USER

  echo -e "\u001b[7m Docker necessite un reboot pour fonctionner correctement. \u001b[0m"
}

install_docker
