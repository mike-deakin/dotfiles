# zsh references $ZDOTFILES to find other dotfiles
# $0 resolves to this file
# :A:h modifies the result to be this absolute directory
# see https://zsh.sourceforge.io/Doc/Release/Expansion.html#Modifiers
ZDOTDIR=${0:A:h}
