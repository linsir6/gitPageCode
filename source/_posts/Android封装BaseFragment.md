---
title: Android封装BaseFragment
date: 2017-11-27 16:15:08
tags: BaseFragment
categories: Android
---

# Android封装BaseFragment

上一篇文章，我们封装了BaseActivity，这篇文章我们打算封装一个BaseFragment，它的功能和BaseActivity类似，都是要将一些公共的功能抽象出来，将公共的UI封装起来。

- 抽象出公共方法，增强代码复用的逻辑
- 统一管理ActionBar
- 统一管理Toast,Log,Dialog

同时我们在已经封装好的BaseFragment的基础上还可以封装出BaseListFragment，这个Fragment可以用做订单列表的展示，这种页面。

上代码:

```java
BaseFragment.java

public class BaseFragment extends Fragment implements
        android.view.View.OnClickListener, BaseFragmentInterface {

    protected LayoutInflater mInflater;
    protected ViewGroup mActionBar;
    private String mActionBarTitle;
    Unbinder unbinder;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        LinearLayout layout = new LinearLayout(getActivity());
        View view;
        layout.setOrientation(LinearLayout.VERTICAL);
        if (hasBackButton()) {
            mActionBar = (ViewGroup) LayoutInflater.from(getActivity()).inflate(R.layout.action_bar_layout, null);
            TextView tv = (TextView) mActionBar.findViewById(R.id.action_bar_title);

            tv.setText(getActionBarTitle());
            mActionBar.findViewById(R.id.action_bar_back).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Log.e("lin", "---lin--->  111111111111111111111111");
                }
            });
            layout.addView(mActionBar);
        }
        view = LayoutInflater.from(getActivity()).inflate(getLayoutId(), null);
        layout.addView(view);
        unbinder = ButterKnife.bind(this, view);
        initData();
        initView(layout);
        return layout;
    }

    private boolean hasBackButton() {
        return false;
    }

    @Override
    public void onResume() {
        super.onResume();
    }

    @Override
    public void onPause() {
        super.onPause();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
    }

    protected int getLayoutId() {
        return 0;
    }

    protected View inflateView(int resId) {
        return this.mInflater.inflate(resId, null);
    }

    public boolean onBackPressed() {
        return false;
    }


    protected void showWaitDialog() {
        FragmentActivity activity = getActivity();
        if (activity instanceof DialogControl) {
            ((DialogControl) activity).showWaitDialog();
        }
    }

    protected void hideWaitDialog() {
        FragmentActivity activity = getActivity();
        if (activity instanceof DialogControl) {
            ((DialogControl) activity).hideWaitDialog();
        }
    }

    protected String getActionBarTitle() {
        return mActionBarTitle;
    }

    @Override
    public void onClick(View v) {

    }

    @Override
    public void initView(View view) {

    }

    @Override
    public void initData() {

    }
}
```


```java
BaseFragmentInterface.java

public interface BaseFragmentInterface {

    public void initView(View view);

    public void initData();

}
```

```java
BaseListFragment.java

public class BaseListFragment extends BaseFragment {


    @BindView(R.id.tv_hint_no_order)
    public TextView tvHintNoOrder;
    @BindView(R.id.rc_base_fr)
    public RecyclerView rcBaseFr;
    @BindView(R.id.smart_refresh_base_fr)
    public SmartRefreshLayout smartRefreshBaseFr;
    Unbinder unbinder;

    @Override
    protected int getLayoutId() {
        return R.layout.fragment_pull_refresh_recycler_view;
    }

    @Override
    public void initView(View view) {
        super.initView(view);


    }

}
```

```xml
fragment_pull_refresh_recycler_view.xml

<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <TextView
        android:id="@+id/tv_hint_no_order"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginTop="15dp"
        android:gravity="center"
        android:text="暂无此类订单" />

    <com.scwang.smartrefresh.layout.SmartRefreshLayout
        android:id="@+id/smart_refresh_base_fr"
        android:layout_width="match_parent"
        android:layout_height="match_parent">

        <com.scwang.smartrefresh.layout.header.ClassicsHeader
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:background="@color/grey_249" />


        <android.support.v7.widget.RecyclerView
            android:id="@+id/rc_base_fr"
            android:layout_width="match_parent"
            android:layout_height="match_parent">


        </android.support.v7.widget.RecyclerView>

        <com.scwang.smartrefresh.layout.footer.ClassicsFooter
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:background="@color/grey_249" />


    </com.scwang.smartrefresh.layout.SmartRefreshLayout>
</RelativeLayout>

```

![效果图](https://ws1.sinaimg.cn/large/006tKfTcly1flwq9ozvq1j30io0uadg4.jpg)
