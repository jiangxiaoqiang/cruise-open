# cruise-open

一款简洁的RSS(Really Simple Syndication)阅读器，简单无广告，碎片时间随手翻一翻。


## 为什么Cruise

写Cruise是需要阅读自己感兴趣的内容。且看各大媒体推送的内容：

* 社会上有哪些潜规则让你细思恐极？
* 原来，喜欢发朋友圈的人，和不喜欢发朋友圈的人，差别真的很大
* 男人，千万不要碰这四种女人
* 我前妻，她，不可能会嫁人的
* 那一夜，我错的太离谱

能不能自己找一找感兴趣的内容？RSS正好是订阅感兴趣的频道，接受特定频道信息这样的机制。遗憾的是没有找到合适的RSS阅读器。

### 不能在手机上阅读

大多数只能在电脑上阅读，意味着必须有PC在身边，但是很多时候身边只有手机。

### 多端

和不能在手机上阅读有点类似，但是这里要求是支持多个平台，因为公司是macOS操作系统，家里是Fedora操作系统，所以macOS和Linux都要支持，移动设备也要支持。

刚好在学习Flutter，试试写一个RSS阅读器，就这样，Cruise就成了试验场。

## 有改善吗

被各种标题党和垃圾信息恶心到了，要告别这样的环境，要找到RSS频道订阅自己感兴趣的内容，听起来很不错。但实际情况还是很残酷，高质量的RSS源非常稀缺。一段时间下来，真的有改变么？真的有从无聊的内容里解放出来么？目前来看，并没有质的改变。

## 项目信息

### 分支

| 分支名称  | 备注     |      |
| --------- | -------- | ---- |
| main      | 主分支   |      |
| develop   | 开发分支 |      |
| feature/* | 特性分支 |      |

### 构建

默认使用Flutter官方源，但是有时确实下载包很慢或者根本无法下载，使用如下命令临时使用大陆镜像源：

```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn \ 
&& export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn \
&& ~/apps/flutter/bin/flutter run -v
```

如果使用fvm工具管理版本：


```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn \
&& export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn \
&& ~/fvm/versions/2.10.3/bin/flutter run -v
```



### About rss

https://tech.qq.com/a/20130314/000123.htm
