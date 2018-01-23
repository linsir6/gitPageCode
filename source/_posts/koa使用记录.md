---
title: koa使用记录--接收文件
date: 2017-12-10 14:02:02
tags: koa
categories: NodeJs
---

# koa使用记录--接收文件

koa是一个比较不错的基于node的服务端框架，它采用的是插件化的模式，它可以整合很多很多的中间件，它本身也很小巧。

虽然说，我本身也不太看到node做纯后端开发，但是js的语言表现能力确实是强，同样的代码逻辑，它的代码行数远小于java，而且它的API层的异步IO异步的思想，确实让我很感兴趣，以前也曾简单的用过Koa框架，但是最近部门老大，让我开始写node后端，所以要认真的学一学，多去看看源码了，从这篇简单的记录开始吧，开始我node开发者的身份。

koa想要接收文件，需要依赖``koa-body``，这个中间件，可以很好的为我们处理接收的逻辑，下面我们简单的看一下代码：

```javascript


/**
 * Module dependencies.
 */

const logger = require('koa-logger');
const serve = require('koa-static');
const koaBody = require('koa-body');
const Koa = require('koa');
const fs = require('fs');
const app = new Koa();
const os = require('os');
const path = require('path');

app.use(koaBody({multipart: true}));
app.use(async function (ctx, next) {
    await next();
    if (ctx.body || !ctx.idempotent) return;
    ctx.redirect('/404.html');
});

app.use(serve(path.join(__dirname, '/public')));

app.use(async function (ctx, next) {
    // ignore non-POSTs
    if ('POST' != ctx.method) return await next();

    const file = ctx.request.body.files.file;
    console.log(file.path)
    ctx.body = "success";
});

// listen

app.listen(3000);
console.log('listening on port 3000');

```

这样我们便很轻松的接收到了文件。

![](https://ws4.sinaimg.cn/large/006tNc79ly1fmbndi6givj31920j8t9v.jpg)

按照以上的方式便可以发出请求，记住header一定要空。

好了，以上便是如何利用koa接收文件了。
