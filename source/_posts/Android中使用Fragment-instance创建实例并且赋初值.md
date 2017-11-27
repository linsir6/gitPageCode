---
title: Android中使用Fragment.instance创建实例并且赋初值
date: 2017-11-27 16:56:09
tags: Fragment
categories: Android
---

# Android中使用Fragment.instance创建实例并且赋初值



当我们实现一个Fragment之后，想为其赋初值的时候，我们可能最下意识的想到的是，增加一个带参数的构造方法，然后为其赋值，但是这样的方式是完全不能被接受的，因为官方文档中明确的写着，Fragment不能拥有带参数的构造方法，因为Fragment的生命周期的原因，当Fragment被销毁之后，如果需要重新创建的时候，系统调用的将是Fragment的无参数的构造方法。

这个时候我们便可以通过setArguments()的方式来为其赋初值，这个时候我们便可以应用工厂模式，来构造它的对象。


```java
public static Fragment newInstance(int orderType) {
        Fragment fragment = new BossOrderFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("mOrderType", orderType);
        fragment.setArguments(bundle);
        return fragment;
    }
```

调用时的方法(直接可以获取到实例，并且可以为其赋初值):

```java
fragment = BossOrderFragment.newInstance(0);
```
