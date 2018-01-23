---
title: docker学习记录
date: 2018-01-05 15:18:26
tags: Docker
categories: Docker
---

# docker学习记录

## 什么是Docker

Docker 使用 Google 公司推出的 Go 语言 进行开发实现，基于 Linux 内核的 cgroup，namespace，以及 AUFS 类的 Union FS 等技术，对进程进行封装隔离，属于 操作系统层面的虚拟化技术。由于隔离的进程独立于宿主和其它的隔离的进程，因此也称其为容器。最初实现是基于 LXC，从 0.7 版本以后开始去除 LXC，转而使用自行开发的 libcontainer，从 1.11 开始，则进一步演进为使用 runC 和 containerd。

Docker 在容器的基础上，进行了进一步的封装，从文件系统、网络互联到进程隔离等等，极大的简化了容器的创建和维护。使得 Docker 技术比虚拟机技术更为轻便、快捷。

下面的图片比较了 Docker 和传统虚拟化方式的不同之处。传统虚拟机技术是虚拟出一套硬件后，在其上运行一个完整操作系统，在该系统上再运行所需应用进程；而容器内的应用进程直接运行于宿主的内核，容器内没有自己的内核，而且也没有进行硬件虚拟。因此容器要比传统虚拟机更为轻便。

![](https://raw.githubusercontent.com/yeasy/docker_practice/master/introduction/_images/virtualization.png)

![](https://raw.githubusercontent.com/yeasy/docker_practice/master/introduction/_images/docker.png)

## 为什么要用Docker

1. 高效利用资源

2. 启动非常迅速

3. 环境的一致性 : 开发过程中的环境实在是多种多样，本地环境，开发环境，测试环境，线上环境等等环境，环境稍有处理不当，就会发生我本地没问题啊，测试怎么就好使呢这种情况

4. 迁移起来非常方便，只需要把镜像上传到仓库，然后再拉下来就好

5. 由于docker 是分层打包的，使得它更好扩展，由于社区的存在，有一大批非常优秀的景象存在供我们使用扩展











- ``docker ps`` 查看运行的容器
- ``docker inspect + 容器id`` 查看容器内容

会看到许多有关容器的信息，会包含数据卷等信息。

- ``docker exec -it gitlab-runner bash`` 进入容器
