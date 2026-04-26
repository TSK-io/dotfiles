" ==========================================
" 1. 自动安装插件管理器 vim-plug (防呆设计)
" ==========================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ==========================================
" 2. 插件列表
" ==========================================
call plug#begin('~/.vim/plugged')

" fzf 基础插件 (即使系统安装了fzf，也需要这行来加载 vim 对应的核心代码)
Plug 'junegunn/fzf'
" fzf.vim 提供各种极其好用的搜索命令 (:Files, :Rg, :Buffers 等)
Plug 'junegunn/fzf.vim'

call plug#end()


" ==========================================
" 3. 基础 Vim 设置 (防按键冲突和体验优化)
" ==========================================
set nocompatible      " 禁用对老版本 vi 的兼容
set number            " 显示行号
syntax on             " 开启语法高亮
set hlsearch          " 搜索高亮


" ==========================================
" 4. FZF 核心配置与快捷键
" ==========================================
" 将 Leader 键设置为【空格键】(Space)，按起来最舒服
let mapleader = " "

" 让 FZF 在屏幕居中的悬浮窗口中打开 (宽度90%，高度80%)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

" --- 快捷键绑定 ---
" Ctrl + p : 快速查找当前目录下的文件
nnoremap <C-p> :Files<CR>

" Ctrl + b : 快速查找/切换当前 Vim 已经打开的文件 (Buffers)
nnoremap <C-b> :Buffers<CR>

" 空格 + f : (Find) 全局搜索文件内的代码/文本 (强烈建议系统安装 ripgrep)
nnoremap <leader>f :Rg<CR>

" 空格 + h : (History) 查找你最近打开过的历史文件
nnoremap <leader>h :History<CR>

" 空格 + l : (Lines) 在当前打开的文件中模糊搜索某一行
nnoremap <leader>l :BLines<CR>

" 空格 + c : (Commands) 模糊搜索 Vim 的命令
nnoremap <leader>c :Commands<CR>

" 允许 Vim 与系统剪贴板共享数据
set clipboard=unnamedplus
