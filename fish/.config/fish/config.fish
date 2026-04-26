if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

if status is-interactive
    fzf_key_bindings
end

set -gx EDITOR (command -v vim)
set -gx VISUAL (command -v vim)
set -Ua fish_features no-keyboard-protocols

fish_add_path /usr/sbin
fish_add_path $HOME/.local/bin
fish_add_path /usr/local/bin

alias cat 'bat --paging=never --style="plain"'
alias ls 'eza --git --time-style=relative --color-scale=all'
alias l 'eza --git --time-style=relative --color-scale=all'
alias la 'eza -a --git --time-style=relative --color-scale=all'
alias ll 'eza -l --total-size --git --header --time-style=relative --color-scale=all'
alias lla 'eza -la --total-size --git --header --time-style=relative --color-scale=all'
alias lt 'eza --tree --total-size -l --time-style=relative --color-scale=all'
alias lta 'eza --tree -a --total-size -l --time-style=relative --color-scale=all'
alias ww 'cd /mnt/c/Users/f*/'
alias uu 'sudo apt update && sudo apt full-upgrade -y'
alias gg 'git add . && git commit -m "update" && git pull --rebase && git push'

starship init fish | source
