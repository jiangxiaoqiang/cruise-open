import 'package:cruise/src/widgets/app/global_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Fruits {
  Apple,
  Banana,
  Orange,
}

class MainPage extends StatelessWidget {

  var currentSelected = Set();

  void _changed(isCheck) {
    Get.find<GlobalController>().increment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("语言选择"),
        ),
        body: SafeArea(
            child: Container(
                child: Column(children: <Widget>[
                  ListTile(
                    title: const Text("简体中文"),
                    leading: Checkbox(
                      value: currentSelected.contains(Fruits.Apple),
                      onChanged: (bool? fruitValue) {
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("繁体中文"),
                    leading: Checkbox(
                      value: currentSelected.contains(Fruits.Apple),
                      onChanged: (bool? fruitValue) {},
                    ),
                  ),
                  ListTile(
                    title: const Text("英文"),
                    leading: Checkbox(
                      value: currentSelected.contains(Fruits.Apple),
                      onChanged: (bool? fruitValue) {},
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.94,
                    child: SwitchListTile(
                      // 是否选中 是否打开
                      value: Get.find<GlobalController>().showDebug,
                      // 当打开关闭的时候的回调
                      onChanged: _changed,
                      // 选中时 滑块的颜色
                      activeColor: Colors.red,
                      // 选中时 滑道的颜色
                      activeTrackColor: Colors.black,
                      // 选中时 滑块的图片
                      inactiveThumbColor: Colors.green,
                      // 未选中时 滑道的颜色
                      inactiveTrackColor: Colors.amberAccent,
                      // 未选中时 滑块的颜色
                      // 标题
                      title: Text("Debug"),
                      // 副标题 在标题下面的
                      // 是否垂直密集居中
                      dense: true,
                      // 左边的一个东西
                      secondary: Icon(Icons.access_time),
                    ),
                  ),
                ]))));
  }
}