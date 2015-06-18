
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

if [ -e  '~/GitHub/Nuitka/bin/nuitka' ]
then
	alias nuitka='~/GitHub/Nuitka/bin/nuitka'
fi
alias toclip='pbcopy'
alias fromclip='pbpaste'
alias httpserver='python -m SimpleHTTPServer'
alias rmdir='rm -rf'
alias findi='find . -iname'
alias vcat='vimcat'

if [[ $IS_MAC -eq 1  ]]; then
	alias xonsh='/Library/Frameworks/Python.framework/Versions/3.4/bin/xonsh'
fi

alias refreshzshcache='hash -rf'
alias ls='ls --color=auto'
alias ll='ls -la'
alias l.='ls -d .* --color=auto'

# Commands
alias viewkeycodes='sed -n l'
