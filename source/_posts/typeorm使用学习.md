---
layout: post
title: typeorm使用学习记录
date: 2017-12-28 10:53:46
tags: typeorm
categories: nodejs
---

# typeorm使用学习记录

typeorm可以操作很多数据库，用起来也挺方便的，重点是能够连接很多数据库，最近在做公司的项目只是草草的看了几眼，就开始使用了，最近有点闲下来了，打算从头过一遍typeorm的文档，好好的学习一下。

```JavaScript
import {BaseEntity, Entity, PrimaryGeneratedColumn, Column} from "typeorm";

@Entity()
export class User extends BaseEntity {

    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    firstName: string;

    @Column()
    lastName: string;

    @Column()
    isActive: boolean;

}
```

这样我们的UserDB实体就已经定义完了，如果我们把配置项打开的话，当我们数据库里面没有表的时候，typeorm也是会自动为我们创建表的。

当然所有的有效的想要被记录的实体，都一定要继承自BaseEntity,然后这个类就被提供了一些可以工作的方法。

```JavaScript
//存储一个对象
const user = new User();
user.firstName = "Timber";
user.lastName = "Saw";
user.isActive = true;
await user.save();

//删除一个对象
await user.remove();

// 查找
const users = await User.find({ skip: 2, take: 5 });
const newUsers = await User.find({ isActive: true });
const timber = await User.findOne({ firstName: "Timber", lastName: "Saw" });

```

我们在创建一个实体的时候，也可以为他增加一个方法，这个看起来就好像它的方法一样。

```JavaScript
import {BaseEntity, Entity, PrimaryGeneratedColumn, Column} from "typeorm";

@Entity()
export class User extends BaseEntity {

    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    firstName: string;

    @Column()
    lastName: string;

    @Column()
    isActive: boolean;

    static findByName(firstName: string, lastName: string) {
        return this.createQueryBuilder("user")
            .where("user.firstName = :firstName", { firstName })
            .andWhere("user.lastName = :lastName", { lastName })
            .getMany();
    }

}

//在外部就可以这样调用了
const timber = await User.findByName("Timber", "Saw");
```

## 自定义Respository

```JavaScript
const userRepository = connection.getRepository(User);

// example how to save DM entity
const user = new User();
user.firstName = "Timber";
user.lastName = "Saw";
user.isActive = true;
await userRepository.save(user);

// example how to remove DM entity
await userRepository.remove(user);

// example how to load DM entities
const users = await userRepository.find({ skip: 2, take: 5 });
const newUsers = await userRepository.find({ isActive: true });
const timber = await userRepository.findOne({ firstName: "Timber", lastName: "Saw" });
```

也可以自己封装一个Repository:

```JavaScript
import {EntityRepository, Repository} from "typeorm";
import {User} from "../entity/User";

@EntityRepository()
export class UserRepository extends Repository<User> {

    findByName(firstName: string, lastName: string) {
        return this.createQueryBuilder("user")
            .where("user.firstName = :firstName", { firstName })
            .andWhere("user.lastName = :lastName", { lastName })
            .getMany();
    }

}
```

也可以这么使用:

```
const userRepository = connection.getCustomRepository(UserRepository);
const timber = await userRepository.findByName("Timber", "Saw");
```

以上提供了很多种方法，至于具体想怎么使用，还是看我们自己的选择。

Data Mappter的方式可能更适用于一些大型的项目，这样，可以帮助我们维护我们的软件.
Active record的方式可能更加简洁。
