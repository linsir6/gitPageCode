---
title: 学习ValueAnimator基本使用记录
date: 2017-11-29 09:43:17
tags: Android动画
categories: Android
---

# 学习ValueAnimator基本使用记录

跟着[启舰大神的博客](http://blog.csdn.net/harvic880925/article/details/50995268)在走，感觉非常爽，能学到不少自定义控件的东西～

## 概述

之前学习的Animation相关的文章，学习到了alpha、scale、translate、rotate的用法及代码生成方法。这些动画的方式，都属于Tween Animation(补间动画)。

在Android动画中，总共有两种类型的动画，分别是:**View Animation(视图动画)**和**Frame Animation(属性动画)**。

- View Animation包括Tween Animation(补间动画)和Frame Animation(逐帧动画)
- Property Animator包括ValueAnimator和ObjectAniation

差异:

1. 引入时间不同: View Animation是API LEVEL1就引入的。Property Animation是API Levevl 11引入的,即使Android3.0才开始有Property Animation相关的API。
2. 所在包名不同: View Animation在包android.view.animation中。而Property Animation API在包android.animation中。
3. 动画类的命名不同: View Animation中动画类取名都叫XXXXAnimation,而在Property Animator中动画类的取名则叫XXXXAnimator

为什么要在Android3.0之后引入属性动画呢，肯定是因为视图动画有一些它做不到的点。

### 视图动画和属性动画差异的点

1. 属性动画顾名思义嘛，它可以改变View的属性，这一点视图动画就肯定做不到了，当我们想改变控件的背景颜色作为动画的时候那就只能选择属性动画了。

2. 点击事件的响应也是不同的，补间动画仅仅改变了控件显示的位置，并没有改变控件本身的值。补间动画是通过改变其Parent View来实现的，在View 被draw的时候Parent View改变它的绘制参数，这个时候View的大小或者位置改变了，但是View实际的属性并没有发生改变，所以有效点击区域还是原来的区域。

3. 补间动画虽然能对控件作出动画，但是它并没有改变控件内部的属性值。而Property Animator则是恰恰相反，Property Animator是通过改变控件内部的属性值来达到动画效果的。

## ValueAnimator简单使用

我们前面讲了Property Animator包括ValueAnimator和ObjectAnimator；这篇文章就主要来看看ValueAnimator的使用方法吧。
我觉得谷歌那帮老头是最会起名字的人，单从命名上，就能看出来这个东东的含义。ValueAnimator从名字可以看出，这个Animation是针对值的！ValueAnimator不会对控件做任何操作，我们可以给它设定从哪个值运动到哪个值，通过监听这些值的渐变过程来自己操作控件。以前我们曾讲过Scroller类，Scroller类也是不会对控件操作的，也是通过给他设定滚动值和时长，它会自己计算滚动过程，然后我们需要监听它的动画过程来自己操作控件，ValueAnimator的原理与Scroller类相似。

使用方式:

```java
public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        final ValueAnimator animator = ValueAnimator.ofInt(0, 400);
        animator.setDuration(1000);
        animator.start();
        animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
            @Override
            public void onAnimationUpdate(ValueAnimator valueAnimator) {
                int curValue = (int) animator.getAnimatedValue();
                tv.layout(curValue,curValue,curValue+tv.getWidth(),curValue+tv.getHeight());  
                Log.e("lin", "---lin--->  curValue:" + curValue);
            }
        });

        animator.start();

    }
}
```

结果如下:

![](https://ws3.sinaimg.cn/large/006tNc79ly1flyzr21fnzj315a0jqwkg.jpg)

总而言之就是两点：
- ValueAnimator只负责对指定的数字区间进行动画运算
- 我们需要对运算过程进行监听，然后自己对控件做动画操作

在监听过程中，通过layout函数来改变textview的位置。这里注意了，我们是通过layout函数来改变位置的，我们知道layout函数在改变控件位置时是永久性的，即通过更改控件left,top,right,bottom这四个点的坐标来改更改坐标位置的，而不仅仅是从视觉上画在哪个位置，所以通过layout函数更改位置后，控件在新位置是可以响应点击事件的。
大家可能注意到了,layout（）函数中上下左右点的坐标是以屏幕坐标来标准的。所以在效果图中可以看到，textview的运动轨迹是从屏幕的左上角(0,0)点运行到（400，400）点。


## 常用方法

1. ofInt与ofFloat

```java
public static ValueAnimator ofInt(int... values)  
public static ValueAnimator ofFloat(float... values)  
```

他们的参数类型都是可变参数长参数，所以我们可以传入任何数量的值；传进去的值列表，就表示动画时的变化范围；比如ofInt(2,90,45)就表示从数值2变化到数字90再变化到数字45；所以我们传进去的数字越多，动画变化就越复杂。从参数类型也可以看出ofInt与ofFloat的唯一区别就是传入的数字类型不一样，ofInt需要传入Int类型的参数，而ofFloat则表示需要传入Float类型的参数。
下面我们还在上面例子的基础上，使用ofFloat函数来举个例子：


```java
ValueAnimator animator = ValueAnimator.ofFloat(0f,400f,50f,300f);  
animator.setDuration(3000);  

animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {  
    @Override  
    public void onAnimationUpdate(ValueAnimator animation) {  
        Float curValueFloat = (Float)animation.getAnimatedValue();  
        int curValue = curValueFloat.intValue();  
        tv.layout(curValue,curValue,curValue+tv.getWidth(),curValue+tv.getHeight());  
    }  
});  
animator.start();  
```

以上代码便实现了简单的动画效果。

###常用函数

```java
/**
 * 设置动画时长，单位是毫秒
 */  
ValueAnimator setDuration(long duration)  
/**
 * 获取ValueAnimator在运动时，当前运动点的值
 */  
Object getAnimatedValue();  
/**
 * 开始动画
 */  
void start()  
/**
 * 设置循环次数,设置为INFINITE表示无限循环
 */  
void setRepeatCount(int value)  
/**
 * 设置循环模式
 * value取值有RESTART，REVERSE，
 */  
void setRepeatMode(int value)  
/**
 * 取消动画
 */  
void cancel()  
```

以上这几个方法，太好理解啦，就不展开介绍啦。

## 两个监听器

- 监听动画变化时的实时值
- 监听动画变化时四个状态 (onAnimationStart、onAnimationEnd、onAnimationCancel、onAnimationRepeat)

```java
/**
 * 监听器一：监听动画变化时的实时值
 */  
public static interface AnimatorUpdateListener {  
    void onAnimationUpdate(ValueAnimator animation);  
}  
//添加方法为：public void addUpdateListener(AnimatorUpdateListener listener)  
/**
 * 监听器二：监听动画变化时四个状态
 */  
public static interface AnimatorListener {  
    void onAnimationStart(Animator animation);  
    void onAnimationEnd(Animator animation);  
    void onAnimationCancel(Animator animation);  
    void onAnimationRepeat(Animator animation);  
}  
//添加方法为：public void addListener(AnimatorListener listener)
```

注: 添加了的监听器，也都可以移除。


## 其它函数

```java
/**
 * 延时多久时间开始，单位是毫秒
 */  
public void setStartDelay(long startDelay)  
/**
 * 完全克隆一个ValueAnimator实例，包括它所有的设置以及所有对监听器代码的处理
 */  
public ValueAnimator clone()  
```

setStartDelay(long startDelay)非常容易理解，就是设置多久后动画才开始。
但clone()这个函数就有点难度了；首先是什么叫克隆。就是完全一样！注意是完全一样！就是复制出来一个完全一样的新的ValueAnimator实例出来。对原来的那个ValueAnimator是怎么处理的，在这个新的实例中也是全部一样的。
