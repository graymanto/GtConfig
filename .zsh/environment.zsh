if [[ $IS_MAC -eq 1  ]]; then
	if [[ $PATH != *"gnubin"* ]]
	then
		export PATH="$PATH:$(brew --prefix coreutils)/libexec/gnubin"
	fi
fi

if [ -e  '/usr/local/opt/groovy/libexec' ]
then
	export GROOVY_HOME=/usr/local/opt/groovy/libexec
fi

export MONO_GAC_PREFIX=/usr/local
export LD_LIBRARY_PATH=/usr/local/lib

# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
export WORKON_HOME=~/.virtualenvs

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH
