---
layout: post
title: ubuntu下安装ruby
date: 2018-01-12 20:35:31
tags: Linux下安装Ruby
categories: Linux
---

# ubuntu下安装ruby


## 1.使用brightbox ppa仓库安装

```sh
sudo apt-get install python-software-properties

sudo apt-add-repository ppa:brightbox/ruby-ng

sudo apt-get update

sudo apt-get install ruby2.1 ruby2.1-dev
```


## 2.在官网下载压缩包安装

```sh
curl -O -L https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.7.tar.gz

tar xf ruby-2.2.7.tar.gz

cd ruby-2.2.7

./configure --prefix=/usr/local/ruby-2.2.7
make && make install

ln -s /usr/local/ruby-2.2.7/bin/ruby /usr/bin/ruby

ruby -v

ruby 2.2.7p470 (2017-03-28 revision 58194) [x86_64-linux]
```
