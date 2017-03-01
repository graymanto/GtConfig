if [[ $PATH != *"Development"* ]]
then
	export PATH="$PATH:$GOPATH/bin"
fi

if [[ $IS_MAC -eq 1  ]]; then
	export NVM_DIR=~/.nvm
	source $(brew --prefix nvm)/nvm.sh
fi
