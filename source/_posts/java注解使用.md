---
title: java注解的编写与使用
date: 2018-01-18 15:30:50
tags: 注解
categories: java
---

# java注解使用

> 在日常的开发过程中，我确实也很少自定义注解，它的实现主要基于反射，一般框架中会为我们提供一些注解。


## 自定义注解:

```java
public class MetaAnnotation {


    @JyzTargetField
    private String info;

    @JyzTargetConstructor
    public MetaAnnotation(@JyzTargetParamter String info) {
        this.info = info;
    }

    @JyzTargetMethod
    public void test() {
        @JyzTargetLocalVariable
        String infoInner = "sa";
    }

    //接口、类、枚举、注解
    @Target(ElementType.TYPE)
    @interface JyzTargetType {
    }

    //字段、枚举的常量
    @Target(ElementType.FIELD)
    @interface JyzTargetField {
    }

    //方法
    @Target(ElementType.METHOD)
    @interface JyzTargetMethod {
    }

    //方法参数
    @Target(ElementType.PARAMETER)
    @interface JyzTargetParamter {
    }

    //构造函数
    @Target(ElementType.CONSTRUCTOR)
    @interface JyzTargetConstructor {
    }

    //局部变量
    @Target(ElementType.LOCAL_VARIABLE)
    @interface JyzTargetLocalVariable {
    }

    //注解
    @Target(ElementType.ANNOTATION_TYPE)
    @interface JyzTargetAnnotationType {
    }

    //包
    @Target(ElementType.PACKAGE)
    @Retention(RetentionPolicy.RUNTIME)
    @interface JyzTargetPackage {
        public String version() default "";
    }

    @JyzTargetAnnotationType
    @interface JyzTargetAll {
    }

    @Retention(RetentionPolicy.SOURCE)
    @interface JyzRetentionSource {
    }

    @Retention(RetentionPolicy.CLASS)
    @interface JyzRetentionClass {
    }

    @Retention(RetentionPolicy.RUNTIME)
    @interface JyzRetentionRuntime {
    }

    @Documented
    @interface JyzDocument {
    }

    @Inherited
    @interface JyzInherited {
    }

}

```

我们这里面自定义了很多的注解，例如: ``JyzTargetField``，``JyzTargetConstructor``，``JyzTargetMethod这些``，定义注解的时候和定义接口类似，只是在interface前面多了一个@符号。

定义的注解不能够有方法，只能够有一些属性。


我们定义注解的时候，还可以用一些原有的注解进行修饰，可以指明我们的新定义的注解的使用场景，还有就是原生的四种注解是不能够直接使用的～

以上都只是注解的定义，并没有说我们怎么来解析这些注解，下面我们来重点讲一下，怎么来解析这些注解:


## 自定义注解的解析

```java
@Documented
@Target(ElementType.METHOD)
@Inherited
@Retention(RetentionPolicy.RUNTIME)
public @interface MethodInfo {
    String author() default "Pankaj";

    String date();

    int revision() default 1;

    String comments();

}
```

自定义注解的使用与解析:

```java
public class Main {

    @Override
    @MethodInfo(author = "Pankaj", comments = "Main method", date = "Nov 17 2012", revision = 1)
    public String toString() {
        return super.toString();
    }

    @Deprecated
    @MethodInfo(comments = "deprecated method", date = "Nov 17 2012")
    public static void oldMethod() {
        System.out.println("old method, don't use it.");
    }

    @SuppressWarnings({ "unchecked", "deprecation" })
    @MethodInfo(author = "Pankaj", comments = "Main method", date = "Nov 17 2012", revision = 10)
    public static void genericsTest() throws FileNotFoundException {
        List l = new ArrayList();
        l.add("abc");
        oldMethod();
    }


    public static void main(String[] args){
        System.out.println("===================");
        try{
            for (Method method : Main.class.getClassLoader().loadClass("comment.Main").getMethods()) {
                if(method.isAnnotationPresent(MethodInfo.class)){
                    try{
                        for (Annotation annotation : method.getAnnotations()) {
                            System.out.println("Annotation in Method '"
                                    + method + "' : " + annotation);
                        }
                        MethodInfo methodAnno  = method.getAnnotation(MethodInfo.class);
                        if(methodAnno.revision() == 1){
                            System.out.println("Method with revision no 1 = " + method);
                        }
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
```


```
控制台输出:
===================
Annotation in Method 'public java.lang.String comment.Main.toString()' : @comment.MethodInfo(author=Pankaj, revision=1, comments=Main method, date=Nov 17 2012)
Method with revision no 1 = public java.lang.String comment.Main.toString()
Annotation in Method 'public static void comment.Main.oldMethod()' : @java.lang.Deprecated()
Annotation in Method 'public static void comment.Main.oldMethod()' : @comment.MethodInfo(author=Pankaj, revision=1, comments=deprecated method, date=Nov 17 2012)
Method with revision no 1 = public static void comment.Main.oldMethod()
Annotation in Method 'public static void comment.Main.genericsTest() throws java.io.FileNotFoundException' : @comment.MethodInfo(author=Pankaj, revision=10, comments=Main method, date=Nov 17 2012)
```

以上的代码我们就是定义了几个方法，用上了我们自己定义的注解，然后在``Main``方法中。利用反射，将我们定义的注解解析出来。将里面的值打印出来，当然在实际的操作中，我们应该执行自己的逻辑，而不紧紧是把他们打印出来。


