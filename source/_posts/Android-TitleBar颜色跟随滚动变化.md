---
title: Android-TitleBar颜色跟随滚动变化
date: 2018-01-24 16:44:12
tags: RecyclerView滑动检测
categories: Android
---

# Android-TitleBar颜色跟随滚动变化

效果: 目前很多主流app都实现了，当我们在首页在屏幕滑动的时候TitleBar的颜色随之变动。

其实实现的原理主要基于``relativeLayout.setBackgroundColor(Color.argb(alpha.toInt(), 255, 255, 255))``这样一个方法，有了这样一个方法，我们便可以监听recyclerView的滚动，然后动态设置它的背景颜色。

代码:

```java
recyclerView.addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrolled(recyclerView: RecyclerView?, dx: Int, dy: Int) {
                super.onScrolled(recyclerView, dx, dy)
                mDistanceY += dy
                //toolbar的高度
                val toolbarHeight = 56 * 3;

                //当滑动的距离 <= toolbar高度的时候，改变Toolbar背景色的透明度，达到渐变的效果
                if (mDistanceY <= toolbarHeight) {
                    val scale = mDistanceY.toFloat() / toolbarHeight
                    val alpha = scale * 255
                    relativeLayout.setBackgroundColor(Color.argb(alpha.toInt(), 255, 255, 255))
                } else {
                    //上述虽然判断了滑动距离与toolbar高度相等的情况，但是实际测试时发现，标题栏的背景色
                    //很少能达到完全不透明的情况，所以这里又判断了滑动距离大于toolbar高度的情况，
                    //将标题栏的颜色设置为完全不透明状态
                    relativeLayout.setBackgroundResource(R.color.colorWhite)
                }

            }
        })
```

整体实现起来非常简单，当然我们可以根据实际项目的需要进行优化～
