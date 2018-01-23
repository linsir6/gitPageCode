---
title: java内置排序总结
date: 2018-01-18 17:30:00
tags: Java内置排序
categories: Java
---

# java内置排序总结

> 平时在工作的过程中也经常用到java中的一些排序的算法，但是很少系统的总结一下，今天简单的总结一下。


其实需要涉及到排序的数据结构大概有两种:

- Array
- List


这两种结构比较类似，从日常开发的角度来讲，如果我们能够确定数组的长度,还是建议用int[] aArray = {1,2,3};这种模式吧，因为它的速度比较快，不需要动态扩容，所以系统的开销也比较小。

以上两种类型，系统都提供了排序的方法，分别是:

- Arrays.sort()
- Collections.sort()

```java
        List<String> list = new ArrayList<>();
        list.add("a");
        list.add("c");
        list.add("e");
        list.add("b");
        list.add("q");
        Collections.sort(list);
        for (int i = 0; i < list.size(); i++) {
            System.out.print(list.get(i) + "\t");
        }

        //============================================

        List<Integer> list2 = new ArrayList<>();
        list2.add(6);
        list2.add(3);
        list2.add(1);
        list2.add(7);
        list2.add(2);
        Collections.sort(list2);
        System.out.println();
        for (int i = 0; i < list.size(); i++) {
            System.out.print(list2.get(i) + "\t");
        }

        //============================================

        Collections.sort(list2, new Comparator<Integer>() {
            @Override
            public int compare(Integer o1, Integer o2) {
                return o2 - o1;
            }
        });
        System.out.println();
        for (int i = 0; i < list.size(); i++) {
            System.out.print(list2.get(i) + "\t");
        }

        System.out.println();

        //============================================

        int[] aArray = {1, 5, 2, 4, 9};

        Arrays.sort(aArray);

        for (int i = 0; i < aArray.length; i++) {
            System.out.print(aArray[i] + "\t");
        }

        System.out.println();

        //============================================

        Character[] bArray = {'a', 'd', 'c', 'z', 'b'};
        Arrays.sort(bArray, new Comparator<Character>() {
            @Override
            public int compare(Character o1, Character o2) {
                return o1 - o2;
            }
        });

        for (int i = 0; i < bArray.length; i++) {
            System.out.print(bArray[i] + "\t");
        }
```


```
//控制台输出
a	b	c	e	q
1	2	3	6	7
7	6	3	2	1
1	2	4	5	9
a	b	c	d	z
```

以上的代码，就展示了两种方式，一种是直接用默认的方法进行排序，一种是自己重写排序规则。
