
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
	source dnvm.sh
fi