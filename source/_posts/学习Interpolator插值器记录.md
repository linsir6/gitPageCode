---
title: 学习Interpolator插值器记录
date: 2017-11-28 15:26:22
tags: Android动画
categories: Android
---

# 学习Interpolator插值器记录

> 最近打算把Android的基本功-自定义控件再详细的撸一遍，在网上看到了一个自定义控件的系列文章，写的比较好，打算把它刷一遍，教程地址:http://blog.csdn.net/harvic880925/article/details/50995268


## 概念

Interpolator属性是Animation类的一个XML属性，所以alpha,scale,rotate,translate,set都会继承这个属性。

它有以下几个属性:

- AccelerateDecelerateInterpolator   在动画开始与介绍的地方速率改变比较慢，在中间的时候加速
- AccelerateInterpolator                     在动画开始的地方速率改变比较慢，然后开始加速
- AnticipateInterpolator                      开始的时候向后然后向前甩
- AnticipateOvershootInterpolator     开始的时候向后然后向前甩一定值后返回最后的值
- BounceInterpolator                          动画结束的时候弹起
- CycleInterpolator                             动画循环播放特定的次数，速率改变沿着正弦曲线
- DecelerateInterpolator                    在动画开始的地方快然后慢
- LinearInterpolator                            以常量速率改变
- OvershootInterpolator                      向前甩一定值后再回到原来位置


## 具体用法

可以在``android:interpolator``下面添加:

```xml
<?xml version="1.0" encoding="utf-8"?>  
<scale xmlns:android="http://schemas.android.com/apk/res/android"  
    android:interpolator="@android:anim/accelerate_decelerate_interpolator"  
    android:fromXScale="0.0"  
    android:toXScale="1.4"  
    android:fromYScale="0.0"  
    android:toYScale="1.4"  
    android:pivotX="50%"  
    android:pivotY="50%"  
    android:duration="700"   
    android:fillAfter="true"  
/>  
```

就类似以上这样，在这几个动画的标签下面都可以添加，这些都可以添加进来。



我这面也都尝试了一下，确实挺好理解的，如果大家想看效果图，可以看那个教程的地址～ 最近在跟着启舰大神的教程学习，感觉状态非常好。
