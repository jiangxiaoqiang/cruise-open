import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Effect<ArticleListState>? buildEffect() {
  return combineEffects(<Object, Effect<ArticleListState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.build: _didUpdateWidget,
  });
}

void _didUpdateWidget(Action action, Context<ArticleListState> ctx) async {}

Future _onInit(Action action, Context<ArticleListState> ctx) async {
}

