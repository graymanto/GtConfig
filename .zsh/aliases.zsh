
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

if [ -e  '~/GitHub/Nuitka/bin/nuitka' ]
then
	alias nuitka='~/GitHub/Nuitka/bin/nuitka'
fi

alias httpserver='python -m SimpleHTTPServer'
alias rmdir='rm -rf'
alias findi='find . -iname'
alias vcat='vimcat'
alias pip='sudo pip'

if [[ $IS_MAC -eq 1  ]]; then
	alias xonsh='/Library/Frameworks/Python.framework/Versions/3.4/bin/xonsh'
	alias evaldocker='eval "$(docker-machine env default)"'
	alias toclip='pbcopy'
	alias fromclip='pbpaste'
fi

alias refreshzshcache='hash -rf'
alias ll='ls -la'
alias l.='ls -d .* --color=auto'

# Commands
alias viewkeycodes='sed -n l'
