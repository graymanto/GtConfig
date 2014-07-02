alias ctags='/usr/local/bin/ctags'
alias toclip='pbcopy'
alias fromclip='pbpaste'
alias vim='/Applications/MacVim.App/Contents/MacOS/Vim'

## Colorize the ls output ##
alias ls='ls --color=auto'

## Use a long listing format ##
alias ll='ls -la'

## Show hidden files ##
alias l.='ls -d .* --color=auto'

export ptdev=~/Documents/Development/PhotoThing/website/
export ptsrc=~/Documents/Development/PhotoThing/website/src/
export ptweb=/Users/graymant/Documents/Development/PhotoThing/website/src/main/webapp/
export devhome=/Users/graymant/Documents/Development
export GOPATH=$HOME/Documents/Development/go
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH:$GOPATH/bin"

SumLines() {  # iterating over stdin - similar to awk
    local sum=0
    local line=””
    while read line ; do
        sum=$((${sum} + ${line}))
    done
    echo ${sum}
}

LogMessage() {  # classic logger
    local prefix="[$(date +%Y/%d/%m\ %H:%M:%S)]: "
    echo "${prefix} $@" >&2
}

CompareUrls() {
    diff <(wget -O - $1) <(wget -O - $2)
}

ReplaceInFiles() {
    sed -i -e 's/$1/$2/g' $3
}

# Initialize the 'hop' script
 source /System/Library/Frameworks/Python.framework/Versions/2.7/hop/hop.bash
# Define an entry point for the lua script version of hop
alias hop-lua-script="LUA_PATH=/System/Library/Frameworks/Python.framework/Versions/2.7/hop/json.lua /System/Library/Frameworks/Python.framework/Versions/2.7/hop/hop.lua"
