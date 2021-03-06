---
layout: post
title: vim使用记录
date: 2018-01-31 18:11:08
tags: vim
categories: vim
---


# Vim使用记录


## 解决Vim插入模式下backspace按键无发删除字符的问题

1. 在命令模式下

```
set nocompatible
```

2. 设置backspace的工作方式：

```
set backspace=indent,eol,start 
```


## 快捷键

### 移动光标

```
h,j,k,l 上，下，左，右
ctrl-e 移动页面
ctrl-f 上翻一页
ctrl-b 下翻一页
ctrl-u 上翻半页
ctrl-d 下翻半页
w 跳到下一个字首，按标点或单词分割
W 跳到下一个字首，长跳，如end-of-line被认为是一个字
e 跳到下一个字尾
E 跳到下一个字尾，长跳
b 跳到上一个字
B 跳到上一个字，长跳
0 跳至行首，不管有无缩进，就是跳到第0个字符
^ 跳至行首的第一个字符
$ 跳至行尾
gg 跳至文首
G 调至文尾
5gg/5G 调至第5行
gd 跳至当前光标所在的变量的声明处
fx 在当前行中找x字符，找到了就跳转至
; 重复上一个f命令，而不用重复的输入fx
* 查找光标所在处的单词，向下查找
# 查找光标所在处的单词，向上查找
```

### 删除复制

```
dd 删除光标所在行
dw 删除一个字(word)
d/D删除到行末x删除当前字符X删除前一个字符yy复制一行yw复制一个字y/Y 复制到行末
p 粘贴粘贴板的内容到当前行的下面
P 粘贴粘贴板的内容到当前行的上面
```


### 插入模式

```
i 从当前光标处进入插入模式
I 进入插入模式，并置光标于行首
a 追加模式，置光标于当前光标之后
A 追加模式，置光标于行末
o 在当前行之下新加一行，并进入插入模式
O 在当前行之上新加一行，并进入插入模式
Esc 退出插入模式
```


### 编辑

```
J 将下一行和当前行连接为一行
cc 删除当前行并进入编辑模式
cw 删除当前字，并进入编辑模式
c$ 擦除从当前位置至行末的内容，并进入编辑模式
s 删除当前字符并进入编辑模式
S 删除光标所在行并进入编辑模式
xp 交换当前字符和下一个字符
u 撤销
ctrl+r 重做
~ 切换大小写，当前字符
>> 将当前行右移一个单位
<< 将当前行左移一个单位(一个tab符)
== 自动缩进当前行
```


### 查找替换

```
/pattern 向后搜索字符串pattern
?pattern 向前搜索字符串pattern
"\c" 忽略大小写
"\C" 大小写敏感

n 下一个匹配(如果是/搜索，则是向下的下一个，?搜索则是向上的下一个)
N 上一个匹配(同上)
:%s/old/new/g 搜索整个文件，将所有的old替换为new
:%s/old/new/gc 搜索整个文件，将所有的old替换为new，每次都要你确认是否替换
```

###  推出编辑器

```
:w 将缓冲区写入文件，即保存修改
:wq 保存修改并退出
:x 保存修改并退出
:q 退出，如果对缓冲区进行过修改，则会提示
:q! 强制退出，放弃修改
```


### 多文件编辑

```
vim file1.. 同时打开多个文件
:args 显示当前编辑文件
:next 切换到下个文件
:prev 切换到前个文件
:next！ 不保存当前编辑文件并切换到下个文件
:prev！ 不保存当前编辑文件并切换到上个文件
:wnext 保存当前编辑文件并切换到下个文件
:wprev 保存当前编辑文件并切换到上个文件
:first 定位首文件
:last 定位尾文件
ctrl+^ 快速在最近打开的两个文件间切换
:split[sp] 把当前文件水平分割
:split file 把当前窗口水平分割, file
:vsplit[vsp] file 把当前窗口垂直分割, file
:new file 同split file
:close 关闭当前窗口
:only 只显示当前窗口, 关闭所有其他的窗口
:all 打开所有的窗口
:vertical all 打开所有的窗口, 垂直打开
:qall 对所有窗口执行：q操作
:qall! 对所有窗口执行：q!操作
:wall 对所有窗口执行：w操作
:wqall 对所有窗口执行：wq操作
ctrl-w h 跳转到左边的窗口
ctrl-w j 跳转到下面的窗口
ctrl-w k 跳转到上面的窗口
ctrl-w l 跳转到右边的窗口
ctrl-w t 跳转到最顶上的窗口
ctrl-w b 跳转到最底下的窗口
```


### 多标签编辑

```
:tabedit file 在新标签中打开文件file
:tab split file 在新标签中打开文件file
:tabp 切换到前一个标签
:tabn 切换到后一个标签
:tabc 关闭当前标签
:tabo 关闭其他标签
gt 到下一个tab
gT 到上一个tab
0gt 跳到第一个tab
5gt 跳到第五个tab
```



## .vimrc备份


```
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'git://git.wincent.com/command-t.git'
Plugin 'git://github.com/scrooloose/nerdtree.git'
Plugin 'git://github.com/Xuyuanp/nerdtree-git-plugin.git'

call vundle#end()

map <F2> :NERDTreeToggle<CR>

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

filetype plugin indent on

set nu
syntax on
set autoread
set autoindent
set smartindent
autocmd InsertLeave * se nocul
set showcmd
set nocompatible
set backspace=indent,eol,start




```


























