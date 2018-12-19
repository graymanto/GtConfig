alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias httpserver='python -m http.server'
alias rmdir='rm -rf'
alias findi='find . -iname'
alias vcat='vimcat'
alias dk='docker'
alias dco='docker-compose'

if [[ $IS_MAC -eq 1  ]]; then
	alias toclip='pbcopy'
	alias fromclip='pbpaste'

	code () {
		if [[ $# = 0  ]]
		then
			open -a "Visual Studio Code"
		else
			[[ $1 = /*  ]] && F="$1" || F="$PWD/${1#./}"
			open -a "Visual Studio Code" --args "$F"
		fi
	}
fi

alias refreshzshcache='hash -rf'
alias ll='ls -la'
alias l.='ls -d .*'

# Commands
alias viewkeycodes='sed -n l'
alias ghist=git hist
