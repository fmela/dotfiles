set -o vi

export EDITOR=vim

# Command line colors
export CLICOLOR=1
export PS1='\[\033[01;33m\]\u@\h\[\033[01;35m\] \w \[\033[00m\]\$ '

function elite2 {
local GRAD1=`tty|cut -d/ -f3`
local COLOR1="\[\033[0;36m\]"
local COLOR2="\[\033[1;36m\]"
#local COLOR1="\[\033[0;33m\]"
#local COLOR2="\[\033[1;33m\]"
local COLOR3="\[\033[1;37m\]"
#local COLOR3="\[\033[1;30m\]"
local COLOR4="\[\033[0m\]"
PS1="$COLOR2($COLOR1\u@`hostname -s`$COLOR2)$COLOR1-$COLOR2($COLOR1\#$COLOR3/$COLOR1$GRAD1$COLOR2)$COLOR1-$COLOR2($COLOR1\$(date +%I:%M:%S%p)$COLOR3:$COLOR1\$(date +%m/%d/%y)$COLOR2)\n$COLOR3$COLOR2($COLOR1\$$COLOR3:$COLOR1\w$COLOR2)$COLOR4 "
PS2="$COLOR2-$COLOR1=$COLOR3-$COLOR4 "
}

elite2

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias make='make -j8'
alias vi='vim'
if [ $(uname) = "Darwin" ]; then
    alias gvim=mvim
    alias gvimdiff=mvimdiff
    alias top='top -o cpu'
else
    alias ls='ls --color=auto'
fi

export P4CONFIG=.p4config
export P4DIFF=p4diff
export P4MERGE=p4merge

alias pending_default="g4 pending -s localpath | grep -A100 '^Change default :' | grep `pwd` | awk '{print \$1}'"
alias reopen_defaults="g4 list -s default | xargs g4 reopen -c"

function mate { open -a /Applications/TextMate.app --args $@; }

# Limit directories shown in prompt to 3 (requires bash 4).
export PROMPT_DIRTRIM=3

# Homebrew directories prepended to PATH
for dir in ~/homebrew/bin ~/homebrew/sbin ~/homebrew/Cellar/ruby/1.9.3-p327/bin; do
	[ -d "$dir" ] && PATH="$dir:$PATH"
done
[ -d ~/homebrew/share/man ] && export MANPATH="$MANPATH:~/homebrew/share/man"

if [ -x /usr/local/scripts/ssx-agents ]; then
	[ "$PS1" ] && eval `/usr/local/scripts/ssx-agents $SHELL`
fi

# Bash Directory Bookmarks
alias m1='alias d1="echo `pwd` && cd \"`pwd`\""'
alias m2='alias d2="echo `pwd` && cd \"`pwd`\""'
alias m3='alias d3="echo `pwd` && cd \"`pwd`\""'
alias m4='alias d4="echo `pwd` && cd \"`pwd`\""'
alias m5='alias d5="echo `pwd` && cd \"`pwd`\""'
alias m6='alias d6="echo `pwd` && cd \"`pwd`\""'
alias m7='alias d7="echo `pwd` && cd \"`pwd`\""'
alias m8='alias d8="echo `pwd` && cd \"`pwd`\""'
alias m9='alias d9="echo `pwd` && cd \"`pwd`\""'
alias mdump='alias|grep -e "alias d[0-9]"|grep -v "alias m" > ~/.bash_bookmarks'
alias lma='alias | grep -e "alias d[0-9]"|grep -v "alias m"|sed "s/alias //"'
touch ~/.bash_bookmarks
source ~/.bash_bookmarks

# FIGNORE is a colon-separated list of suffixes that autocomplete will ignore.
export FIGNORE=.svn

# Lastly, append ~/bin to PATH if it exists.
for dir in "$HOME/bin" "$HOME/src/Play20" "/usr/local/heroku/bin"; do
    [ -d "$dir" ] && PATH="$PATH:$dir"
done
