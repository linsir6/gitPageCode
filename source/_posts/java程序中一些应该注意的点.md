---
title: java程序中一些应该注意的点
date: 2018-01-18 17:30:00
tags: 编程技巧
categories: Java
---

# java程序中一些应该注意的点

## 将数组转化为列表

```java
List<String> list = Arrays.asList(arr);//不推荐
```

大家可能经常这样的操作，但是Arrays.asList()的返回值并不是``java.util.ArrayList``这个类的子类，而是``java.util.Arrays.ArrayList``这个类的子类，它是没有``add``这些方法的。

```java
ArrayList<String> arrayList = new ArrayList<String>(Arrays.asList(arr));//推荐
```

## 判断一个数组中是否包含一个值

```java
Set<String> set = new HashSet<String>(Arrays.asList(arr));
return set.contains(targetValue);//不推荐
```

以上的方法确实可以实现功能，但是它会浪费一些时间，因为转成Set是需要时间的。

```java
Arrays.asList(arr).contains(targetValue);//推荐
```

## 在一个循环中删除列表中元素

### 错误的四种的方法

```java
public static void remove1(List<String> list, String target){
        int size = list.size();
        for(int i = 0; i < size; i++){
            String item = list.get(i);
            if(target.equals(item)){
                list.remove(item);
            }
        }
    }
    //删除之后list.size减小了，这样会越界
```

```java
public static void remove2(List<String> list, String target){
        for(int i = 0; i < list.size(); i++){
            String item = list.get(i);
            if(target.equals(item)){
                list.remove(item);
            }
        }
    }
    //list大小一直在改变可能导致删除的不全，有剩余
```



```java
public static void remove4(List<String> list, String target){
        for(String item : list){
            if(target.equals(item)){
                list.remove(item);
            }
        }
    }
    //系统会自动检查modCount != expectedModCount，不一致就会抛出异常
```

```java
 public static void remove5(List<String> list, String target){
        Iterator<String> iter = list.iterator();
        while (iter.hasNext()) {
            String item = iter.next();
            if (item.equals(target)) {
                list.remove(item);
            }
        }
    }
    //系统会自动检查modCount != expectedModCount，不一致就会抛出异常
```

### 正确的三种方法

```java
   public static void remove1(List<String> list, String target){
        for(int i = list.size() - 1; i >= 0; i--){
            String item = list.get(i);
            if(target.equals(item)){
                list.remove(item);
            }
        }
    }
```

```java
public static void remove2(ArrayList<String> list, String target) {
        final CopyOnWriteArrayList<String> cowList = new CopyOnWriteArrayList<String>(list);
        for (String item : cowList) {
            if (item.equals(target)) {
                cowList.remove(item);
            }
        }
    }

```

```java
public static void remove3(List<String> list, String target){
        Iterator<String> iter = list.iterator();
        while (iter.hasNext()) {
            String item = iter.next();
            if (item.equals(target)) {
                iter.remove();
            }
        }
   }
```
