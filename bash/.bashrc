# .bashrc

[[ $- != *i* ]] && return

# history
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend cmdhist

# shell options
shopt -s checkwinsize autocd cdspell globstar

# completion
[[ -r /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
if declare -F _completion_loader >/dev/null; then
    _completion_loader git
    declare -F __git_complete >/dev/null && __git_complete g git
fi

# git branch without forking
__git_branch() {
    GIT_BRANCH=
    local d=$PWD g line
    while [[ -n $d ]]; do
        if [[ -e $d/.git ]]; then
            g=$d/.git
            if [[ -f $g ]]; then
                read -r line < "$g"
                g=${line#gitdir: }
                [[ $g != /* ]] && g=$d/$g
            fi
            if [[ -r $g/HEAD ]]; then
                read -r line < "$g/HEAD"
                if [[ $line == "ref: refs/heads/"* ]]; then
                    GIT_BRANCH=" ${line#ref: refs/heads/}"
                else
                    GIT_BRANCH=" ${line:0:7}"
                fi
            fi
            return
        fi
        d=${d%/*}
    done
}

# prompt
PROMPT_COMMAND=__git_branch
PS1='\[\e[97;1m\][\[\e[22m\]\u\[\e[91m\]@\h\[\e[0m\] \[\e[97m\]\W\[\e[1m\]${GIT_BRANCH}]\$\[\e[0m\] '

# ls
alias ls='ls --color=auto'
alias ll='ls -lAh --color=auto'
alias la='ls -A --color=auto'

# safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias mkdir='mkdir -p'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# colors and readability
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# git
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -20'
alias gp='git push'

# void
alias xi='sudo xbps-install -S'
alias xu='sudo xbps-install -Su'
alias xr='sudo xbps-remove -R'
alias xs='xbps-query -Rs'

# clipboard
alias cb='xclip -selection clipboard'
alias cbp='xclip -selection clipboard -o'
