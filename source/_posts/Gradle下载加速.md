---
title: Gradle下载加速
date: 2018-01-23 10:1:21
tags: Gradle
categories: Gradle
---

# Gradle下载加速

在利用``Gradle``下载内容的时候，经常会出现，长时间卡在那里，下载的进度条一动不动。

这个时候，我们下意识的反应是，我可能被墙了，我要去开翻墙软件，然后打开翻墙软件之后发现依旧没反应，这个是因为大多数的软件代理的都是http的请求，并不会代理其它的请求。

其实，这个时候我们最好的解决方案是，换上阿里的源，这样我们的源就变成了国内的，并且速度非常快。

修改项目根目录下的``build.gradle``：

```
buildscript {
    ext.kotlin_version = '1.2.20'
    repositories {
        maven{ url 'http://maven.aliyun.com/nexus/content/groups/public/'}//阿里的源
        jcenter()
        google()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:3.0.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"

        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}

allprojects {
    repositories {
        maven{ url 'http://maven.aliyun.com/nexus/content/groups/public/'}//阿里的源
        google()
        jcenter()
        mavenCentral()
        maven { url "https://jitpack.io" }
    }

}

```

我们只需要新增以上的两行就可以了，这样我们的下载速度就会非常快了。
