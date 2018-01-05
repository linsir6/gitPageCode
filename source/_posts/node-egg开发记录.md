---
layout: post
title: node/egg开发记录
date: 2018-01-02 19:57:05
tags: nodejs
categories: nodejs
---

# node/egg开发记录

## 1. 自己实现一个Memcache

自己手动实现一个Memcache，可以大幅减少查库次数，但是这样可能会加大服务器内存的压力。并且在多实例部署的时候，可能会出现问题，因为可能在不同的实例中，缓存的内容是不一样的，可能返回的值不一样。

实现思路:维护一个缓存的Map:

```JavaScript
let cacheMap: Map<string, { value: any, lastQueryTime: number }> = new Map();
```

这样我们，就可以在访问之前，查一下cacheMap，判断数据是否存在，并且查看缓存时间是否有效。


## 2. restful风格应用

做一些业务的后台接口，主要是围绕着增删改查展开的，这个时候我们就可以很好的和restful结合在一起。
例如:

- 获取学生信息

GET /api/student

- 新增学生信息

POST /api/student

- 修改学生信息

PUT /api/student/123

- 删除学生信息

DELETE /api/student/123

这样我们也可以很好的服用http状态码，例如200,201,204等等。

这样做的好处就在于，接口定义的简单，方便高效。最重要的一点的是，更看重的是约定，前端后端一定都要遵守这个约定。缺点在于，像一些静态语言，处理起来可能没有动态语言那么方便。

## 3. egg/Application

这个Application是全局应用对象，在一个应用中，只会实例化一次，它继承自Koa.Application，在它上我们可以挂在一些全局的方法和对象。

在这里面挂载的方法，在编写应用的任何一个地方都可以获取到，例如:Controller，Middleware，Helper，Service 中都可以通过 this.app 访问到 Application 对象。

在 app.js 中 app 对象会作为第一个参数注入到入口函数中

```JavaScript
// app.js
module.exports = app => {
  // 使用 app 对象
};
```

### 扩展方式

框架会把 app/extend/application.js 中定义的对象与 Koa Application 的 prototype 对象进行合并，在应用启动时会基于扩展后的 prototype 生成 app 对象。

### 方法扩展
例如，我们要增加一个 app.foo() 方法：

```
// app/extend/application.js
module.exports = {
  foo(param) {
    // this 就是 app 对象，在其中可以调用 app 上的其他方法，或访问属性
  },
};
```

### 属性扩展

一般来说属性的计算只需要进行一次，那么一定要实现缓存，否则在多次访问属性时会计算多次，这样会降低应用性能。

推荐的方式是使用 Symbol + Getter 的模式。

例如，增加一个 app.bar 属性 Getter：

```
// app/extend/application.js
const BAR = Symbol('Application#bar');

module.exports = {
  get bar() {
    // this 就是 app 对象，在其中可以调用 app 上的其他方法，或访问属性
    if (!this[BAR]) {
      // 实际情况肯定更复杂
      this[BAR] = this.config.xx + this.config.yy;
    }
    return this[BAR];
  },
};
```

注: Symbol是一个能确保唯一性的东西，它是在ES6中新引入的内容。

## 4. egg/Context

Context 指的是 Koa 的请求上下文，这是 请求级别 的对象，每次请求生成一个 Context 实例，通常我们也简写成 ctx。在所有的文档中，Context 和 ctx 都是指 Koa 的上下文对象。

### 访问方式

middleware 中 this 就是 ctx，例如 this.cookies.get('foo')。
controller 有两种写法，类的写法通过 this.ctx，方法的写法直接通过 ctx 入参。
helper，service 中的 this 指向 helper，service 对象本身，使用 this.ctx 访问 context 对象，例如 this.ctx.cookies.get('foo')。
 
### 扩展方式
 
框架会把 app/extend/context.js 中定义的对象与 Koa Context 的 prototype 对象进行合并，在处理请求时会基于扩展后的 prototype 生成 ctx 对象。

### 方法扩展
例如，我们要增加一个 ctx.foo() 方法：

```javascript
// app/extend/context.js
module.exports = {
  foo(param) {
    // this 就是 ctx 对象，在其中可以调用 ctx 上的其他方法，或访问属性
  },
};
```

### 属性扩展

一般来说属性的计算在同一次请求中只需要进行一次，那么一定要实现缓存，否则在同一次请求中多次访问属性时会计算多次，这样会降低应用性能。

推荐的方式是使用 Symbol + Getter 的模式。

例如，增加一个 ctx.bar 属性 Getter：

```javascript
// app/extend/context.js
const BAR = Symbol('Context#bar');

module.exports = {
  get bar() {
    // this 就是 ctx 对象，在其中可以调用 ctx 上的其他方法，或访问属性
    if (!this[BAR]) {
      // 例如，从 header 中获取，实际情况肯定更复杂
      this[BAR] = this.get('x-bar');
    }
    return this[BAR];
  },
};
```

## 5. 利用map进行类型转换

```javascript
item.map(o => new MaterialNewsVM(o));
```

这样的语法，我们便可以把一个item，转成MaterialNewsVM类型。

### 6. 利用reduce对数组进行分类

```javascript
let defaults = dics.reduce((prev, rule) => {
                if (rule.key === `revert_by_attention_${account}`) {
                    prev.attention = JSON.parse(rule.value);
                } else if (rule.key === `revert_by_message_${account}`) {
                    prev.message = JSON.parse(rule.value);
                }
                return prev;
            }, {} as {
                attention: ReplyCacheVM;
                message: ReplyCacheVM;
            });
```















