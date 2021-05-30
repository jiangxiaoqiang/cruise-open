import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(HistoryState state, Dispatch dispatch, ViewService viewService) {
  Widget navHistoryList() {
    return viewService.buildComponent("homelist");
  }

  return Scaffold(body: SafeArea(child: navHistoryList()));
}
