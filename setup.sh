read -n1 -rep $'[\e[1;33mACTION\e[0m] - Est-ce que tu veux installer TMUX? [y/n] ' TMUX 
if [[ $TMUX == "Y" || $TMUX == "y" || $TMUX == "" ]]; then
  bash "$PWD"/install/tmux.sh
fi
