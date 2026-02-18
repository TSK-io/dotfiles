if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

if status is-interactive
    eval (keychain --eval --quiet --agents ssh github_universal)
    # vi mode
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block
    for mode in default visual
        bind -M $mode up true
        bind -M $mode down true
        bind -M $mode left true
        bind -M $mode right true
    end
    for key in up down left right
        bind -M insert $key true
    end
    fzf_key_bindings
end

set -gx EDITOR (command -v hx)
set -gx VISUAL (command -v hx)
set -gx LOCALSTACK_HOST 127.0.0.1

fish_add_path /usr/sbin
fish_add_path $HOME/.local/bin
fish_add_path ~/go/bin

alias cat 'batcat --paging=never --style="plain"'
alias ls 'eza --git --time-style=relative --color-scale=all'
alias l 'eza --git --time-style=relative --color-scale=all'
alias la 'eza -a --git --time-style=relative --color-scale=all'
alias ll 'eza -l --total-size --git --header --time-style=relative --color-scale=all'
alias lla 'eza -la --total-size --git --header --time-style=relative --color-scale=all'
alias lt 'eza --tree --total-size -l --time-style=relative --color-scale=all'
alias lta 'eza --tree -a --total-size -l --time-style=relative --color-scale=all'
alias nano hx
alias zz "trans -b -sp :zh"
alias xx "trans -b -sp :en"
alias cc "trans -b :zh"

function aa
    tmux save-buffer - | python3 $HOME/dotfiles/docs/chats/scripts/openrouter/openrouter_client_via_openai_sdk.py
end

function check_mypublic_dir --on-variable PWD
    set target_dir "$HOME/MyPublic"
    if test "$PWD" = "$target_dir"
        set_color yellow
        echo -n "已进入 MyPublic 目录,执行"
        set_color red
        echo -n ">>>>> pull_mypublic.sh <<<<<"
        set_color yellow
        echo "拉取云端更新."
        set_color normal
    end
end

function copy --wraps wl-copy --description "Pipe to wl-copy and notify"
    command wl-copy $argv
    if test $status -eq 0
        notify-send -a Terminal -i utilities-terminal "复制成功 (来自终端)" 内容已通过管道命令保存
    end
end

function get_ip --description "Discovers a device IP using its MAC address"
    if not command -v arp-scan >/dev/null
        echo "错误: 'arp-scan' 命令未找到。请先安装 (e.g., sudo dnf install arp-scan)" >&2
        return 1
    end

    set --local device_alias $argv[1]
    set --local mac_address
    switch $device_alias
        case pi
            set mac_address 'd8:3a:dd:7e:c5:dc'
        case '*'
            echo "错误: 未知的设备别名 '$device_alias'。" >&2
            return 1
    end

    echo -n "==> 正在扫描 '$device_alias' ($mac_address)... " >&2

    set --local ip (sudo arp-scan -l | grep -i "$mac_address" | awk '{print $1}')

    if test -z "$ip"
        echo "未找到。" >&2
        echo "错误: 未能在网络上找到设备 '$device_alias'。" >&2
        return 1
    end

    echo "找到！" >&2
    echo $ip
end

function s_pi --description "SSH to Raspberry Pi"
    if set --local pi_ip (get_ip pi)
        echo "✅ 发现树莓派 IP: $pi_ip, 正在连接..."
        TERM=xterm-256color ssh "pi@$pi_ip"
    else
        echo "❌ 连接失败：无法获取 IP 地址。" >&2
        return 1
    end
end

function s_phone1 --description "SSH to Phone 1 (Static IP)"
    read --prompt-str "确保手机 Termux 的 sshd 已启动。按 Enter 连接..."
    echo ""
    ssh -p 8022 "9.9.9.9"
end

starship init fish | source
