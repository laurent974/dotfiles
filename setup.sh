read -n1 -rep $'[\e[1;33mACTION\e[0m] - Est-ce que tu veux installer NVIM? [y/n] ' NVIM 
if [[ $NVIM == "Y" || $NVIM == "y" || $NVIM == "" ]]; then
  bash "$PWD"/install/nvim.sh
fi

read -n1 -rep $'[\e[1;33mACTION\e[0m] - Est-ce que tu veux installer TMUX? [y/n] ' TMUX 
if [[ $TMUX == "Y" || $TMUX == "y" || $TMUX == "" ]]; then
  bash "$PWD"/install/tmux.sh
fi

read -n1 -rep $'[\e[1;33mACTION\e[0m] - Est-ce que tu veux installer DOCKER? [y/n] ' DOCKER 
if [[ $DOCKER == "Y" || $DOCKER == "y" || $DOCKER == "" ]]; then
  bash "$PWD"/install/docker.sh
fi

