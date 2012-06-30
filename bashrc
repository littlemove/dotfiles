source ~/.bash/aliases
source ~/.bash/completions

export TERM=xterm-256color
export GREP_OPTIONS='--color=auto'

# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
# username@Machine ~/dev/dir[master]$ # clean working directory
# username@Machine ~/dev/dir[master*]$ # dirty working directory

# Consider changing your PS1 to also show the current branch:
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

# cd + ls
cd() {
    if [ -n "$1" ]; then
        builtin cd "$@" && ls -G
    else
        builtin cd ~ && ls -G
    fi
}
export PS1='\[\e[0m\]\w$(parse_git_branch) > \[\e[0m\]'
export PS2='> '    # Secondary prompt
export PS3='#? '   # Prompt 3
export PS4='+'     # Prompt 4

export HISTCONTROL=ignoredups # Ignores dupes in the history
shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns

# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind is used instead of setting these in .inputrc.  This ignores case in bash completion
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

# Turn on advanced bash completion if the file exists (get it here: http://www.caliban.org/bash/index.shtml#completion)
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export EDITOR="emacsclient"

# fix(?) for error on running test-server, rinari-launch-test, ...
#export RUBYLIB=".:test:$RUBYLIB"
#export PATH="~/bin:/usr/local/bin:/usr/local/sbin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
