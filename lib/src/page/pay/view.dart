import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(PayState state, Dispatch dispatch, ViewService viewService) {

  return Scaffold(
      body: SafeArea(
          child: Container(
            child: ElevatedButton(
              onPressed: () {  },
              child: Text("订阅"),
            ),
          )
      )
  );
}
