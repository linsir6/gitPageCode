---
title: 让ssh,scp这些命令不需要密码
date: 2018-01-19 17:21:25
tags: [linux,ssh,scp]
categories: linux
---

# 让ssh,scp这些命令不需要密码

> 我们平时可能经常需要上我们的服务器上做一些事情，或者需要经常上传一些文件到服务器上面，这个时候，每次都输入密码，我们可能就有点扛不住啦～


## 利用公钥/私钥的模式进行服务器的操作

进入当前路径:

```
/Users/mac/.ssh/
```


![拥有id_rsa.pub](http://upload-images.jianshu.io/upload_images/2585384-4dfd502b058245c7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如果没有这个文件的话：

```
ssh-keygen -t rsa -C "youremail@example.com"
```

然后会有几个提示的问题，都可以不用管，直接回车就可以，完成之后这里面就会生成公钥。

当我们有公钥之后，我们需要把它上传到我们远程服务器的``/root/.ssh/``目录下，并且把它更名成``authorized_keys``，如果我们已经拥有这个文件，我们可以把公钥的内容粘贴到这个文件的后面。



从此之后，我们便可以直接使用``scp``,``ssh``了，便不用输入密码啦。


它的原理就是利用公钥/私钥的方式，取代了密码的方式。


