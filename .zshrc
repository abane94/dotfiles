# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/aris/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# dotfile setup
alias dotgit='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias lazydotgit='lazygit --git-dir=$HOME/dotfiles/ --work-tree=$HOME'


# init
export CLICOLOR=1

# prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST

# PROMPT="%F{39}%n%f %B%~%b > "

# PROMPT="%K{39}%F{black}%n%f%k%K{39} %k%K{29}%F{black}%~%f%k%K{63}%F{29} %f%k%K{63} > %k"
PROMPT="%K{39}%F{239}%n%f%k%K{29}%F{39} %f%k%K{29}%F{black}%~%f%k%K{63}%F{29} %f%k%K{63}%F{236} > %f%k%F{63} %f"

RPROMPT="${vcs_info_msg_0_} %t"

include ~/.config/zsh/prompt.zsh
include ~/.ignored/.zshrc

# fnm
# export PATH="/Users/Aris.Husanu/Library/Application Support/fnm:$PATH"
# eval "`fnm env`"
