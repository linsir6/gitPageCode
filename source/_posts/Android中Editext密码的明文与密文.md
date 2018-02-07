---
layout: post
title: Android中Editext密码的明文与密文
date: 2018-02-07 16:32:54
tags: Editext
categories: Android
---


# Android中Editext密码的明文与密文


我们在平时写项目的时候，遇到Editext是密文的时候，我们大多数选择加的属性是:

```java
<EditText
    android:id="@+id/input_password"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:inputType="textPassword" />
```

这样就可以让我们Editext内容变成加密的了。

我们也可以通过代码，动态的改变这个Editext的明文/密文:

```java
if (password.getInputType() == InputType.TYPE_CLASS_TEXT) {
	    password.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD);
	} else {
	    password.setInputType(InputType.TYPE_CLASS_TEXT);
	}
```












