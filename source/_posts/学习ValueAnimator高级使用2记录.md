---
title: 学习ValueAnimator高级使用2记录
date: 2017-11-30 12:02:49
tags: Android动画
categories: Android
---

# 学习ValueAnimator高级使用2记录



## ofObject()概述

由于ofInt()和ofFloat()只能传入int,float两种类型,这个是肯定不能满足我们的需求的，所以我们又引入了ofObject()这个函数，这个函数就可以传入各种类型了:

```java
public static ValueAnimator ofObject(TypeEvaluator evaluator, Object... values);
```

他具有两个参数，第一个参数是自定义的Evaluator，第二个是可变长参数,Object类型的。

这里我们是强制传入Evaluator的，因为Evaluator的作用是根据当前动画的显示进度，计算出对应的值，因为Object是我们自定义的，所以这个值的转换的过程也必须是由我们指定的，不然系统也不知道怎么转换。

示例代码:

```java
ValueAnimator animator = ValueAnimator.ofObject(new CharEvaluator(),new Character('A'),new Character('Z'));  
animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {  
    @Override  
    public void onAnimationUpdate(ValueAnimator animation) {  
        char text = (char)animation.getAnimatedValue();  
        tv.setText(String.valueOf(text));  
    }  
});  
animator.setDuration(10000);  
animator.setInterpolator(new AccelerateInterpolator());  
animator.start();  
```

```java
public class CharEvaluator implements TypeEvaluator<Character> {  
    @Override  
    public Character evaluate(float fraction, Character startValue, Character endValue) {  
        int startInt  = (int)startValue;  
        int endInt = (int)endValue;  
        int curInt = (int)(startInt + fraction *(endInt - startInt));  
        char result = (char)curInt;  
        return result;  
    }  
}  
```

这里我们传入的两个参数是Character对象，一个是字母A,另一个是字母Z。
``animator.setInterpolator(new AccelerateInterpolator());``我们使用的插值器是加速插值器，它会负责加速。

我们自己实现的``CharEvaluator``，我们利用了ASCII的原理，在这里做了这样一个变化的效果。


## ofObject之自定义对象示例


效果图:

![](https://ws4.sinaimg.cn/large/006tKfTcly1fm05cmk4emg309m0hkafb.gif)

上代码:

Point.java
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


MyPointView.java
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
        ValueAnimator animator = ValueAnimator.ofObject(new PointEvaluator(), new Point(20), new Point(200));
        animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
            @Override
            public void onAnimationUpdate(ValueAnimator animation) {
                mCurPoint = (Point) animation.getAnimatedValue();
                invalidate();
            }
        });
        animator.setDuration(1000);
        animator.setInterpolator(new BounceInterpolator());
        animator.start();
    }

    class PointEvaluator implements TypeEvaluator<Point> {
        @Override
        public Point evaluate(float v, Point point, Point t1) {
            int start = point.getRadius();
            int end = t1.getRadius();
            int curValue = (int) (start + v * (end - start));
            return new Point(curValue);
        }
    }

}

```

MainActivity.java

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
                myPointView.doPointAnim();
            }
        });
    }
}
```

这里面核心的代码在于``doPointAnim``这个方法和``PointEvaluator``这个类
