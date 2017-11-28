---
title: Android利用translate、sacle、alpha、rotate实现动画效果
date: 2017-11-27 19:24:04
tags: Android动画
categories: Android
---

# Android利用translate、scale、alpha、rotate实现动画效果

在Android中可以用animation实现动画效果，Android中的animation由四种类型组成:

- alpha 透明度的变换
- scale 渐变尺寸伸缩动画
- translate view切换位置移动的效果
- rotate 旋转效果

这些xml我们需要定义在``res/anim``文件夹下面，如下图所示：

![](https://ws3.sinaimg.cn/large/006tKfTcly1flwvm1ttk1j30q20i63z7.jpg)



## scale标签

- android:fromXScale="float"
  Float. Starting X size offset, where 1.0 is no change.
- android:toXScale="float"
  Float. Ending X size offset, where 1.0 is no change.
- android:fromYScale="float"
  Float. Starting Y size offset, where 1.0 is no change.
- android:toYScale="float"
  Float. Ending Y size offset, where 1.0 is no change.
- android:pivotX="float"
  Float. The X coordinate to remain fixed when the object is scaled.
- android:pivotY="float"
  Float. The Y coordinate to remain fixed when the object is scaled.

## alpha

- android:fromAlpha="float"
  Float. Starting opacity offset, where 0.0 is transparent and 1.0 is opaque.
- android:toAlpha="float"
  Float. Ending opacity offset, where 0.0 is transparent and 1.0 is opaque.


## translate

- android:fromXDelta="float"
  Float or percentage. Starting X offset. Expressed either: in pixels relative to the normal position (such as "5"), in percentage relative to the element width (such as "5%"), or in percentage relative to the parent width (such as "5%p").
- android:toXDelta="float"
  Float or percentage. Ending X offset. Expressed either: in pixels relative to the normal position (such as "5"), in percentage relative to the element width (such as "5%"), or in percentage relative to the parent width (such as "5%p").
- android:fromYDelta="float"
  Float or percentage. Starting Y offset. Expressed either: in pixels relative to the normal position (such as "5"), in percentage relative to the element height (such as "5%"), or in percentage relative to the parent height (such as "5%p").
- android:toYDelta="float"
  Float or percentage. Ending Y offset. Expressed either: in pixels relative to the normal position (such as "5"), in percentage relative to the element height (such as "5%"), or in percentage relative to the parent height (such as "5%p").


## rotate

- android:fromDegrees="float"
  Float. Starting angular position, in degrees
- android:toDegrees="float"
  Float. Ending angular position, in degrees.
- android:pivotX="float
  Float or percentage. The X coordinate of the center of rotation. Expressed either: in pixels relative to the object's left edge (such as "5"), in percentage relative to the object's left edge (such as "5%"), or in percentage relative to the parent container's left edge (such as "5%p").
- android:pivotY="float"
  Float or percentage. The Y coordinate of the center of rotation. Expressed either: in pixels relative to the object's top edge (such as "5"), in percentage relative to the object's top edge (such as "5%"), or in percentage relative to the parent container's top edge (such as "5%p").


## Animation类具有的xml属性

- android:detachWallpaper
Special option for window animations: if this window is on top of a wallpaper, don't animate the wallpaper with it.
- android:duration
Amount of time (in milliseconds) for the animation to run.
- android:fillAfter
When set to true, the animation transformation is applied after the animation is over.
- android:fillBefore
When set to true or when fillEnabled is not set to true, the animation transformation is applied before the animation has started.
android:fillEnabled	When set to true, the value of fillBefore is taken into account.
- android:interpolator
Defines the interpolator used to smooth the animation movement in time.
- android:repeatCount
Defines how many times the animation should repeat.
- android:repeatMode
Defines the animation behavior when it reaches the end and the repeat count is greater than 0 or infinite.
- android:startOffset
Delay in milliseconds before the animation runs, once start time is reached.
- android:zAdjustment
Allows for an adjustment of the Z ordering of the content being animated for the duration of the animation.


## 具体实例

具体实例:

```xml
alpha.xml

<?xml version="1.0" encoding="utf-8"?>
<alpha xmlns:android="http://schemas.android.com/apk/res/android"
    android:fromAlpha="1.0"
    android:toAlpha="0.1"
    android:duration="3000"
    android:fillBefore="true">
</alpha>
```

```xml
rotate.xml

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

```xml
scale.xml

<?xml version="1.0" encoding="utf-8"?>
<scale xmlns:android="http://schemas.android.com/apk/res/android"
    android:fromXScale="0.0"
    android:toXScale="1.4"
    android:fromYScale="0.0"
    android:toYScale="1.4"
    android:pivotX="50%"
    android:pivotY="50%"
    android:duration="700" />
```

```xml
translate.xml

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

```xml
set_anim.xml

<?xml version="1.0" encoding="utf-8"?>
<set xmlns:android="http://schemas.android.com/apk/res/android"
    android:duration="3000"
    android:fillAfter="true">

    <alpha
        android:fromAlpha="0.0"
        android:toAlpha="1.0" />

    <scale
        android:fromXScale="0.0"
        android:fromYScale="0.0"
        android:pivotX="50%"
        android:pivotY="50%"
        android:toXScale="1.4"
        android:toYScale="1.4" />

    <rotate
        android:fromDegrees="0"
        android:pivotX="50%"
        android:pivotY="50%"
        android:toDegrees="720" />

</set>
```

java代码:

```java
package com.qf58.learncustomview;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private TextView textView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        textView = (TextView) findViewById(R.id.text_view);
        final Animation scaleAnimation = AnimationUtils.loadAnimation(this, R.anim.scale);
        final Animation alphaAnimation = AnimationUtils.loadAnimation(this, R.anim.alpha);
        final Animation translate = AnimationUtils.loadAnimation(this, R.anim.translate);
        final Animation rotate = AnimationUtils.loadAnimation(this, R.anim.rotate);
        final Animation set = AnimationUtils.loadAnimation(this,R.anim.set_anim);

        findViewById(R.id.alpha).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                textView.startAnimation(alphaAnimation);
            }
        });

        findViewById(R.id.scale).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                textView.startAnimation(scaleAnimation);
            }
        });

        findViewById(R.id.translate).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                textView.startAnimation(translate);
            }
        });

        findViewById(R.id.rotate).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                textView.startAnimation(rotate);
            }
        });

        findViewById(R.id.set).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                textView.startAnimation(set);
            }
        });

    }
}
```









## 参考文献

- [Animation Resources官方文档](https://developer.android.com/guide/topics/resources/animation-resource.html)
- [自定义控件三部曲之动画篇（一）——alpha、scale、translate、rotate、set的xml属性及用法](http://blog.csdn.net/harvic880925/article/details/39996643)
