export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"

ZSH_THEME="robbyrussell"

plugins=(
  sudo
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

alias pro="cd ~/projects"
alias zr="source ~/.zshrc"
alias vim="nvim"
alias zz="cd ~/.config"
alias vimcfg="cd ~/.config/nvim/ && nvim init.lua"
alias clean="sudo pacman -Rns \$(pacman -Qtdq) --noconfirm && sudo pacman -Sc --noconfirm && yay -Yc --noconfirm && sudo rm -rf ~/.cache/ || true && find ~/.cache -type f -print -delete || true && rm -rf ~/.local/share/Trash || true"
alias z="zellij"
alias ls='exa --icons'
alias l='exa --icons'
alias cat='bat --paging=never'


# fnm
FNM_PATH="/home/rxtsel/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/rxtsel/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi
export PATH=$HOME/.local/bin:$PATH

# Bat theme
export BAT_THEME="Solarized (dark)"

export SNACKS_GHOSTTY=true
