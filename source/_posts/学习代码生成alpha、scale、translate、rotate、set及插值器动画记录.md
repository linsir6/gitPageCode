---
title: 学习代码生成alpha、scale、translate、rotate、set及插值器动画记录
date: 2017-11-28 17:16:30
tags: Android动画
categories: Android
---



# 学习代码生成alpha、scale、translate、rotate、set及插值器动画记录

> 最近在跟着系列教程学习[Android自定义控件三部曲文章索引](http://blog.csdn.net/harvic880925/article/details/50995268)，将学习的内容总结一下。

## 动画标签

- scale — ScaleAnimation
- alpha — AlphaAnimation
- rotate — RotateAnimation
- translate — TranslateAnimation
- set — AnimationSet


## Animation公共属性

- android:duration —— setDuration(long)	 动画持续时间，以毫秒为单位
- android:fillAfter —— setFillAfter(boolean)	如果设置为true，控件动画结束时，将保持动画最后时的状态
- android:fillBefore —— setFillBefore(boolean)	如果设置为true,控件动画结束时，还原到开始动画前的状态
- android:fillEnabled —— setFillEnabled(boolean)	与android:fillBefore 效果相同，都是在动画结束时，将控件还原到初始化状态
- android:repeatCount —— setRepeatCount(int)	重复次数
- android:repeatMode —— setRepeatMode(int)	重复类型，有reverse和restart两个值，取值为RESTART或 REVERSE，必须与repeatCount一起使用才能看到效果。因为这里的意义是重复的类型，即回放时的动作。
- android:interpolator —— setInterpolator(Interpolator) 设定插值器，其实就是指定的动作效果，比如弹跳效果等



## ScaleAnimation

- android:fromXScale    起始的X方向上相对自身的缩放比例，浮点值，比如1.0代表自身无变化，0.5代表起始时缩小一倍，2.0代表放大一倍；
- android:toXScale        结尾的X方向上相对自身的缩放比例，浮点值；
- android:fromYScale    起始的Y方向上相对自身的缩放比例，浮点值，
- android:toYScale        结尾的Y方向上相对自身的缩放比例，浮点值；
- android:pivotX            缩放起点X轴坐标，可以是数值、百分数、百分数p 三种样式，比如 50、50%、50%p，当为数值时，表示在当前View的左上角，即原点处加上50px，做为起始缩放点；如果是50%，表示在当前控件的左上角加上自己宽度的50%做为起始点；如果是50%p，那么就是表示在当前的左上角加上父控件宽度的50%做为起始点x轴坐标。（具体意义，后面会举例演示）
- android:pivotY           缩放起点Y轴坐标，取值及意义跟android:pivotX一样


例子:

```xml
scale.xml

<?xml version="1.0" encoding="utf-8"?>  
<scale xmlns:android="http://schemas.android.com/apk/res/android"  
    android:fromXScale="0.0"  
    android:toXScale="1.4"  
    android:fromYScale="0.0"  
    android:toYScale="1.4"  
    android:pivotX="50"  
    android:pivotY="50"  
    android:duration="700" />  
```

等价的java代码:

```java
scaleAnim = new ScaleAnimation(0.0f,1.4f,0.0f,1.4f,Animation.RELATIVE_TO_SELF,0.5f,Animation.RELATIVE_TO_SELF,0.5f);  
scaleAnim.setDuration(700);  
tv.startAnimation(scaleAnim);
```


## AlphaAnimation

- android:fromAlpha   动画开始的透明度，从0.0 --1.0 ，0.0表示全透明，1.0表示完全不透明
- android:toAlpha       动画结束时的透明度，也是从0.0 --1.0 ，0.0表示全透明，1.0表示完全不透明

例子:

```xml
alpha.mxl

<?xml version="1.0" encoding="utf-8"?>  
<alpha xmlns:android="http://schemas.android.com/apk/res/android"  
    android:fromAlpha="1.0"  
    android:toAlpha="0.1"  
    android:duration="3000"  
    android:fillBefore="true">  
</alpha>  
```

等价的java代码:

```java
alphaAnim = new AlphaAnimation(1.0f,0.1f);  
alphaAnim.setDuration(3000);  
alphaAnim.setFillBefore(true);
```

## RotateAnimation

xml:

- android:fromDegrees     开始旋转的角度位置，正值代表顺时针方向度数，负值代码逆时针方向度数
- android:toDegrees         结束时旋转到的角度位置，正值代表顺时针方向度数，负值代码逆时针方向度数
- android:pivotX               缩放起点X轴坐标，可以是数值、百分数、百分数p 三种样式，比如 50、50%、50%p，具体意义已在scale标签中讲述，这里就不再重讲
- android:pivotY               缩放起点Y轴坐标，可以是数值、百分数、百分数p 三种样式，比如 50、50%、50%p

java构造方法:

- RotateAnimation(Context context, AttributeSet attrs)　　从本地XML文档加载动画，同样，基本不用
- RotateAnimation(float fromDegrees, float toDegrees)
- RotateAnimation(float fromDegrees, float toDegrees, float pivotX, float pivotY)
- RotateAnimation(float fromDegrees, float toDegrees, int pivotXType, float pivotXValue, int pivotYType, float pivotYValue)

示例:

```xml
<?xml version="1.0" encoding="utf-8"?>  
<rotate xmlns:android="http://schemas.android.com/apk/res/android"  
    android:fromDegrees="0"  
    android:toDegrees="-650"  
    android:pivotX="50%"  
    android:pivotY="50%"  
    android:duration="3000"  
    android:fillAfter="true">  

</rotate>  
```

等价的java代码:

```java
rotateAnim = new RotateAnimation(0, -650, Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF, 0.5f);  
rotateAnim.setDuration(3000);  
rotateAnim.setFillAfter(true);
```

## TranslateAnimation

- android:fromXDelta     起始点X轴坐标，可以是数值、百分数、百分数p 三种样式，比如 50、50%、50%p，具体意义已在scale标签中讲述，这里就不再重讲
- android:fromYDelta    起始点Y轴从标，可以是数值、百分数、百分数p 三种样式；
- android:toXDelta         结束点X轴坐标
- android:toYDelta        结束点Y轴坐标

对应的构造方法:

- TranslateAnimation(Context context, AttributeSet attrs)  同样，基本不用
- TranslateAnimation(float fromXDelta, float toXDelta, float fromYDelta, float toYDelta)
- TranslateAnimation(int fromXType, float fromXValue, int toXType, float toXValue, int fromYType, float fromYValue, int toYType, float toYValue)

```xml
<?xml version="1.0" encoding="utf-8"?>  
<translate xmlns:android="http://schemas.android.com/apk/res/android"  
    android:fromXDelta="0"   
    android:toXDelta="-80"  
    android:fromYDelta="0"  
    android:toYDelta="-80"  
    android:duration="2000"  
    android:fillBefore="true">  
</translate>
```


对应的java代码:

```java
translateAnim = new TranslateAnimation(Animation.ABSOLUTE, 0, Animation.ABSOLUTE, -80,   
        Animation.ABSOLUTE, 0, Animation.ABSOLUTE, -80);  
translateAnim.setDuration(2000);  
translateAnim.setFillBefore(true);  
```

## AnimationSet

- AnimationSet(Context context, AttributeSet attrs)  同样，基本不用
- AnimationSet(boolean shareInterpolator)  shareInterpolator取值true或false，取true时，指在AnimationSet中定义一个插值器（interpolater），它下面的所有动画共同。如果设为false，则表示它下面的动画自己定义各自的插值器。

- public void addAnimation (Animation a)

示例:

```xml
<?xml version="1.0" encoding="utf-8"?>  
<set xmlns:android="http://schemas.android.com/apk/res/android"  
    android:duration="3000"  
    android:fillAfter="true">  

  <alpha   
    android:fromAlpha="0.0"  
    android:toAlpha="1.0"/>  

  <scale  
    android:fromXScale="0.0"  
    android:toXScale="1.4"  
    android:fromYScale="0.0"  
    android:toYScale="1.4"  
    android:pivotX="50%"  
    android:pivotY="50%"/>  

  <rotate  
    android:fromDegrees="0"  
    android:toDegrees="720"  
    android:pivotX="50%"  
    android:pivotY="50%"/>   
</set>  
```

等价的java代码:

```java
alphaAnim = new AlphaAnimation(1.0f,0.1f);  
scaleAnim = new ScaleAnimation(0.0f,1.4f,0.0f,1.4f,Animation.RELATIVE_TO_SELF,0.5f,Animation.RELATIVE_TO_SELF,0.5f);  
rotateAnim = new RotateAnimation(0, 720, Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF, 0.5f);  

setAnim=new AnimationSet(true);  
setAnim.addAnimation(alphaAnim);  
setAnim.addAnimation(scaleAnim);  
setAnim.addAnimation(rotateAnim);  

setAnim.setDuration(3000);  
setAnim.setFillAfter(true);  
```


## Interpolater插值器

- AccelerateDecelerateInterpolator	@android:anim/accelerate_decelerate_interpolator
- AccelerateInterpolator	@android:anim/accelerate_interpolator
- AnticipateInterpolator	@android:anim/anticipate_interpolator
- AnticipateOvershootInterpolator	@android:anim/anticipate_overshoot_interpolator
- BounceInterpolator	@android:anim/bounce_interpolator
- CycleInterpolator	@android:anim/cycle_interpolator
- DecelerateInterpolator	@android:anim/decelerate_interpolator
- LinearInterpolator	@android:anim/linear_interpolator
- OvershootInterpolator	@android:anim/overshoot_interpolator

使用方法：（为sacleAnimation增加bounce插值器）

```java
ScaleAnimation interpolateScaleAnim=new ScaleAnimation(0.0f,1.4f,0.0f,1.4f,Animation.RELATIVE_TO_SELF,0.5f,Animation.RELATIVE_TO_SELF,0.5f);  
interpolateScaleAnim.setInterpolator(new BounceInterpolator());  
interpolateScaleAnim.setDuration(3000);  
```
