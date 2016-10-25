# source local if available
if [ -r ~/.bashrc_local ]
then
	source ~/.bashrc_local
fi

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
# End of lines configured by zsh-newuser-install

# alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l'
alias la='ls -lA'

# Prompt

if [ -n "$LIQUIDPROMPT_PATH" ]
then
	source "${LIQUIDPROMPT_PATH}/liquidprompt"
elif where liquidprompt > /dev/null
then
	source liquidprompt
fi
