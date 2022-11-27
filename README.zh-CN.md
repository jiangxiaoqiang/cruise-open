# cruise-open

一款简洁的RSS(Really Simple Syndication)阅读器，碎片时间随手翻一翻。

## 为什么需要Cruise

写Cruise是需要阅读自己感兴趣的内容。且看各大媒体推送的内容：

* 社会上有哪些潜规则让你细思恐极？
* 原来，喜欢发朋友圈的人，和不喜欢发朋友圈的人，差别真的很大
* 男人，千万不要碰这四种女人
* 我前妻，她，不可能会嫁人的
* 那一夜，我错的太离谱

总是起这种让人忍不住点进去的的标题。能不能自己找一找感兴趣的内容？RSS正好是订阅感兴趣的频道，接受特定频道推送信息。遗憾的是没有找到合适的RSS阅读器。

### 许多RSS阅读器只有PC版

只有PC客户端就不能在手机上阅读，意味着必须有PC在身边，但是很多时候身边只有手机。 也不能在平板上阅读，有的阅读器也只能支持Windows或者macOS。 刚好在学习Flutter，试试写一个RSS阅读器，就这样，Cruise就成了试验场。Flutter的目标是支持Android、iOS、Windows、Mac、Web、以及嵌入式设备。

## 有改善吗

目前来看，并没有质的改变。高质量的RSS源非常稀缺。

## 项目信息

### 分支

| 分支名称      | 备注   |     |
| --------- | ---- | --- |
| main      | 主分支  |     |
| develop   | 开发分支 |     |
| feature/* | 特性分支 |     |

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

构建ipa(iOS and iPadOS application archive file)包：

```bash
~/fvm/versions/{version}/bin/flutter build ipa --export-options-plist=/Users/xiaoqiangjiang/source/reddwarf/frontend/cruise-open/ios/Runner/Info.plist --release
~/fvm/versions/3.3.0/bin/flutter build ipa --export-options-plist=/Users/xiaoqiangjiang/source/reddwarf/frontend/cruise-open/ios/Runner/Info.plist --release
```

在设备上运行应用，可以断开USB线：

```bash
~/fvm/versions/{version}/bin/flutter run --release
```

### 运行界面

| ![Kiku](docs/snapshot/home.jpeg)        | ![Kiku](docs/snapshot/sub.jpeg) |
| --------------------------------------- | ------------------------------- |
| ![Kiku](docs/snapshot/user-center.jpeg) |                                 |
