hyfetch # Startup

# PATH and environment
set -gx GOPATH "$HOME/go"
fish_add_path "$HOME/.local/bin"
fish_add_path "$GOPATH/bin"
fish_add_path "$HOME/.spicetify"
fish_add_path "$HOME/.lmstudio/bin" # LM Studio CLI (lms)

# Tool initialization
if test -x "$HOME/.local/bin/oh-my-posh"
    "$HOME/.local/bin/oh-my-posh" init fish --config "$HOME/.config/oh-my-posh/main.toml" | source
end

if type -q zoxide
    zoxide init fish --cmd cd | source
end

if type -q pay-respects
    pay-respects fish --alias fuck | source
end

# Aliases
alias ssh='kitten ssh'
alias ls='lsd'
alias py='python'
alias zed='zeditor'
alias cat='bat --paging=never'
alias catt='bat --paging=never -p'
alias cats='/bin/cat'
