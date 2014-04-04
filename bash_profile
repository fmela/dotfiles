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

# Limit directories shown in prompt to 3 (requires bash 4).
export PROMPT_DIRTRIM=3

# Homebrew directories prepended to PATH
for dir in ~/homebrew/bin ~/homebrew/sbin; do
    [ -d "$dir" ] && PATH="$dir:$PATH"
done
for dir in ~/homebrew/share/man; do
	[ -d "$dir" ] && MANPATH="$MANPATH:~/homebrew/share/man"
done

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

for dir in "$HOME/.cabal/bin"; do
    [ -d "$dir" ] && PATH="$dir:$PATH"
done

# Lastly, append ~/bin to PATH if it exists.
for dir in "$HOME/bin"; do
    [ -d "$dir" ] && PATH="$PATH:$dir"
done

# Jump around, jump around, jump up jump up and get down.
export MARKPATH=$HOME/.marks
function jump {
  cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
  mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
  rm -i "$MARKPATH/$1"
}
function marks {
  \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}
function _jump {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local marks=$(find $MARKPATH -type l | awk -F '/' '{print $NF}')
  COMPREPLY=($(compgen -W '${marks[@]}' -- "$cur"))
  return 0
}
complete -o default -o nospace -F _jump jump

# Forgot what this is for...
export PYTHONPATH="$HOME/homebrew/lib/python2.7/site-packages:$PYTHONPATH"
# Prevent the generation of .pyc files.
export PYTHONDONTWRITEBYTECODE=1
