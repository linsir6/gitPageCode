---
layout: post
title: typescript学习一
date: 2017-12-26 22:04:33
tags: [NodeJs,TypeScript]
categories: [NodeJs,TypeScript]
---

# typescript语法学习

最近的工作是，node开发，我们团队的技术选型是egg + typescript + typeorm,但是自己js的基础，node的基础，后台的思想，都不是非常的好，打算用这段时间好好补一补。
本文是学习typescript的记录。

## 背景

typescript是微软开发出来的一门语言，它是js的超集，它的代码可以被编译成js，从而为js的语法添加了静态类型的变量，也使得js可以基于类的面向对象编程。

## 基础变量类型

### 变量所有类型

0. 布尔值
1. 数字
2. 字符串
3. 数组
4. 元组
5. 枚举
6. 任意值
7. 空值
8. Null和Undefined
9. Never
10. 类型断言(<string>,as string两种方式)

#### 布尔值

```
let isDone: boolean = false;
```

#### 数字

```
let num1: number = 1; //十进制
let num2: number = 0xf00d; //十六进制
let num3: number = 0b1010; //二进制
let num4: number = 0o744; //八进制
```

#### 字符串

```
let name: string = "bob";
let name2: string = 'bob';
```

#### 模版字符串

你还可以使用模版字符串，它可以定义多行文本和内嵌表达式。 这种字符串是被反引号包围（ `），并且以${ expr }这种形式嵌入表达式

```
let name: string = `Gene`;
let age: number = 37;
let sentence: string = `Hello, my name is ${ name }.

I'll be ${ age + 1 } years old next month.`;
这与下面定义sentence的方式效果相同：

let sentence: string = "Hello, my name is " + name + ".\n\n" +
    "I'll be " + (age + 1) + " years old next month.";
```

#### 数组

```
let list: number[] = [1,2,3];
let list2: Array<number> = [1,2,3];
```

#### 元组

```
let x: [string, number];
x = ['hello', 10]
```

从此这个元组，就是一个联合类型的了，我们可以往里面赋值，string或者number，其它类型是不可以的。

#### 枚举

```
enum Color {Red,Green,Blue};
let c: Color = Color.Green;
```

他们默认情况下是从0开始的，当然我们也可以手动指定数值，例如:

```
enum Color {Red = 1,Green,Blue}
//查找枚举值的名字，例如:
let colorName: string = Color[2];
```

#### 任意值

any ，这个类型是指我们不希望检查器对值进行检查。

```
let a: any = 4;
a = "111";
a = false;
```

```
let list: any[] = [1, true, "free"];
list[1] = 100;
```

## 变量声明

let和const是typescript中变量声明的方式，const能够阻止对同一个变量再次赋值。

let和var的区别，var可以在同一个作用域内多次声明同一个名称的变量，但是let不可以。

```
var x = 10;
var x = 20;

let x = 10;
let x = 20;//错误

```

```
function sumMatrix(matrix: number[][]) {
    let sum = 0;
    for (let i = 0; i < matrix.length; i++) {
        var currentRow = matrix[i];
        for (let i = 0; i < currentRow.length; i++) {
            sum += currentRow[i];
        }
    }

    return sum;
}
```

以上的代码，我们是可以得到我们想要的答案的，这个就是let特有的一个屏蔽的功能。不过这样的代码在读起来的时候，可能是有点困难的，所以尽量不要这样做了。


let和const是两种声明变量的方式，用哪个都可以，不过依照最小特权原则，如果我们声明的变量不希望别人改变的时候应当使用const。

### 解构

#### 解构数组
最简单的解构莫过于数组的解构赋值了：

```
let input = [1, 2];
let [first, second] = input;
console.log(first); // outputs 1
console.log(second); // outputs 2
```

```
let [first, ...rest] = [1, 2, 3, 4];
console.log(first); // outputs 1
console.log(rest); // outputs [ 2, 3, 4 ]
```

当然，由于是JavaScript, 你可以忽略你不关心的尾随元素：

```
let [first] = [1, 2, 3, 4];
console.log(first); // outputs 1
```
或其它元素：
```
let [, second, , fourth] = [1, 2, 3, 4];
```

#### 对象解构
```
let o = {
    a: "foo",
    b: 12,
    c: "bar"
}
let {a, b} = o;
```
