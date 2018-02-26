---
layout: post
title: Android中四种常见的线程池
date: 2018-02-26 15:04:07
tags:
---

# Android四种常见的线程池

## 引入线程池的好处

1. 提升性能，创建和消耗对象时费CPU资源
2. 防止内存过度消耗，控制活动线程的数量，防止并发线程过多


创建线程，推荐使用Executors的工厂方法来创建线程池，Executors类是官方提供的一个工厂类，它里面封装好了重多功能不一样的线程池。下面介绍一些常用的线程池:

```java
public ThreadPoolExecutor(    
	//核心线程数，除非allowCoreThreadTimeOut被设置为true，否则它闲着也不会死    
	int corePoolSize,     
	//最大线程数，活动线程数量超过它，后续任务就会排队                       
	int maximumPoolSize,     
	//超时时长，作用于非核心线程（allowCoreThreadTimeOut被设置为true时也会同时作用于核心线程），闲置超时便被回收               
	long keepAliveTime,                              
	//枚举类型，设置keepAliveTime的单位，有TimeUnit.MILLISECONDS（ms）、TimeUnit. SECONDS（s）等    
	TimeUnit unit,    
	//缓冲任务队列，线程池的execute方法会将Runnable对象存储起来    
	BlockingQueue<Runnable> workQueue,    
	//线程工厂接口，只有一个new Thread(Runnable r)方法，可为线程池创建新线程    
	ThreadFactory threadFactory) 
```

## 四种常见的线程池

1. FixedThreadPool()

该方法，返回的是一个固定线程数量的线程池，该线程池中的线程数量始终不变，即不会再创建新的线程，也不会销毁已经创建好的线程，自始至终都是固定的线程在工作，所以该线程池可以控制线程的最大并发数。


2. CachedThreadPool()

该方法返回的是一个可以根据实际情况调整线程池中线程数量的线程池，即该线程池中的数量不确定，是根据实际情况动态调整的。这个线程池是有一个保持活动时间的参数的，如果空闲线程超过了保持活动的时间，那么就会立刻停止该线程，默认时间是60s

3. SingleThreadExecutor()

该方法返回一个只有一个线程的线程池，即每次只能执行一个线程任务，多余的任务会保存到一个任务队列中，等待这一个线程空闲，当这个线程空闲了再按FIFO方式顺序执行任务队列中的任务。


4. ScheduledThreadPool()

该方法返回一个可以控制线程池内线程定时或周期性执行某任务的线程池。




































