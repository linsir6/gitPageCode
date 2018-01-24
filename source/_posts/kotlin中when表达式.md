---
title: kotlin中when表达式
date: 2018-01-24 16:08:12
tags: kotlin
categories: kotlin
---

# kotlin中when表达式

在java中，我们更多习惯用的是``switch/case``的模式，但是``switch/case``支持的类型非常少，用起来也有一些局限性。

在kotlin中，引入了``when``表达式，它能完全取代``switch/case``，并且还有很多新的特性。

eg:

```java
when(view.visibility){
     View.VISIBLE -> toast("visible")
     View.INVISIBLE -> toast("invisible")
     else -> toast("gone")
}
```

这里面的else等同于``switch/case``中的``default``


## 自动转型(Auto-casting)

```java
when (view) {
     is TextView -> toast(view.text)
     is RecyclerView -> toast("Item count = ${view.adapter.itemCount}")
     is SearchView -> toast("Current query: ${view.query}")
     else -> toast("View type not supported")
}
```

## 无自变量的when

```java
val res = when {
     x in 1..10 -> "cheap"
     s.contains("hello") -> "it's a welcome!"
     v is ViewGroup -> "child count: ${v.getChildCount()}"
     else -> ""
}
```


# Android应用实例

```java
override fun onOptionsItemSelected(item: MenuItem) = when (item.itemId) {
     R.id.home -> consume { navigateToHome() }
     R.id.search -> consume { MenuItemCompat.expandActionView(item) }
     R.id.settings -> consume { navigateToSettings() }
     else -> super.onOptionsItemSelected(item)
}
```

```java
override fun convert(helper: BaseViewHolder?, item: HomeFragmentItemDelegate?) {
        when (helper!!.itemViewType) {
            1 -> helper.setText(R.id.text, "hello world 33")
            2 -> Log.i("lin", "---lin---> ")
            3 -> Log.i("lin", "---lin---> ")
            4 -> Log.i("lin", "---lin---> ")
        }
    }
```

总结 : 挺好用的，真的，挺好用的，也希望自己在入kotlin坑之后，越走越远，越走越好～


原文链接: https://antonioleiva.com/when-expression-kotlin/
