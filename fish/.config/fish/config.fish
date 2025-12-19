# # Bootstrap Fisher if it's missing
if not functions -q fisher
    echo "Fisher not found. Installing..."
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

alias ls="lsd"
alias la="lsd -la"
alias ll="lsd -l"
alias vi='nvim'
alias c='clear'
alias p='pnpm'
alias prd='pnpm run dev'
alias pr='pnpm run'
alias lg='lazygit'
alias ld='lazydocker'

bind \cw forward-word
bind \cb backward-word

set -g fish_greeting ""


export PATH="/opt/homebrew/bin:$PATH"

fzf --fish | source
starship init fish | source
