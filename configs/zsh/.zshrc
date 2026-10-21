hyfetch # Startup

# ──────────────────────────────────────────────
#  Oh My Zsh (plugins MUST be set before sourcing)
# ──────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# Theme is handled by oh-my-posh below
ZSH_THEME=""

# Syntax highlighting goes near the end, history-substring-search after it
plugins=(
    git
    archlinux
    sudo
    web-search
    emoji
    encode64
    zsh-autosuggestions
    fast-syntax-highlighting
    zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

# ──────────────────────────────────────────────
#  PATH & environment
# ──────────────────────────────────────────────
export GOPATH="$HOME/go"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.spicetify"
export PATH="$PATH:$HOME/.lmstudio/bin"   # LM Studio CLI (lms)

unsetopt BEEP

# ──────────────────────────────────────────────
#  Tool init (after OMZ so nothing overrides them)
# ──────────────────────────────────────────────
eval "$($HOME/.local/bin/oh-my-posh init zsh --config "$HOME/.config/oh-my-posh/main.toml")"
eval "$(zoxide init zsh --cmd cd)"            # cd is now zoxide, plus cdi for interactive
eval "$(pay-respects zsh --alias fuck)"       # type `fuck` after a typo

# ──────────────────────────────────────────────
#  Aliases
# ──────────────────────────────────────────────
alias ssh='kitten ssh'
alias ls='lsd'
alias py='python'
alias zed='zeditor'

alias sudo='doas'
alias sudoedit='doasedit'

alias cat='bat --paging=never'
alias catt='bat --paging=never -p'
alias cats='/bin/cat'
