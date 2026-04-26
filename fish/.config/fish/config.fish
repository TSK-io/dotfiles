if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

if status is-interactive
    # 开启 Vim 键位模式
    fish_vi_key_bindings
    
    # 设置 Vim 模式下的光标形状（非常推荐，以便直观区分当前模式）
    set fish_cursor_default block          # 普通模式 (Normal)：方块光标
    set fish_cursor_insert line            # 插入模式 (Insert)：竖线光标
    set fish_cursor_replace_one underscore # 替换模式 (Replace)：下划线光标
    set fish_cursor_visual block           # 视觉模式 (Visual)：方块光标

    # 保持 fzf 键位绑定在 Vim 键位之后加载，确保 Ctrl+R 等快捷键不冲突
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
