if [[ $PATH != *"Development"* ]]
then
	export PATH="$PATH:$GOPATH/bin"
fi

if [[ $IS_MAC -eq 1  ]]; then
	export NVM_DIR=~/.nvm
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi
