---
title: 鸟哥的Linux私房菜笔记
date: 2017-11-18 17:21:25
tags: Linux
categories: Linux
---

# 鸟哥的Linux私房菜笔记[持续更新...]

## 在终端界面登录linux

我一般来说，利用ssh连接远程服务器比较多，大致的过程是这样的

```
ssh root@xxx.xxx.xxx

...
...

Password:

```




```
[vbird@www ~]$ exit
```

## 命令模式下执行命令

### 开始执行命令

整个命令执行的方式非常简单，只要记住几个重要的概念就可以了，如下：

```
[vbird@www ~]$ command [-options] parameter1 parameter2 ...
                命令      选项       参数1       参数2

说明:
0. 一行命令中第一个输入的部分绝对是“命令”，或“可执行文件”。
1. command为命令的名称，例如变换路径的命令为cd等。
2. 中括号[]并不真实存在于命令中，加入参数设置时，通常参数前会待 - 号
3. parameter1 parameter2.. 为依附在option后面的参数，或者是command的参数
4. 命令，-options,参数等这几个命令中间以空格来区分，不论多少个都视为1个空格
5. 按下[Enter]按键后，该命令就会立即执行。[Enter]按键代表着一行命令的开始启动
6. 命令太长的时候，可以使用(\)来转义[Enter]符号，使命令连续到下一行。
  ！反斜杠后立刻接特殊字符，才能转义。
a. 在Linux系统中，英文大小写字母是不一样的，举例来说，cd和CD并不同。

```

列出三个相同含义的命令:

~的含义是主文件夹
```
[vbird@www ~]$ ls -al ~
[vbird@www ~]$ ls       -al   ~
[vbird@www ~]$ ls -a -l ~
```


## 基础命令的操作


### 支持语言命令

1.显示目前所支持的语言

```
[vbird@www ~]$ echo $LANG
zh_CN.UTF-8
```
上面的意思是说，目前的语言(LANG)为zh_CN.UTF-8

2.修改语言成为英语语系

```
[vbird@www ~]$ LANG=en_US
```
注意上面的命令中没有空格符，且英文语系为en_US!

```
[vbird@www ~]$ echo $LANG
en_US
```

这样就变成了英文语系


### 日期与时间命令

```
[vbird@www ~]$ date
2017年11月18日 星期六 19时19分44秒 CST

[vbird@www ~]$ date +%Y/%m/%d
2017/11/18

[vbird@www ~]$ date +%H:%M
19:22
```

### 日历

列出当月的日历

```
[vbird@www ~]$ cal
  十一月 2017
日 一 二 三 四 五 六
          1  2  3  4
 5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30
```

列出某一年的日历

```
cal 2017
                             2017

        一月                  二月                  三月
日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六
 1  2  3  4  5  6  7            1  2  3  4            1  2  3  4
 8  9 10 11 12 13 14   5  6  7  8  9 10 11   5  6  7  8  9 10 11
15 16 17 18 19 20 21  12 13 14 15 16 17 18  12 13 14 15 16 17 18
22 23 24 25 26 27 28  19 20 21 22 23 24 25  19 20 21 22 23 24 25
29 30 31              26 27 28              26 27 28 29 30 31

        四月                  五月                  六月
日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六
                   1      1  2  3  4  5  6               1  2  3
 2  3  4  5  6  7  8   7  8  9 10 11 12 13   4  5  6  7  8  9 10
 9 10 11 12 13 14 15  14 15 16 17 18 19 20  11 12 13 14 15 16 17
16 17 18 19 20 21 22  21 22 23 24 25 26 27  18 19 20 21 22 23 24
23 24 25 26 27 28 29  28 29 30 31           25 26 27 28 29 30
30
        七月                  八月                  九月
日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六
                   1         1  2  3  4  5                  1  2
 2  3  4  5  6  7  8   6  7  8  9 10 11 12   3  4  5  6  7  8  9
 9 10 11 12 13 14 15  13 14 15 16 17 18 19  10 11 12 13 14 15 16
16 17 18 19 20 21 22  20 21 22 23 24 25 26  17 18 19 20 21 22 23
23 24 25 26 27 28 29  27 28 29 30 31        24 25 26 27 28 29 30
30 31
        十月                 十一月                十二月
日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六
 1  2  3  4  5  6  7            1  2  3  4                  1  2
 8  9 10 11 12 13 14   5  6  7  8  9 10 11   3  4  5  6  7  8  9
15 16 17 18 19 20 21  12 13 14 15 16 17 18  10 11 12 13 14 15 16
22 23 24 25 26 27 28  19 20 21 22 23 24 25  17 18 19 20 21 22 23
29 30 31              26 27 28 29 30        24 25 26 27 28 29 30
                                            31
```

列出2017年11月的日历

```
linsir.github.io git:(master) ✗ cal 11 2017
   十一月 2017
日 一 二 三 四 五 六
         1  2  3  4
5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30
```

### 简单的计算器 bc

```
linsir.github.io git:(master) ✗ bc
bc 1.06
Copyright 1991-1994, 1997, 1998, 2000 Free Software Foundation, Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'.
1/3
0
scale = 3
1/3
.333
```

### 数据同步写入磁盘

```
[vbird@www ~]$ sync
```


在关机之前，我们最好进行几次sync的操作，这样我们可以确保数据已经同步到了磁盘。这样可以把内存中尚未更新的数据写入到磁盘中。并且我们最好在root的用户下进行操作，因为root用户能够掌握所有人的数据。


### 惯用的关机命令:shutdown

shutdown可以完成如下工作:

- 可以自由选择关机模式:是要关机,重启或进入单用户操作模式均可。
- 可以设置关机时间:可以设置成现在立刻关机，也可以设置某一个特定的时间才关机。
- 可以自定义关机消息:在关机之前，可以将自己设置的消息传送给在线用户。
- 可以仅发出警告消息:有时有可能你要进行一些测试，而不想让其他用户打扰，或者是明白地告诉某段时间要注意一下，这个时候可以通过shutdown来通知用户，但不是真正的关机。
- 可以选择是否要用fsck检查文件系统。

```
[vbird@www ~]# /sbin/shutdown [-t 秒] [-arkhncfF] 时间 [警告消息]


参数:

-t sec : -t 否面加秒数，也即“过几秒后关机”的意思
-k     : 不要真的关机，只是发送警告消息出去
-r     : 在将系统的服务停掉之后就重启(常用)
-h     : 将系统的服务停掉后，立刻关机(常用)
-n     : 不经过init程序,直接以shutdown的功能关机
-f     : 关机并开机
-F     : 系统重启后，强制进行fsck的磁盘检查
-c     : 取消已经在进行的shutdown 命令内容
时间   : 这是一定要加入的参数，指定系统关机的时间。

范例:

[root@www ~] # /sbin/shutdown -h 10 'I will shutdown after 10 mins'
# 告诉大家，这台机器将会在十分钟后关机，并且会显示在目前登录者的屏幕前方。

此外，需要注意的是，时间参数无比加入在命令中，否则shutdown会自动跳到run-level 1(就是单用户维护的登
录情况),下面提供几个时间参数的例子:

[root@www ~] # shutdown -h now
立刻关机，其中now相当于时间为0的状态

[root@www ~] # shutdown -h 20:25
系统在今天的20:25分会关机，若在21:25才执行命令，则隔天才会关机

[root@www ~] # shutdown -h +10
系统再过十分钟后关机

[root@www ~] # shutdown -r now
系统立刻重启

[root@www ~] # shutdown -r +30 'The system will reboot'
再过30分钟系统会重启，并显示后面的消息给所有在线的用户

[root@www ~] # shutdown -k now 'This system will reboot'
仅发出警告信件的参数，系统并不会关机

```


### 重启，关机:reboot,halt,poweroff

还有三个命令可以进行重启与关机的任务，那就是reboot,halt,powerof。其实这三个命令调用的库函数都差不多，所以当你使用"man reboot"时，会同时出现三个命令的用法给你看呢。其实我们只需要记住shutdown和reboot这两个命令。不过使用poweroff这个命令却比较简单，通常在重启时，都会执行如下的命令:

```
[root@www ~] # sync; sync; sync; reboot
```



# Linux的文件权限与目录配置


> Linux最优秀的地方之一，就在于它的多用户，多任务的环境。而为了让各个用户具有较保密的文件数据，因此文件的权限管理就变得很重要了。Linux一般将文件可存取访问的身份分为3个类别，分别是owner,group,others,且三种身份各有read,write,execute等权限。若管理不当，你的Linux主机将变得很不舒服！



## Linux文件属性

我们执行"ls -al"将会看到以下的内容:

