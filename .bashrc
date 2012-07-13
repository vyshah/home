[ -f /etc/bashrc ] && . /etc/bashrc
[ -f ~/.profile ] && . ~/.profile
[ -f ~/.aliases ] && . ~/.aliases

# Try to fix broken $TERM
if which tput &>/dev/null; then while true; do
    tput longname &>/dev/null && break

    # if -256color, try lower coler version
    if [[ $TERM = *-256color ]] && tput -T${TERM%-256color} longname &>/dev/null; then
        export TERM=${TERM%-256color}
        break
    fi

    # hmm, well if it's not linux, try that
    if [ $TERM != linux ] && tput -Tlinux longname &>/dev/null; then
        export TERM=linux
        break
    fi

    # finally, fallback on vt100
    export TERM=vt100
done; fi

# prompt
export PS1='\u@\h \w$(__git_ps1 " (%s)")\$ '
