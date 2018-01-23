---
layout: post
title: Http Header Referer
date: 2017-12-15 16:08:40
tags: Http
categories: Http
---

# Http Header Referer属性


在浏览器中，我们发出的所有http请求，当然不包括直接在地址栏中输入url。

浏览器都会在我们的http请求的报文的头部，增加Referer这样一个header,它标示着请求的来源。


eg：

```javascript
"Referer":"http://localhost:63342/NewPing_17_11_13/view/analysis.html?_ijt=j0c7r9fnm3f4sas25r5lo9ikmf"
```

添加和接受整个过程代码:

```html
<a href="http://localhost:8080/login/taylor21/123456221">lalala</a>
```

```java

@ResponseBody
    @RequestMapping(value = "/login/{username}/{pwd}", method = RequestMethod.GET)
    public String login(@PathVariable("username") String username,
                        @PathVariable("pwd") String pwd, HttpServletRequest request) {

        System.out.println(request.getHeader("Referer"));
        return "1";
    }
```

```
控制台输出:http://localhost:63342/NewPing_17_11_13/view/analysis.html?_ijt=j0c7r9fnm3f4sas25r5lo9ikmf
```

当然，如果我们要是在postman等工具模拟，肯定是不行的了，需要手动添加header


that's all
