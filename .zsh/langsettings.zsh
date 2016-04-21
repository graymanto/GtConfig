
if [[ $IS_MAC -eq 1  ]]; then
	export GOPATH=$HOME/Documents/Development/go
fi
if [[ $IS_LINUX -eq 1  ]]; then
	export GOPATH=$HOME/Development/go
fi

if [[ $PATH != *"Development"* ]]
then
	export PATH="$PATH:$GOPATH/bin"
fi

if [[ $IS_MAC -eq 1  ]]; then
	# for asp.net
	[ -s "~/.dnx/dnvm/dnvm.sh" ] && . "~/.dnx/dnvm/dnvm.sh" # Load dnvm
fi

if [[ $IS_MAC -eq 1  ]]; then
	export NVM_DIR=~/.nvm
	source $(brew --prefix nvm)/nvm.sh
fi
