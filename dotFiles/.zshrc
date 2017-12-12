# source local if available
if [ -r ~/.zshrc_local ]
then
	source ~/.zshrc_local
fi

# The following lines were added by compinstall

zstyle ':completion:*' menu select=2
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' max-errors 1
zstyle :compinstall filename '/home/cedric/.zshrc'
setopt completealiases

autoload -Uz compinit && compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
# End of lines configured by zsh-newuser-install

# globbing option
setopt extendedglob
setopt numericglobsort
setopt interactivecomments

# alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l'
alias la='ls -lA'

# Prompt

if [ -n "$LIQUIDPROMPT_PATH" ]
then
	autoload -U colors && colors
	#LP_PS1_PREFIX="$fg[cyan][%T]$reset_color" ## FIXME Bug when use automatic completion in select mode
	source "${LIQUIDPROMPT_PATH}/liquidprompt"
elif where liquidprompt > /dev/null
then
	autoload -U colors && colors
	source liquidprompt
else
	autoload -U promptinit && promptinit
	prompt adam2 8bit
fi

if [ -n "$SYNTAX_HIGHLIGHTING_PATH" ]
then
    source "$SYNTAX_HIGHLIGHTING_PATH/zsh-syntax-highlighting.zsh"
fi
# Key binding
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo

bindkey -v
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# suppr key
bindkey "e[3~" delete-char

bindkey '^R' history-incremental-search-backward

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init () {
		printf '%s' "${terminfo[smkx]}"
	}
	function zle-line-finish () {
		printf '%s' "${terminfo[rmkx]}"
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi
