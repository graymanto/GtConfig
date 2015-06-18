bindkey -e

if [[ $IS_MAC -eq 1  ]]; then
	bindkey '^[^[[C' forward-word
	bindkey '^[^[[D' backward-word
 fi


if [[ $IS_LINUX -eq 1  ]]; then
	bindkey '^[[1;3C' forward-word
	bindkey '^[[1;3D' backward-word
fi
