import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ArticleDetailState> buildEffect() {
  return combineEffects(<Object, Effect<ArticleDetailState>>{
    Lifecycle.initState: _onInit,
    //Lifecycle.build: _didUpdateWidget,
  });
}

Future _onInit(Action action, Context<ArticleDetailState> ctx) async {
  //ArticleDetailState articleListState = ctx.state;
  //ctx.dispatch(ArticleDetailActionCreator.onSetArticle(articleListState.article));
}
