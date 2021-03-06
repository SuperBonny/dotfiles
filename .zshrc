zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/bonnee/.zshrc'
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' completer _expand_alias _complete _ignored

zmodload zsh/complist

setopt autocd extendedglob nomatch notify no_share_history

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start {
		echoti smkx
	}
	function zle_application_mode_stop {
		echoti rmkx
	}
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Rehash on USR1
catch_signal_usr1() {
  trap catch_signal_usr1 USR1
  rehash
}
trap catch_signal_usr1 USR1

# Use nearcolor if not on a 24bit terminal
[[ "$COLORTERM" == (24bit|truecolor) || "${terminfo[colors]}" -eq '16777216' ]] || zmodload zsh/nearcolor

if [ -d /usr/share/oh-my-zsh ]; then
  export ZSH=/usr/share/oh-my-zsh
elif [ -d ~/.oh-my-zsh ]; then
  export ZSH=~/.oh-my-zsh
fi

plugins=(git-prompt common-aliases colorize colored-man-pages command-not-found zsh-autosuggestions zsh-syntax-highlighting vi-mode)

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

if [ -n "${ZSH}" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="] "

PROMPT='%F{blue}%m%f %F{yellow}%4~%f '

if type git_super_status &> /dev/null; then
	RPROMPT='$(git_super_status)'
fi
RPROMPT="${RPROMPT}[%F{green}%?%f]"

# pywal
if [ -d ~/.cache/wal ]; then
  if [ -f ~/.config/wpg/sequences ]; then
    (cat ~/.config/wpg/sequences &)
  else
    (cat ~/.cache/wal/sequences &)
  fi

  source ~/.cache/wal/colors-tty.sh
  source ~/.cache/wal/colors.sh
fi
