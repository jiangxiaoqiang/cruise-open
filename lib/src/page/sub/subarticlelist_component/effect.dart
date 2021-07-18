
import 'package:cruise/src/page/sub/subarticlelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

Effect<SubArticleListState> buildEffect() {
  return combineEffects(<Object, Effect<SubArticleListState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.build: _didUpdateWidget,
  });
}

void _didUpdateWidget(Action action, Context<SubArticleListState> ctx) async {}

Future _onInit(Action action, Context<SubArticleListState> ctx) async {
}

