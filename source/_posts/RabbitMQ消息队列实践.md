---
title: RabbitMQ消息队列实践
date: 2018-01-25 11:55:11
tags: RabbitMQ
categories: RabbitMQ
---

# RabbitMQ消息队列实践

## 消息队列

消息队列最核心解决的问题是避免立即处理那些耗时的任务，也就是避免请求-响应的这种同步模式。取而代之的是我们通过调度算法，让这些耗时的任务之后再执行，也就是采用异步的模式。我们需要将一条消息封装成一个任务，并且将它添加到任务队列里面。后台会运行多个工作进程(worker process)，通过调度算法，将队列里的任务依次弹出来，并交给其中的一个工作进程进行处理执行。这个概念尤其适合那些HTTP短连接的web应用，它们无法在短时间内处理这种复杂的任务。

其实我们在日常的开发中，有很多的动作都是需要异步操作的，例如用户消费过程中，我们需要查修改数据库，然后可能涉及到给用户反馈红包或者发短信提醒。这里面的发红包和短信，可能对实时性的要求没有那么的高，不需要我们在一次http请求中响应完成，所以我们可以把这样的操作放入到MQ当中，我们充当一个生产者，然后MQ的消费者来消费这次事件就可以了。

其实消息队列也是有非常多种的，我们这次项目的技术选型是RabbitMQ，我这面主要想记录一下，nodejs操作MQ的全部过程。

## 在mac上搭建MQ

```
brew install rabbitmq
```

直接样就可以直接下载``rabbitmq``了。

启动mq :

```
cd /usr/local/Cellar/rabbitmq/3.6.9_1/sbin
./rabbitmq-server
```

## node操作MQ

这里面我们引入了一个第三方的库: [squaremo/amqp.node](https://github.com/squaremo/amqp.node)

具体操作大家可以仔细看一下文档，这面展示一个简单的例子。

```
npm install amqplib
```

```javascript
var q = 'tasks';

var open = require('amqplib').connect('amqp://localhost');

// Publisher
open.then(function(conn) {
  return conn.createChannel();
}).then(function(ch) {
  return ch.assertQueue(q).then(function(ok) {
    ch.sendToQueue(q, new Buffer('lin'));
    return ch.sendToQueue(q, new Buffer('something to do'));
  });
}).catch(console.warn);

// Consumer
open.then(function(conn) {
  return conn.createChannel();
}).then(function(ch) {
  return ch.assertQueue(q).then(function(ok) {
    return ch.consume(q, function(msg) {
      if (msg !== null) {
        console.log(msg.content.toString());
        ch.ack(msg);
      }
    });
  });
}).catch(console.warn);
```

以上是一个简单的，生产者和消费者的例子，大家可以用``node app.js``跑一下。
