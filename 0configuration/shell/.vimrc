" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible              " 去除VI一致性,必须要添加
filetype off                  " 必须要添加

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一种选择, 指定一个vundle安装插件的路径
"call vundle#begin('~/some/path/here')

" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-scripts/indentpython.vim'	"自动缩进
Plugin 'scrooloose/syntastic'	"保存文件时语法检查
Plugin 'nvie/vim-flake8'	"添加PEP8代码风格的检查
Plugin 'scrooloose/nerdtree'	"文件树
Plugin 'kien/ctrlp.vim'    "超级搜索
"Plugin 'Lokaltog/powerline'	"Powerline状态栏
Plugin 'Yggdroot/indentline'	"缩进指示线
Plugin 'suan/vim-instant-markdown'
"Plugin 'jnurmine/Zenburn'	"zenburn配色
"Plugin 'altercation/vim-colors-solarized'	"solarized配色
"plugin 'jiangmiao/auto-pairs'	"自动补全括号和引号等

" 你的所有插件需要在下面这行之前
call vundle#end()            " 必须
filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
" 忽视插件改变缩进,可以使用以下替代:
"filetype plugin on
"
" 常用的命令
" :PluginList       - 列出所有已配置的插件
" :PluginInstall  	 - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
"
" 查阅 :h vundle 获取更多细节和wiki以及FAQ
" 将你自己对非插件片段放在这行之后

"支持PEP8风格
au BufNewFile,BufRead *.py
\ set tabstop=4   	"tab宽度
\ set softtabstop=4 
\ set shiftwidth=4  
\ set textwidth=79	"行最大宽度
\ set expandtab       	"tab替换为空格键
\ set autoindent      	"自动缩进
\ set fileformat=unix   "保存文件格式


"js css
au BufNewFile,BufRead *.js, *.html, *.css
\ set tabstop=2
\ set softtabstop=2
\ set shiftwidth=2

"标记多余的空白字符串
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match Error /\s\+$/


set nu			"显示行号
syntax on		"语法高亮
set nocompatible	"关闭与vi的兼容模式
set nowrap		"不自动折行
set showmatch		"显示匹配的括号
set scrolloff=3		"距离顶部和底部3行"
set encoding=utf-8	"编码
set fenc=utf-8		"编码
set mouse=a		"启用鼠标
set hlsearch		"搜索高亮
set wrap		"设置自动折行

set smartindent		"自动识别花括号等字符，采取不缩进。
set autoindent      	"自动缩进
" 设置（软）制表符宽度为4：
set tabstop=4		"tab 宽度
set softtabstop=4   "在Insert模式的时候按退格键时退回缩进的长度 

set expandtab		"tab替换为空格 
set shiftwidth=4	"自动缩进为4

"开启很多对不规范的Python语法的警告提示
let python_highlight_all=1

"set clipboard=unnamed	 "访问系统的剪切板

""根据gui模式和终端模式切换
"if has('gui_running')
"	    set background=light
"    else
"	        set background=dark
"	endif
""添加逻辑判断配色方案
"if has('gui_running')
"    set background=dark
"    colorscheme solarized
"else
"    colorscheme zenburn
"endif

"添加目录树快捷键
map <C-n> :NERDTreeToggle<CR>

"split navigations 切换分割布局
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"一键执行python代码
map <F5> :call RunPython()<CR>
func! RunPython()
	exec "W"
	if &filetype == 'python'
		exec "!time python %"
	endif
endfunc

"分割窗口在下方或者右方打开
set splitbelow
set splitright

"vim 退格键（backspace）不能用
set backspace=indent,eol,start 


"开启代码折叠
set foldmethod=indent
set foldlevel=99
"设置快捷键为空格
nnoremap <space> za
"显示折叠代码的文档字符串
let g:SimpylFold_docstring_preview=1

"选择molokai配色 
colorscheme molokai
set t_Co=256
"set background=light

"nerftree
"是否显示隐藏文件
let NERDTreeShowHidden=1
"设置宽度
let NERDTreeWinSize=31
" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
"忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']

"设置插入模式快捷键 解决代码复制格式错乱问题
set pastetoggle=<F9>


"""自动补全括号引号
""inoremap ' ''<ESC>i
""inoremap " ""<ESC>i
""inoremap ( ()<ESC>i
""inoremap [ []<ESC>i
""inoremap { {<CR>}<ESC>O


" ################追加配置Ⅱ,自动编写文件头部信息###################################
autocmd BufNewFile *.py,*.sh,*.c exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
        "如果文件类型为.sh文件
        if &filetype == 'sh'
                call setline(1,"\#!/bin/bash")
"                call append(line("."),   "\###############################################")
"                call append(line(".")+1, "\# Author        : SangUn")
"                call append(line(".")+2, "\# EMail         : SangUn.Yong@Gmail.com")
"                call append(line(".")+3, "\# Created Time  : ".strftime("%F %T"))
"                call append(line(".")+4, "\# File Name     : ".expand("%"))
"                call append(line(".")+5, "\# Description   :")
"                call append(line(".")+6, "\###############################################")
                call append(line(".")+7, "") 
        endif
        "如果文件类型为.py文件
        if &filetype == 'python'
                call setline(1, "\#!/usr/bin/python3")
                call append(line("."),   "\# -*- coding:utf-8 -*-")
"                call append(line(".")+1, "\###############################################")
"                call append(line(".")+2, "\# Author        : SangUn")
"                call append(line(".")+3, "\# EMail         : SangUn.Yong@Gmail.com")
"                call append(line(".")+4, "\# Created Time  : ".strftime("%F %T"))
"                call append(line(".")+5, "\# File Name     : ".expand("%"))
"                call append(line(".")+6, "\# Description   :")
"                call append(line(".")+7, "\###############################################")
                call append(line(".")+8, "") 
        endif
        "如果文件类型为.c文件
        if &filetype == "c" 
                call setline(1, "\#include<stdio.h>")
                call append(line("."), "") 
        endif
endfunc
"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G

"vim中启用Powerline
set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim
set laststatus=2
set t_Co=256


" 确保文件类型检测打开
filetype plugin on
" 关闭实时预览
let g:instant_markdown_slow = 1
" 关闭打开文件自动预览
let g:instant_markdown_autostart = 0
" 开放给网络上的其他人
let g:instant_markdown_open_to_the_world = 1
" 允许脚本允许
let g:instant_markdown_allow_unsafe_content = 1
" 阻止外部资源加载
let g:instant_markdown_allow_external_content = 0
map <F11> :InstantMarkdownPreview<CR>

