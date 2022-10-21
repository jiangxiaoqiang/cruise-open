import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class About extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());

    return Scaffold(
      appBar: AppBar(
        title: Text("关于cruise"),
        actions: [
          TextButton(
            onPressed: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text("关于cruise"),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              title: Text("软件许可协议"),
              leading: Icon(EvaIcons.moon),
              onTap: () => {},
            ),
            ListTile(
              title: Text("隐私政策"),
              leading: Icon(EvaIcons.moon),
              onTap: () => {},
            ),
            ListTile(
              title: Text("版本信息"),
              leading: Icon(EvaIcons.moon),
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
