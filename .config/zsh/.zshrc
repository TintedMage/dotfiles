#Histroy
HISTFILE="$XDG_STATE_HOME/zsh/histfile"
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt inc_append_history

alias vim=nvim

#Shell(zsh) Options
setopt correct

#Keybindings
bindkey -e

# The following lines were added by compinstall
zstyle :compinstall filename '/home/tinted/.config/zsh/.zshrc'
autoload -Uz compinit
# Shamelessly borrowed from Prezto. Regenerates the completion cache approximately daily.
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
_comp_files=($XDG_CACHE_HOME/zsh/zcompcache(Nm-20))
if (( $#_comp_files )); then
    compinit -i -C -d "$XDG_CACHE_HOME/zsh/zcompcache"
else
    compinit -i -d "$XDG_CACHE_HOME/zsh/zcompcache"
fi
unset _comp_files

#Prompt
autoload -U colors && colors
eval "$(starship init zsh)"

#Source Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fastfetch
