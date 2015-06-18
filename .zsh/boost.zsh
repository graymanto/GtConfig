# Random extra functionality
#
code () {
	if [[ $# = 0  ]]
	then
		open -a "Visual Studio Code"
	else
		[[ $1 = /*  ]] && F="$1" || F="$PWD/${1#./}"
		open -a "Visual Studio Code" --args "$F"
	fi
}

fancy-ctrl-z () {
	if [[ $#BUFFER -eq 0  ]]; then
		BUFFER="fg"
		zle accept-line
	else
		zle push-input
		zle clear-screen
	fi
}

hex2dec(){
	echo "ibase=16; $@"|bc
}

dec2hex(){
	echo "obase=16; $@"|bc
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# fkill - kill process
fkill() {
	ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}

zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'
