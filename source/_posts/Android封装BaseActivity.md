---
title: Android封装BaseActivity
date: 2017-11-25 15:23:26
tags: BaseActivity
categories: Android
---

# Android封装BaseActivity

Activity在我们的日常开发中应该是最为常用的组件了，基础的使用大家肯定都是会用的，但是有的时候我们需要把它封装一下，功能大概如下:

- 抽象出公共方法，增强代码复用的逻辑
- 统一管理ActionBar
- 统一管理Toast,Log,Dialog

直接上代码吧，好像没什么可说的了

```java
//BaseActivity.java
public abstract class BaseActivity extends AppCompatActivity implements DialogControl, BaseViewInterface {

    private boolean _isVisible = false;
    protected LayoutInflater mInflater;
    protected ViewGroup mActionBar;
    private LoadingUtils loading;
    private String mActionBarTitle;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        onBeforeSetContentLayout();
        if (getLayoutId() != 0) {
            LinearLayout layout = new LinearLayout(this);
            layout.setOrientation(LinearLayout.VERTICAL);
            if (hasBackButton()) {
                mActionBar = (ViewGroup) LayoutInflater.from(this).inflate(R.layout.action_bar_layout, null);
                TextView tv = (TextView) mActionBar.findViewById(R.id.action_bar_title);

                tv.setText(getActionBarTitle());
                mActionBar.findViewById(R.id.action_bar_back).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Log.e("lin", "---lin--->  111111111111111111111111");
                        finish();
                    }
                });
                layout.addView(mActionBar);
            }
            View view = LayoutInflater.from(this).inflate(getLayoutId(), null);
            layout.addView(view);
            setContentView(layout);
        }
        ButterKnife.bind(this);
        init(savedInstanceState);
        initData();
        initViews();
    }

    @Override
    protected void onPause() {
        super.onPause();
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    protected void onBeforeSetContentLayout() {
    }

    protected int getLayoutId() {
        return 0;
    }

    protected View inflateView(int resId) {
        return mInflater.inflate(resId, null);
    }

    protected String getActionBarTitle() {
        return mActionBarTitle;
    }

    protected boolean hasBackButton() {
        return false;
    }

    protected boolean hasActionBar() {
        return false;
    }

    protected void init(Bundle savedInstanceState) {
    }



    @Override
    public void showWaitDialog() {
        if (_isVisible) {
            return;
        }
        _isVisible = true;
        loading = new LoadingUtils(this).setMessage("正在加载,请稍后...");
        loading.show();
    }

    @Override
    public void hideWaitDialog() {
        if (_isVisible && loading != null) {
            _isVisible = false;
            loading.dismiss();

        }
    }
}

```

```java
//DialogControl.java
public interface DialogControl {

    public abstract void showWaitDialog();

    public abstract void hideWaitDialog();

}
```

```java
//BaseViewInterface.java
public interface BaseViewInterface {

    void initViews();

    void initData();

}
```

以上便是对Activity的封装～
