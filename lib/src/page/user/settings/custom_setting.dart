import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum Fruits {
  Apple,
  Banana,
  Orange,
}

class CustomSetting extends HookWidget {
  CustomSetting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentSelected = Set();

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
                       /* Fruits s = fruitValue ? Fruits.Apple : Fruits.Apple;
                        print(s);
                        if(s == Fruits.Apple && currentSelected.contains(Fruits.Apple)) {
                          currentSelected.remove(Fruits.Apple);
                        }else currentSelected.add(Fruits.Apple);*/
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
                  )
                ]))));
  }
}
