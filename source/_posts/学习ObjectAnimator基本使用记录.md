---
title: 学习ObjectAnimator基本使用记录
date: 2017-11-30 16:04:37
tags: Android动画
categories: Android
---



# 学习ObjectAnimator基本使用记录

注:本文并非原创，本文为学习[启舰大神博客](http://blog.csdn.net/harvic880925/article/details/50995268)的笔记~

之前的笔记中已经介绍了ValueAnimator，其实他已经很方便了，但是它还是有一些缺点的，因为它只能对数值进行计算。想对控件进行操作的时候，需要监听动画过程，在监听中对控件操作，这样使用补间动画还是比较麻烦的。

为了能让动画直接与对应控件相关联，以使我们从监听动画过程中解放出来，谷歌的开发人员在ValueAnimator的基础上，又派生了一个类ObjectAnimator。

由于是派生出来的嘛，所以ValueAnimator中能用的方法ObjectAnimator中都是能用的。

例子 (ObjectAnimator中onFloat方法的使用--改变透明度):

```java
public class MyPointView extends View {

    private Point mCurPoint;

    public MyPointView(Context context, AttributeSet attrs) {
        super(context, attrs);
        mCurPoint = new Point(300);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        if (mCurPoint != null) {
            Paint paint = new Paint();
            paint.setAntiAlias(true);
            paint.setColor(Color.RED);
            paint.setStyle(Paint.Style.FILL);
            canvas.drawCircle(300, 300, mCurPoint.getRadius(), paint);
        }
    }

    public void doPointAnim() {
        ObjectAnimator animator = ObjectAnimator.ofFloat(this, "alpha", 1, 0, 1);
        animator.setDuration(2000);
        animator.start();
    }
}
```

效果图:

![](https://ws3.sinaimg.cn/large/006tKfTcly1fm0862eb5eg309m0hin45.gif)


## setter函数

我们再回来看构造改变rotation值的ObjectAnimator的方法:

```java
ObjectAnimator animator = ObjectAnimator.ofFloat(tv,"rotation",0,180,0);
```

TextView控件有rotation这个属性吗？没有，不光TextView没有，连它的父类View中也没有这个属性。那它是怎么来改变这个值的呢？其实，ObjectAnimator做动画，并不是根据控件xml中的属性来改变的，而是通过指定属性所对应的set方法来改变的。比如，我们上面指定的改变rotation的属性值，ObjectAnimator在做动画时就会到指定控件（TextView）中去找对应的setRotation()方法来改变控件中对应的值。同样的道理，当我们在最开始的示例代码中，指定改变”alpha”属性值的时候，ObjectAnimator也会到TextView中去找对应的setAlpha()方法。那TextView中都有这些方法吗，有的，这些方法都是从View中继承过来的，在View中有关动画，总共有下面几组set方法：

```java
//1、透明度：alpha  
public void setAlpha(float alpha)  

//2、旋转度数：rotation、rotationX、rotationY  
public void setRotation(float rotation)  
public void setRotationX(float rotationX)  
public void setRotationY(float rotationY)  

//3、平移：translationX、translationY  
public void setTranslationX(float translationX)   
public void setTranslationY(float translationY)  

//缩放：scaleX、scaleY  
public void setScaleX(float scaleX)  
public void setScaleY(float scaleY)  
```

可以看到在View中已经实现了有关alpha,rotaion,translate,scale相关的set方法。所以我们在构造ObjectAnimator时可以直接使用。


在开始逐个看这些函数的使用方法前，我们先做一个总结：
1、要使用ObjectAnimator来构造对画，要操作的控件中，必须存在对应的属性的set方法
2、setter 方法的命名必须以骆驼拼写法命名，即set后每个单词首字母大写，其余字母小写，即类似于setPropertyName所对应的属性为propertyName
下面我们就来看一下上面中各个方法的使用方法及作用。
有关alpha的用法，上面已经讲过了，下面我们来看看其它的


### setRotationX、setRotationY与setRotation

- setRotationX(float rotationX)：表示围绕X轴旋转，rotationX表示旋转度数
- setRotationY(rotationY):表示围绕Y轴旋转，rotationY表示旋转度数
- setRotation(float rotation):表示围绕Z旋转,rotation表示旋转度数

```java
ObjectAnimator animator = ObjectAnimator.ofFloat(tv,"rotationX",0,270,0);  
animator.setDuration(2000);  
animator.start();  
```

效果图如下:

![](https://ws4.sinaimg.cn/large/006tNc79ly1fm0d2mr9tgg309m0hidln.gif)

### setTranslationX与setTranslationY

- setTranslationX(float translationX) :表示在X轴上的平移距离,以当前控件为原点，向右为正方向，参数translationX表示移动的距离。
- setTranslationY(float translationY) :表示在Y轴上的平移距离，以当前控件为原点，向下为正方向，参数translationY表示移动的距离。

```java
ObjectAnimator animator = ObjectAnimator.ofFloat(tv, "translationX", 0, 200, -200,0);  
animator.setDuration(2000);  
animator.start();  
```

```java
ObjectAnimator animator = ObjectAnimator.ofFloat(tv, "translationY", 0, 200, -100,0);  
animator.setDuration(2000);  
animator.start();  
```

效果图就不截了，大家可以自己想象一下，然后再实践一下。

### setScaleX与setScaleY

- setScaleX(float scaleX):在X轴上缩放，scaleX表示缩放倍数
- setScaleY(float scaleY):在Y轴上缩放，scaleY表示缩放倍数

```java
ObjectAnimator animator = ObjectAnimator.ofFloat(tv, "scaleX", 0, 3, 1);  
animator.setDuration(2000);  
animator.start();  
```

```java
ObjectAnimator animator = ObjectAnimator.ofFloat(tv, "scaleY", 0, 3, 1);  
animator.setDuration(2000);  
animator.start();  
```

## ObjectAnimator和ValueAnimator动画流程对比


- ValueAnimator动画流程

```
(1)             (2)            (3)             (4)
ofInt(0,400) -> 加速器    ->   Evaluator   ->  监听器返回       
(定义动画数字区间)(返回当前进度如0.2)(根据当前进度计算当前值)(在AnimatorUpdateListener中返回)
```

- ObjectAnimator动画流程

```
ofInt(tv,"scaleY",0,3,1) -> 加速器 -> Evalutor -> 调用set函数
(定义动画对象及区间)(返回当前数字进度如0.2)(根据数字进度计算当前值)(根据属性拼装set函数并反射调用，将当前值作为参数传入)
```

他们两个的基本流程是一样的，唯一不同的点就是最后一步，ObjectAnimator是通过反射实现的，以下为这几个点的注意事项:

1. 拼接set函数的方法:强制属性的首字母大写，然后与set进行拼接。也就是说可以写成``scalePointX``或者``ScalePointX``
2. 如何确定参数类型:上面我们知道了如何找到对应的函数名，那对应的参数方法的参数类型如何确定呢？我们在讲ValueAnimator的时候说过，动画过程中产生的数字值与构造时传入的值类型是一样的。由于ObjectAnimator与ValueAnimator在插值器和Evaluator这两步是完全一样的，而当前动画数值的产生是在Evaluator这一步产生的，所以ObjectAnimator的动画中产生的数值类型也是与构造时的类型一样的。那么问题来了，像我们的构造方法。

```java
ObjectAnimator animator = ObjectAnimator.ofFloat(tv, "scaleY", 0, 3, 1);  
```

由于构造时使用的是ofFloat函数，所以中间值的类型应该是Float类型的，所以在最后一步拼装出来的set函数应该是setScaleY(float xxx)的样式；这时，系统就会利用反射来找到setScaleY(float xxx)函数，并把当前的动画数值做为参数传进去。
那问题来了，如果没有类似setScaleY(float xxx)的函数，我们只实现了一个setScaleY(int xxx)的函数怎么办？这里虽然函数名一样，但参数类型是不一样的，那么系统就会报一个错误,告诉我们对应函数的指定参数类型没有找到

3. 调用set函数以后怎么办?
从ObjectAnimator的流程可以看到，ObjectAnimator只负责把动画过程中的数值传到对应属性的set函数中就结束了，注意传给set函数以后就结束了！set函数就相当我们在ValueAnimator中添加的监听的作用，set函数中的对控件的操作还是需要我们自己来写的。
那我们来看看View中的setScaleY是怎么实现的吧：

```java
/**
 * Sets the amount that the view is scaled in Y around the pivot point, as a proportion of
 * the view's unscaled width. A value of 1 means that no scaling is applied.
 *
 * @param scaleY The scaling factor.
 * @see #getPivotX()
 * @see #getPivotY()
 *
 * @attr ref android.R.styleable#View_scaleY
 */  
public void setScaleY(float scaleY) {  
    ensureTransformationInfo();  
    final TransformationInfo info = mTransformationInfo;  
    if (info.mScaleY != scaleY) {  
        invalidateParentCaches();  
        // Double-invalidation is necessary to capture view's old and new areas  
        invalidate(false);  
        info.mScaleY = scaleY;  
        info.mMatrixDirty = true;  
        mPrivateFlags |= DRAWN; // force another invalidation with the new orientation  
        invalidate(false);  
    }  
}  
```

大神的博客中写到这里暂时不同看得太懂，因为这里涉及到了View绘制的流程，我也确实看不太懂，等有空的时候也需要补一下View绘制的源码。

大家不必理解这一坨代码的意义，因为这些代码是需要读懂View的整体流程以后才能看得懂的，只需要跟着我的步骤来理解就行。这段代码总共分为两部分：第一步重新设置当前控件的参数，第二步调用Invalidate()强制重绘；
所以在重绘时，控件就会根据最新的控件参数来绘制了，所以我们就看到当前控件被缩放了。

4. 因为动画的刷新频率是每十几毫秒刷新一次，所以我们set这个方法也是每十几毫秒被调用一次。

# 自定义ObjectAnimator属性

效果图:

![](https://ws3.sinaimg.cn/large/006tNc79ly1fm113ivqbqg309i0hcdoi.gif)


示例代码:



```java
public class Point {

    private int radius;

    public Point(int radius) {
        this.radius = radius;
    }

    public int getRadius() {
        return radius;
    }

    public void setRadius(int radius) {
        this.radius = radius;
    }
}
```

```java
private Point mPoint = new Point(100);

    public MyPointView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        if (mPoint != null) {
            Paint paint = new Paint();
            paint.setAntiAlias(true);
            paint.setColor(Color.RED);
            paint.setStyle(Paint.Style.FILL);
            canvas.drawCircle(300, 300, mPoint.getRadius(), paint);
        }
    }

    void setPointRadius(int radius) {
        mPoint.setRadius(radius);
        invalidate();
    }
```

```java
public class MainActivity extends AppCompatActivity {

    private MyPointView myPointView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        myPointView = (MyPointView) findViewById(R.id.my_point_view);

        myPointView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                doPointViewAnimation();
            }
        });
    }

    private void doPointViewAnimation() {
        ObjectAnimator animator = ObjectAnimator.ofInt(myPointView, "pointRadius", 0, 300, 100);
        animator.setDuration(2000);
        animator.start();
    }

}
```

这里面重点的函数，就是``doPointViewAnimation``这个函数，这个函数里面，会指定要做动画的view，以及要拼接的set的方法名，还有就是动画的值了。

## 何时需要实现对应属性的get函数

```java
public static ObjectAnimator ofFloat(Object target, String propertyName, float... values)  
public static ObjectAnimator ofInt(Object target, String propertyName, int... values)  
public static ObjectAnimator ofObject(Object target, String propertyName,TypeEvaluator evaluator, Object... values)  
```

前面我们已经分别讲过三个函数的使用方法，在上面的三个构造方法中最后一个参数都是可变长参数。我们也讲了，他们的意义就是从哪个值变到哪个值的。
那么问题来了：前面我们都是定义多个值，即至少两个值之间的变化，那如果我们只定义一个值呢，如下面的方式：(同样以MyPointView为例)


```java
ObjectAnimator animator = ObjectAnimator.ofInt(mPointView, "pointRadius",100);  
animator.setDuration(2000);  
animator.start();  
```

![](https://ws4.sinaimg.cn/large/006tNc79ly1fm145xgq5qg309i0hcwiw.gif)

这样调用这个方法，是会产生警告的:

![](https://ws4.sinaimg.cn/large/006tNc79ly1fm1481c6s0j31kw02dmy4.jpg)

当且仅当我们只给动画设置一个值时，程序才会调用属性对应的get函数来得到动画初始值。如果动画没有初始值，那么就会使用系统默认值。比如ofInt（）中使用的参数类型是int类型的，而系统的Int值的默认值是0，所以动画就会从0运动到100；也就是系统虽然在找到不到属性对应的get函数时，会给出警告，但同时会用系统默认值做为动画初始值。

```java
public int getPointRadius(){  
      return 50;  
}  
```

当我们在这个控件里面实现``getPointRadius``这个方法之后，它就不会从0开始了，而是从50开始。


## 常用函数

ArgbEvalutor的用法:

```java
ObjectAnimator animator = ObjectAnimator.ofInt(tv, "BackgroundColor", 0xffff00ff, 0xffffff00, 0xffff00ff);  
animator.setDuration(8000);  
animator.setEvaluator(new ArgbEvaluator());  
animator.start();  
```

## 其它函数

### 常用函数

```java
/**
 * 设置动画时长，单位是毫秒
 */  
ValueAnimator setDuration(long duration)  
/**
 * 获取ValueAnimator在运动时，当前运动点的值
 */  
Object getAnimatedValue();  
/**
 * 开始动画
 */  
void start()  
/**
 * 设置循环次数,设置为INFINITE表示无限循环
 */  
void setRepeatCount(int value)  
/**
 * 设置循环模式
 * value取值有RESTART，REVERSE，
 */  
void setRepeatMode(int value)  
/**
 * 取消动画
 */  
void cancel()  
```


### 监听器相关

```java
/**
 * 监听器一：监听动画变化时的实时值
 */  
public static interface AnimatorUpdateListener {  
    void onAnimationUpdate(ValueAnimator animation);  
}  
//添加方法为：public void addUpdateListener(AnimatorUpdateListener listener)  
/**
 * 监听器二：监听动画变化时四个状态
 */  
public static interface AnimatorListener {  
    void onAnimationStart(Animator animation);  
    void onAnimationEnd(Animator animation);  
    void onAnimationCancel(Animator animation);  
    void onAnimationRepeat(Animator animation);  
}  
//添加方法为：public void addListener(AnimatorListener listener)
```

### 插值器与Evaluator

```java
/**
 * 设置插值器
 */  
public void setInterpolator(TimeInterpolator value)  
/**
 * 设置Evaluator
 */  
public void setEvaluator(TypeEvaluator value)  
```
