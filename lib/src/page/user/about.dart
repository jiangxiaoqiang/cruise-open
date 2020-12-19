import 'package:Cruise/src/common/theme.dart';
import 'package:Cruise/src/common/view_manager.dart';
import 'package:Cruise/src/page/login.dart';
import 'package:Cruise/src/page/reg/verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:Cruise/src/common/auth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class About extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());

    final currentView = useProvider(viewProvider.state);
    final ViewManager viewManager = useProvider(viewProvider);
    final currentTheme = useProvider(themeProvider.state);
    final ThemeManager themeManager = useProvider(themeProvider);

    return Scaffold(
      appBar: AppBar(title: Text("关于Cruise"),
        actions: [
        FlatButton(
        textColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Text("关于Cruise"),
        shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
      ),],),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            ListTile(
              title: Text("软件许可协议"),
              leading: Icon(Feather.moon),
              onTap: () => showDialog(

              ),
            ),
            ListTile(
              title: Text("隐私政策"),
              leading: Icon(Feather.moon),
              onTap: () => showDialog(

              ),
            ),
            ListTile(
              title: Text("版本信息"),
              leading: Icon(Feather.moon),
              onTap: () => showDialog(

              ),
            ),
          ],
        ),
      ),
    );
  }
}
