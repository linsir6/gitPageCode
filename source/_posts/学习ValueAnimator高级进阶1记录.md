---
title: 学习ValueAnimator高级进阶1记录
date: 2017-11-29 20:17:32
tags: Android动画
categories: Android
---

# 学习ValueAnimator高级进阶1记录

注:本文并非原创，本文为学习[启舰大神博客](http://blog.csdn.net/harvic880925/article/details/50995268)的笔记~

## 插值器

插值器，也叫加速器，它可以在一次动画中加速或者减速。

示例:

BounceInterpolator（弹跳插值器）: 动画结束的时候弹起

```java
ValueAnimator animator = ValueAnimator.ofInt(0,600);  

animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {  
    @Override  
    public void onAnimationUpdate(ValueAnimator animation) {  
        int curValue = (int)animation.getAnimatedValue();  
        tv.layout(tv.getLeft(),curValue,tv.getRight(),curValue+tv.getHeight());  
    }  
});  
animator.setDuration(1000);  
animator.setInterpolator(new BounceInterpolator());  
animator.start();  
```

以上便是一个应用插值器的例子，它会在动画结束的时候弹起来。


## 自定义插值器

参考: LinearInterpolator

```java
public class LinearInterpolator implements Interpolator {  

    public LinearInterpolator() {  
    }  

    public LinearInterpolator(Context context, AttributeSet attrs) {  
    }  

    public float getInterpolation(float input) {  
        return input;  
    }  
}  
public interface Interpolator extends TimeInterpolator {  
}  
```

LinearInterpolator实现了Interpolator接口；而Interpolator接口则直接继承自TimeInterpolator，而且并没有添加任何其它的方法。
那我们来看看TimeInterpolator接口都有哪些函数吧：

```java
/**
 * A time interpolator defines the rate of change of an animation. This allows animations
 * to have non-linear motion, such as acceleration and deceleration.
 */  
public interface TimeInterpolator {  

    /**
     * Maps a value representing the elapsed fraction of an animation to a value that represents
     * the interpolated fraction. This interpolated value is then multiplied by the change in
     * value of an animation to derive the animated value at the current elapsed animation time.
     *
     * @param input A value between 0 and 1.0 indicating our current point
     *        in the animation where 0 represents the start and 1.0 represents
     *        the end
     * @return The interpolation value. This value can be more than 1.0 for
     *         interpolators which overshoot their targets, or less than 0 for
     *         interpolators that undershoot their targets.
     */  
    float getInterpolation(float input);  
}  
```

这里是TimeInterpolator的代码，它里面只有一个函数float getInterpolation(float input);我们来讲讲这个函数是干什么的。

参数input:input参数是一个float类型，它取值范围是0到1，表示当前动画的进度，取0时表示动画刚开始，取1时表示动画结束，取0.5时表示动画中间的位置，其它类推。

返回值：表示当前实际想要显示的进度。取值可以超过1也可以小于0，超过1表示已经超过目标值，小于0表示小于开始位置。

对于input参数，它表示的是当前动画的进度，匀速增加的。什么叫动画的进度，动画的进度就是动画在时间上的进度，与我们的任何设置无关，随着时间的增长，动画的进度自然的增加，从0到1；input参数相当于时间的概念，我们通过setDuration()指定了动画的时长，在这个时间范围内，动画进度肯定是一点点增加的；就相当于我们播放一首歌，这首歌的进度是从0到1是一样的。

而返回值则表示动画的数值进度，它的对应的数值范围是我们通过ofInt(),ofFloat()来指定的，这个返回值就表示当前时间所对应的数值的进度。

我们先看看下面这段代码：

```java
ValueAnimator anim = ValueAnimator.ofInt(100, 400);    
anim.setDuration(1000);    
anim.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {    
    @Override    
    public void onAnimationUpdate(ValueAnimator animation) {    
        float currentValue = (float) animation.getAnimatedValue();    
        Log.d("TAG", "cuurent value is " + currentValue);    
    }    
});    
anim.start();    
```

我们知道，在我们添加了AnimatorUpdateListener的监听以后，通过在监听函数中调用 animation.getAnimatedValue()就可以得到当前的值；
那当前的值是怎么来的呢？见下面的计算公式：（目前这么理解，后面会细讲真实情况）

``当前的值 = 100 + （400 - 100）* 显示进度``

其中100和400就是我们设置的ofInt(100,400)中的值，这个公式应该是比较容易理解的，就相当于我们做一个应用题：
小明从100的位置开始出发向400的位置开始跑去，在走到全程距离20%位置时，请问小明在哪个数字点上？
当前的值 = 100 + （400 -100）* 0.2；
很简单的应用题，ofInt()中AnimatorUpdateListener中的当前值就是这么来的。从这里大家可以看到，显示进度就表示的是当前的值的位置。但由于我们可以通过指定getInterpolation()的返回值来指定当前的显示值的进度，所以随着时间的增加，我们可以让值随意在我们想让它在的位置。
再重复一遍，input参数与任何我们设定的值没关系，只与时间有关，随着时间的增长，动画的进度也自然的增加，input参数就代表了当前动画的进度。而返回值则表示动画的当前数值进度
通过上面我们应该知道了input参数getInterpolation()返回值的关系了，下面我们来看看LinearInterpolator是如何重写TimeInterpolator的：

```
public class LinearInterpolator implements Interpolator {  

    …………  

    public float getInterpolation(float input) {  
        return input;  
    }  
}  
```

从上面可以看到，LinearInterpolator在getInterpolation函数中，直接把input值返回，即以当前动画的进度做为动画的数值进度，这也就表示当前动画的数值进度与动画的时间进度一致，比如，如果当前动画进度为0，那动画的数值进度也是0，那如果动画进度为0.5，那动画的数值进度也是在0.5，当动画结束，动画的进度就变成1了，而动画的数值进度也是1了。
下面我们就用一个例子来讲一下如何自定义插值器。

### 自定义插值器示例

```java
public class MyInterploator implements TimeInterpolator {  
    @Override  
    public float getInterpolation(float input) {  
        return 1-input;  
    }  
}  
```
在getInterpolation函数中，我们将进度反转过来，当传0的时候，我们让它数值进度在完成的位置，当完成的时候，我们让它在开始的位置

然后使用我们的插值器：

```java
ValueAnimator animator = ValueAnimator.ofInt(0,600);  

animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {  
    @Override  
    public void onAnimationUpdate(ValueAnimator animation) {  
        int curValue = (int)animation.getAnimatedValue();  
        tv.layout(tv.getLeft(),curValue,tv.getRight(),curValue+tv.getHeight());  
    }  
});  
animator.setDuration(1000);  
animator.setInterpolator(new MyInterploator());  
animator.start();  
```

从效果图中可见，我们将数值进度倒序返回——即随着动画进度的推进，动画的数值进度从结束位置进行到起始位置；
到这里，想必大家应该已经理解了getInterpolation(float input)函数中input参数与返回值的关系，在重写插值器时，需要强有力的数学知识做基础，一般而言，都是通过数学公式来计算插值器的变化趋势的，大家可以再分析分析其它几个插值器的写法；可以把它他们总结成公式，放到公式画图软件里，看看对应的数学图在(0,1)之间的走向，这个走向就是插值器在数值变化时的样子。


## Evaluator

### 概述

```
(1)                (2)         (3)             (4)
ofInt(0,400)  -->  加速器  -->  Evaluator  -->  监听器返回
(1.定义动画数字区间) (2.返回当前数字进度) (3.根据当前进度返回值) (4.在AnimatorUpdateListener中返回)
```

以上四个步骤便是整个动画对应的过程。


- ofInt(0,400)表示指定动画的数字区间，是从0运动到400
- 加速器: 动画开始后，通过加速器会返回当前动画进度多对应的数字进度，但是这个数字进度是百分制的，以小数表示如0.2
- Evaluator: 这个就是，通过我们上一步的小数，转换成真正要用到的数字进度的地方，在这里我们可以添加一些数学公式，或者算法，在这里我们可以进行一些计算
- 监听器: 通过在AnimatorUpdateListener监听器使用animation.getAnimatedValue()函数拿到Evaluator中返回数字值

### 举例Evaluator

加速器返回的是小数值，这个值是在0到1之间的。我们定义动画的时候，是有两个函数的，一个是ofInt,一个是ofFloat,它们的返回值是不同的，一个是int,一个是float,所以这两种是要设置不同的Evaluator的。

例如:

```java
ValueAnimator animator = ValueAnimator.ofInt(0,600);  

animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {  
    @Override  
    public void onAnimationUpdate(ValueAnimator animation) {  
        int curValue = (int)animation.getAnimatedValue();  
        tv.layout(tv.getLeft(),curValue,tv.getRight(),curValue+tv.getHeight());  
    }  
});  
animator.setDuration(1000);  
animator.setEvaluator(new IntEvaluator());  
animator.setInterpolator(new BounceInterpolator());  
animator.start();  
```

但大家会说了，在此之前，我们在使用ofInt()时，从来没有给它定义过使用IntEvaluator来转换值啊，那怎么也能正常运行呢？因为ofInt和ofFloat都是系统直接提供的函数，所以在使用时都会有默认的加速器和Evaluator来使用的，不指定则使用默认的；对于Evaluator而言，ofInt()的默认Evaluator当然是IntEvaluator;而FloatEvalutar默认的则是FloatEvalutor;
上面，我们已经弄清楚Evaluator定义和使用方法，下面我们就来看看IntEvaluator内部是怎么实现的吧：

```java
/**
 * This evaluator can be used to perform type interpolation between <code>int</code> values.
 */  
public class IntEvaluator implements TypeEvaluator<Integer> {  

    /**
     * This function returns the result of linearly interpolating the start and end values, with
     * <code>fraction</code> representing the proportion between the start and end values. The
     * calculation is a simple parametric calculation: <code>result = x0 + t * (v1 - v0)</code>,
     * where <code>x0</code> is <code>startValue</code>, <code>x1</code> is <code>endValue</code>,
     * and <code>t</code> is <code>fraction</code>.
     *
     * @param fraction   The fraction from the starting to the ending values
     * @param startValue The start value; should be of type <code>int</code> or
     *                   <code>Integer</code>
     * @param endValue   The end value; should be of type <code>int</code> or <code>Integer</code>
     * @return A linear interpolation between the start and end values, given the
     *         <code>fraction</code> parameter.
     */  
    public Integer evaluate(float fraction, Integer startValue, Integer endValue) {  
        int startInt = startValue;  
        return (int)(startInt + fraction * (endValue - startInt));  
    }  
}  
```

可以看到在IntEvaluator中只有一个函数(float fraction, Integer startValue, Integer endValue) ；
其中fraction就是加速器中的返回值，表示当前动画的数值进度，百分制的小数表示。
startValue和endValue分别对应ofInt(int start,int end)中的start和end的数值；
比如我们假设当我们定义的动画ofInt(100,400)进行到数值进度20%的时候，那么此时在evaluate函数中，fraction的值就是0.2，startValue的值是100，endValue的值是400；理解上应该没什么难度。
下面我们就来看看evaluate(float fraction, Integer startValue, Integer endValue) 是如何根据进度小数值来计算出具体数字的：

```java
return (int)(startInt + fraction * (endValue - startInt));  
```

### 自定义Evalutor

#### 简单实现MyEvalutor

前面我们看了IntEvalutor的代码，我们仿照IntEvalutor的实现方法，我们自定义一个MyEvalutor:
首先是实现TypeEvaluator接口：

```java
public class MyEvaluator implements TypeEvaluator<Integer> {  
    @Override  
    public Integer evaluate(float fraction, Integer startValue, Integer endValue) {  
        int startInt = startValue;  
        //我们可以在这里做我们想做的处理，也可以运用一些数学公式或者算法
        return (int)(200+startInt + fraction * (endValue - startInt));  
    }  
}  
```

MyEvalutor的使用:

```java
ValueAnimator animator = ValueAnimator.ofInt(0,400);  

animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {  
    @Override  
    public void onAnimationUpdate(ValueAnimator animation) {  
        int curValue = (int)animation.getAnimatedValue();  
        tv.layout(tv.getLeft(),curValue,tv.getRight(),curValue+tv.getHeight());  
    }  
});  
animator.setDuration(1000);  
animator.setEvaluator(new MyEvaluator());  
animator.start();  
```

这样虽然我们设置的是，让他在0，400运动，但是它实际上是在200，600运动的。


## ArghEvalutor

### 使用ArgbEvalutor

这个一个用来颜色过度转换的Evalutor

```java
public class ArgbEvaluator implements TypeEvaluator {  
    public Object evaluate(float fraction, Object startValue, Object endValue) {  
        int startInt = (Integer) startValue;  
        int startA = (startInt >> 24);  
        int startR = (startInt >> 16) & 0xff;  
        int startG = (startInt >> 8) & 0xff;  
        int startB = startInt & 0xff;  

        int endInt = (Integer) endValue;  
        int endA = (endInt >> 24);  
        int endR = (endInt >> 16) & 0xff;  
        int endG = (endInt >> 8) & 0xff;  
        int endB = endInt & 0xff;  

        return (int)((startA + (int)(fraction * (endA - startA))) << 24) |  
                (int)((startR + (int)(fraction * (endR - startR))) << 16) |  
                (int)((startG + (int)(fraction * (endG - startG))) << 8) |  
                (int)((startB + (int)(fraction * (endB - startB))));  
    }  
}  
```

我们在这里关注两个地方，第一返回值是int类型，这说明我们可以使用ofInt()来初始化动画数值范围。第二：颜色值包括A,R,G,B四个值，每个值是8位所以用16进制表示一个颜色值应该是0xffff0000（纯红色）
下面我们就使用一下ArgbEvaluator，并看看效果：

```java
ValueAnimator animator = ValueAnimator.ofInt(0xffffff00,0xff0000ff);  
animator.setEvaluator(new ArgbEvaluator());  
animator.setDuration(3000);  

animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {  
    @Override  
    public void onAnimationUpdate(ValueAnimator animation) {  
        int curValue = (int)animation.getAnimatedValue();  
        tv.setBackgroundColor(curValue);  

    }  
});  

animator.start();  
```

在这里可以设置，颜色的变化范围，它就会自动处理这些了。


### ArgbEvalutor的实现原理

```java
int startInt = (Integer) startValue;  
int startA = (startInt >> 24);  
int startR = (startInt >> 16) & 0xff;  
int startG = (startInt >> 8) & 0xff;  
int startB = startInt & 0xff;  
```

```
颜色值: 0x11223344
         A R G B
```

简单的说，它的改变就是把开始值的A，和最终结束的A，做差，然后等分成一些份，随着动画的推移，随之改变。

当然其它RGB也是一样的，就是数学上的简单的变换。
