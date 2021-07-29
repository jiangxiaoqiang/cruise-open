import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(TestState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Test"),
    ),
    body: SafeArea(
        child: Form(
          child: ListView(
            children: [
             Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 16,
                    right: 16,
                    top: 16
                ),
                child: Html(
                    //data: "<p><img src=\"https://tva1.sinaimg.cn/mw690/6dd57921ly1grqsvwx478g2066088e82.gif\" /></p>",
                    data: "<p><img src=\"https://tva1.sinaimg.cn/mw690/006v119zly1gsu8ni6jbbg30a007q1l2.gif\" /></p>"
                    ),
              ),
              /*Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16.0,
                      left: 16,
                      right: 16,
                      top: 16
                  ),
                  child: Image.network('https://tva1.sinaimg.cn/mw690/006v119zly1gsu8ni6jbbg30a007q1l2.gif')
              ),*/
            ],
          ),
        )),
  );
}
