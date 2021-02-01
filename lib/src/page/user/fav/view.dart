import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(FavArticleState state, Dispatch dispatch, ViewService viewService) {
  Widget navFavList() {
    return viewService.buildComponent("homelist");
  }

  return Scaffold(body: SafeArea(child: navFavList()));
}
