import 'package:cruise/src/common/article_action.dart';
import 'package:cruise/src/common/net/rest/http_result.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SubArticleDetailState> buildEffect() {
  return combineEffects(<Object, Effect<SubArticleDetailState>>{
    Lifecycle.initState: _onInit,
    //Lifecycle.build: _didUpdateWidget,
  });
}

Future _onInit(Action action, Context<SubArticleDetailState> ctx) async {
  SubArticleDetailState articleListState = ctx.state;
  if(articleListState.article.readStatus == false) {
    HttpResult result = await ArticleAction.read(articleId: articleListState.article.id);
    if (result.result == Result.ok) {
      ctx.dispatch(SubArticleDetailActionCreator.onRead());
    }
  }
}
