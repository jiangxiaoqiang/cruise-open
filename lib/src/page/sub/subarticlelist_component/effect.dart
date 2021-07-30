
import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/page/sub/subarticlelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';

Effect<SubArticleListState>? buildEffect() {
  return combineEffects(<Object, Effect<SubArticleListState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.build: _didUpdateWidget,
  });
}

void _didUpdateWidget(Action action, Context<SubArticleListState> ctx) async {

}

Future _onInit(Action action, Context<SubArticleListState> ctx) async {
  SubArticleListState articleListState = ctx.state;
  List<Item> channels = articleListState.articles;
  if (channels.length > 0) {
    ctx.dispatch(SubArticleListActionCreator.onSetArticles(channels));
  }
}

