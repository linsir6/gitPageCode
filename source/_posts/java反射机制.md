---
title: java反射机制
date: 2018-01-18 12:05:50
tags: 反射
categories: Java
---

# java反射机制

> 最近听说这么一句话啊，“无反射，不框架”,感觉说的是真的很有道理的哈。
反射真的是很多框架的源泉，我们平时做业务开发的时候，可能很少用到反射机制，但是在框架中，反射机制还是很有价值的。


首先我们定义一个student实体类:

```java
public class Student {

    private int id;
    private String name;
    private String school;


    public Student() {
        this.id = id;
        this.name = name;
        this.school = school;
    }

    public Student(int id, String name, String school) {
        this.id = id;
        this.name = name;
        this.school = school;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }
}

```

反射中三种获取对象方式:

```java
        //第一种
        Student stu1 = new Student();
        Class stuClass = stu1.getClass();
        System.out.println(stuClass.getName());

        //第二种
        Class stuClass2 = Student.class;
        System.out.println(stuClass == stuClass2);


        //第三种方式获取Class对象
        try {
            Class stuClass3 = Class.forName("reflex.Student");//注意此字符串必须是真实路径，就是带包名的类路径，包名.类名
            System.out.println(stuClass3 == stuClass2);//判断三种方式是否获取的是同一个Class对象
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
```


```java
        //打印所有构造方法
        Constructor[] conArray = stuClass.getConstructors();
        for (Constructor c : conArray) {
            System.out.println(c);
        }

        Constructor con = stuClass.getConstructor(null);
        Object obj = con.newInstance();

        con = stuClass.getConstructor(int.class, String.class, String.class);
        System.out.println(con);
        con.setAccessible(true);
        obj = con.newInstance(1, "张三", "黑大");
        Student zz = (Student) obj;
        System.out.println(zz.getName());

        //获取方法
        //Method m = stuClass.getMethod("show",String.class);

        //获取私有方法
        //m = stuClass.getDeclaredMethod("show4", int.class);
        //m.setAccessible(true);//解除私有限定
        //Object result = m.invoke(obj, 20);
```


获取所有构造方法，还有就是动态的调用一些方法，或者动态调用私有方法～
