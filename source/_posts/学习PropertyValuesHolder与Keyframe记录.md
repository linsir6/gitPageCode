---
title: 学习PropertyValuesHolder与Keyframe记录
date: 2017-12-06 17:32:42
tags: Android动画
categories: Android
---



# 学习PropertyValuesHolder与Keyframe记录



自定义动画的方法，之前学习了ValueAnimator,ObjectAnimator,他们具有OfInt(),OfFloat(),ofObject()这些函数的用法。他们还具有以下两个方法，是我们之前没有学到的方法:

```Java

/** 
 * valueAnimator的 
 */  
public static ValueAnimator ofPropertyValuesHolder(PropertyValuesHolder... values)   
/** 
 * ObjectAnimator的 
 */  
public static ObjectAnimator ofPropertyValuesHolder(Object target,PropertyValuesHolder... values)
```


也就是说ValueAnimator和ObjectAnimator除了通过OfInt(),OfFloat(),ofObject()创建实例外，还都可以通过ofPropertyValuesHolder（）方法来创建实例

由于ValueAnimator和ObjectAnimator都具有ofPropertyValuesHolder（）函数，使用方法也差不多，相比而言，ValueAnimator的使用机会不多，这里我们就只讲ObjectAnimator中ofPropertyValuesHolder（）的用法。相信大家懂了这篇以后，再去看ValueAnimator的ofPropertyValuesHolder（），也应该是会用的。

# PropertyValuesHolde

## 概述

PropertyValuesHolder这个类的意义就是，它其中保存了动画过程中所需要操作的属性和对应的值。我们通过ofFloat(Object target, String propertyName, float… values)构造的动画，ofFloat()的内部实现其实就是将传进来的参数封装成PropertyValuesHolder实例来保存动画状态。在封装成PropertyValuesHolder实例以后，后期的各种操作也是以PropertyValuesHolder为主的。 
说到这里，大家就知道这个PropertyValuesHolder是有多有用了吧，上面我们也说了，ObjectAnimator给我们提供了一个口子，让我们自己构造PropertyValuesHolder来构造动画。

```java
public static ObjectAnimator ofPropertyValuesHolder(Object target,PropertyValuesHolder... values)

```


```java
public static PropertyValuesHolder ofFloat(String propertyName, float... values)  
public static PropertyValuesHolder ofInt(String propertyName, int... values)   
public static PropertyValuesHolder ofObject(String propertyName, TypeEvaluator evaluator,Object... values)  
public static PropertyValuesHolder ofKeyframe(String propertyName, Keyframe... values)


```

这里面一共有四个创建实例的方法，ofFloat(),ofInt(),ofObject(),ofKeyframe()



### ofFloat(),ofInt()

构造方法:

```Java
public static PropertyValuesHolder ofFloat(String propertyName, float... values)  
public static PropertyValuesHolder ofInt(String propertyName, int... values)


其中:
propertyName:表示ObjectAnimator需要操作的属性名。即ObjectAnimator需要通过反射查找对应的属性的setProperty()函数的那个property

values:属性所对应的参数，是可变长的参数，我们可以指定一个也可以指定多个。


ObjectAnimator的OfFloat：

```java
public static ObjectAnimator ofPropertyValuesHolder(Object target,PropertyValuesHolder... values)
```

其中:

- target: 指需要执行动画的控件
- values: 是一个可变长的参数，可以传进去多个PropertyValuesHolder实例，由于每个PropertyValuesHolder实例都会针对一个属性做动画，所以如果传进去多个PropertyValuesHolder实例，将会对控件的多个属性进行同时操作。


























































