read -n1 -rep $'[\e[1;33mACTION\e[0m] - Est-ce que tu veux installer TMUX? [y/n] ' CFG
if [[ $CFG == "Y" || $CFG == "y" || $CFG == "" ]]; then
  echo -e "\u001b[37;1m\u001b[4mDémarrage de l'installation de tmux..."
fi
