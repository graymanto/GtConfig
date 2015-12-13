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

if [ -e  '/usr/local/Cellar/sonar-runner/2.4/libexec' ]
then
export SONAR_RUNNER_HOME=/usr/local/Cellar/sonar-runner/2.4/libexec
fi

# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
export WORKON_HOME=~/.virtualenvs
