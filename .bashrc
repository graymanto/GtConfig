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