```
➜  linsir.github.io git:(master) ✗ la -al
total 4776
drwxr-xr-x   19 linSir  staff   646B 11 17 12:19 .
drwxr-xr-x    8 linSir  staff   272B 11 13 14:06 ..
-rw-r--r--@   1 linSir  staff   6.0K 11 14 17:35 .DS_Store
drwxr-xr-x   17 linSir  staff   578B 11 20 20:50 .deploy_git
drwxr-xr-x   13 linSir  staff   442B 11 21 09:33 .git
-rw-r--r--    1 linSir  staff    65B 11 13 14:06 .gitignore
-rw-r--r--    1 linSir  staff    11B 11 13 14:48 CNAME
-rw-r--r--    1 linSir  staff    11K 11 13 14:47 LICENSE
-rw-r--r--    1 linSir  staff    99B 11 14 09:33 README.md
-rw-r--r--    1 linSir  staff   1.8K 11 13 16:45 _config.yml
-rw-r--r--    1 linSir  staff   2.1M 11 20 20:50 db.json
drwxr-xr-x  314 linSir  staff    10K 11 13 18:22 node_modules
-rw-r--r--    1 linSir  staff   108K 11 13 18:22 package-lock.json
-rw-r--r--    1 linSir  staff   515B 11 13 18:22 package.json
drwxr-xr-x   15 linSir  staff   510B 11 17 12:19 public
drwxr-xr-x    5 linSir  staff   170B 11 13 14:06 scaffolds
drwxr-xr-x   10 linSir  staff   340B 11 13 16:43 source
drwxr-xr-x    4 linSir  staff   136B 11 13 14:27 themes
-rw-r--r--    1 linSir  staff    69K 11 13 14:07 yarn.lock

[---权限---] [连接][所有者][用户组][文件容量][修改日期][文件名]

```

``ls -al``的含义是列出当前目录下，所有的文件包括隐藏文件

我们仔细看一下这个权限，一共是10位:

第一个字符代表这个文件是“目录，文件或连接文件等”。

- 若是[d]则是目录
- 若是[-]则是文件
- 若是[l]则表示为连接文件(linkfile)
- 若是[b]则表示设备文件里面的可供存储的接口设备
- 若是[c]则表示设备文件里面的串行端口设备，例如键盘，鼠标(一次性读取设备)


接下来的字符中，以3个为一组，且均为“rwx”的三个参数的组合。其中[r]代表可读,[w]代表可写,[x]代表可执行(execute)。要注意的是，这3个权限的位置不会改变，如果没有权限，就会出现减号[-]而已。

- 第一组为“文件所有者的权限”,以“install.log”那个文件为例，该文件的所有者可以读写，但不可执行。
- 第二组为“同用户组的权限”
- 第三组为“其他非本用户组的权限”



## 如何改变文件属性与权限


- ``chgrp``: 改变文件所属用户组
- ``chown``: 改变文件所有者
- ``chmod``: 改变文件的权限

### 改变所属用户组: chgrp

- 改变一个文件的用户组真的很简单的，直接以chgrp来改变，``chgrp``是``change group``的简称。不过，请记得，要被改变的组名必须在/etc/group文件内存在才行，否则就会显示错误。

```
[root@www ~]#  chgrp [-R] dirname/filename ...
选项与参数:
-R : 进行地柜(recursive)的持续更改，也即连同子目录下的所有文件，目录
都更新成为这个用户组之意。常常用在更改某一目录所有的文件情况。

范例：

[root@www ~]# chgrp users install.log
[root@www ~]# ls -l
-rw-r--r--  1 root users 68495  Jun 25  08:53  install.log

```

### 改变文件所有者: chown

```
[root@www ~] # chown [-R] 账号名称 文件或目录
[root@www ~] # chown [-R] 账号名称:组名 文件或目录
参数:
-R : 进行递归(recursive) 的持续更改,即连同子目录下所有文件都更改

范例:将 install.log的所有者改bin这个账号:
[root@www ~]# chown bin install.log
[root@www ~]# ls -l
-rw-r--r--  1 bin  users 68495 Jun 25 08:53 install.log

范例: 将install.log的所有者与用户组改回为root:
[root@www ~]# chown root:root instal.log
[root@www ~]# ls -l
-rw-r--r-- 1 root root 68495 Jun 25 08:53 install.log

### 改变权限: chmod

- 文件权限的改变使用的命令式chmod这个命令，设置权限的方式有两种，一种是使用数字，另一种是使用符号。

#### 利用数字

Linux的权限有9个，三个是一位。例如:

[-rwxrwx---]分别是:

owner = rwx = 4 + 2 + 1 = 7
group = rwx = 4 + 2 + 1 = 7
others = --- = 0 + 0 + 0 = 0

所以这个文件的权限就是770

我们应用的时候就是: chmod [-R] xyz 文件或目录

```


### 符号类型改变文件权限

```
            u       +       r      
chomd       g       -       w     文件或目录
            o       =       x
            a

        [用户类型] [添加修改赋值] [读,写,可执行]
```

例如我们要设置一个文件的权限成为"-rwxr-xr-x"时，基本上就是:

user(u) :具有可读，可写，可执行的权限；
group与others(g/o):具有可读与执行的权限.

所以就是:

```
[root@www ~]# chmod u=rwx,go=rx .bashrc
# 注意: 那个 u=rwx,go=rx是连在一起的
```

我们也可以通过+ - = 来进行权限的设置，例如:

```
[root@www ~]# chmod a-x .bashrc
# 以上命令就是要把所有人的执行权限都去掉
```
