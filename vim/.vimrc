" 启用 Vim 语法高亮，让代码和配置文件更容易阅读。
syntax on

" 在普通模式下按 Ctrl+p 调用 FZF 文件搜索。
" 需要系统或插件管理器已安装 FZF，否则按下快捷键时会提示命令不存在。
nnoremap <C-p> :FZF<CR>

" 关闭交换文件，避免在目录中生成 .swp 临时文件。
set noswapfile

" 关闭普通备份文件，避免保存后生成以 ~ 结尾的备份文件。
set nobackup

" 关闭写入备份文件，避免保存过程中生成临时备份文件。
set nowritebackup

" 使用系统剪贴板，方便在 Vim 和其他应用之间复制粘贴。
set clipboard=unnamedplus

" 在普通模式下按 Ctrl+n 切换左侧目录树（NERDTree），并自动显示 git 变更标记。
nnoremap <C-n> :NERDTreeToggle<CR>

" 目录树中显示隐藏文件（如 .gitignore、.vimrc）。
let g:NERDTreeShowHidden = 1

" 启动 Vim 时自动打开目录树，并把光标移回右侧编辑窗口。
autocmd VimEnter * NERDTree | wincmd p

" 按 Ctrl+j 在目录树和编辑区之间来回切换光标（Ctrl+w 已被 kitty 占用）。
nnoremap <C-j> <C-w>w
