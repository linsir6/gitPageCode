---
title: Android多线程使用
date: 2018-02-26 14:43:10
tags: 多线程
categories: Android
---

# Android多线程使用

## 使用目的

1. 解决耗时任务
  文件IO、联网请求、数据库操作、RPC

2. 提高并发能力
  同一时间处理更多事情

3. 防止ANR
  InputDispatching Timeout：输入事件分发超时5s（触摸或按键）
  Service Timeout：服务20s内未执行完
  BroadcastQueue Timeout：前台广播10s内未执行完
  ContentProvider Timeout：内容提供者执行超时

4. 避免掉帧
  要达到每秒60帧，每帧必须16ms处理完


## 使用方式

### 1.Thread

1.new Thread,重载run方法
2.实现Runable接口，作为参数传给Thread

```java
public static void main(String[] args){
        //Android中   UI线程的Id恒定为1
        System.out.println("UI Thread Id : "+Thread.currentThread().getId());

        new Thread(){
            @Override
            public void run() {
                System.out.println("run in thread "+Thread.currentThread().getId());
            }
        }.start();

        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                // TODO: 2016/12/2
                System.out.println("run in thread "+Thread.currentThread().getId());
            }
        };

        new Thread(runnable).start();
    }
```

### 2.AsyncTask

android特有的轻量级异步任务类，它可以在线程池中执行后台任务，然后把执行进度和结果传递给主线程中更新UI。但不适合特别耗时的后台任务。

```java
public class MyTask extends AsyncTask<String,Integer,String> {

    String TAG = "haha";

    @Override
    protected void onPreExecute() {

        Log.d(TAG,"onPreExecute run in thread "+Thread.currentThread().getId());
    }

    //只有这个方法在后台执行，其他方法都在UI线程
    @Override
    protected String doInBackground(String... params) {

        Log.d(TAG,"doInBackground run in thread "+Thread.currentThread().getId());
        //传入的参数和execute中传入参数相同
        Log.d(TAG,"input param "+params[0]);

        //此方法将回调onProgressUpdate 用于进度更新
        publishProgress(5);
        //此return的信息将传递到onPostExecute
        return "task done!";
    }

    @Override
    protected void onProgressUpdate(Integer... values) {

        Log.d(TAG,"onProgressUpdate run in thread "+Thread.currentThread().getId());

        Log.d(TAG,"update progress "+values[0]);

    }

    @Override
    protected void onPostExecute(String s) {

        Log.d(TAG,"onPostExecute run in thread "+Thread.currentThread().getId());
        Log.d(TAG,"onPostExecute input "+s);

    }

}
```

### 3.HandlerThread

HandlerThread实际上是一个带有Looper的Thread，从而可向子线程传递消息。

```java
@Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //HandlerThread 其实就是一个带有Looper的Thread
        HandlerThread handlerThread = new HandlerThread("handler-thread");
        handlerThread.start();

        Log.d(TAG,"handlerthread id :"+handlerThread.getId());

        //用handlerThread的looper生成handler  用于向子线程中发送消息、runnable 等
        Handler handler = new Handler(handlerThread.getLooper()){
            @Override
            public void handleMessage(Message msg) {
                Log.d(TAG,"handleMessage received in thread "+Thread.currentThread().getId());

                Log.d(TAG,"received message is "+msg.obj);
            }
        };//必须先start thread

        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                Log.d(TAG,"this runnable run in thread "+Thread.currentThread().getId());
            }
        };
        //使runnable在子线程（即handlerThread线程执行）
        handler.post(runnable);
        //此消息发送至handlerThread线程
        Message message = new Message();
        message.obj = "test message";
        handler.sendMessage(message);
    }
```

### 4.ExecutorService

### 5.FixedThreadPool

### 6.CachedThreadPool

### 7.ScheduledThreadPool

### 8.SingleThreadPool

### 9.IntentService
