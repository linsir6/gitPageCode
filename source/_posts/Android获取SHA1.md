---
title: Android获取SHA1
date: 2017-12-07 18:09:21
tags: SHA1获取
categories: Android
---


release:


1. 在Android Studio中打开Terminal或者进入控制台
2. cd到jdk的bin目录下
3. 输入命令 ``keytool -list -keystore /Users/mac/WorkSpace/linGitHub/Daily/key/fuyizhulao.jks``
4. 上面这个命令，大家需要选择自己的jks文件
5. 输入密码
6. 然后就可以看到自己的证书指纹(SHA1)了


效果图：


![](http://upload-images.jianshu.io/upload_images/2585384-e5e707e184452322.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


----

debug版：

mac:

```
keytool -v -list -keystore ~/.android/debug.keystore


*****************  WARNING WARNING WARNING  *****************

密钥库类型: JKS
密钥库提供方: SUN

您的密钥库包含 1 个条目

别名: androiddebugkey
创建日期: 2017-7-1
条目类型: PrivateKeyEntry
证书链长度: 1
证书[1]:
所有者: C=US, O=Android, CN=Android Debug
发布者: C=US, O=Android, CN=Android Debug
序列号: 1
有效期开始日期: Sat Jul 01 15:02:39 CST 2017, 截止日期: Mon Jun 24 15:02:39 CST 2047
证书指纹:
         MD5: FE:BC:F9:60:C4:5D:0E:93:DD:22:99:48:17:2B:73:90
         SHA1: 12:64:70:59:81:D0:FA:69:32:67:5B:84:6A:72:EE:8B:18:F6:8E:EF
         SHA256: FF:73:ED:4F:73:35:70:39:90:53:F0:AB:16:E9:26:E8:63:1C:92:EA:3B:F3:70:3A:16:67:9C:85:C8:B9:B6:03
         签名算法名称: SHA1withRSA
         版本: 1


*******************************************
*******************************************

```
