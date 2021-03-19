import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<ArticleListState> buildEffect() {
  return combineEffects(<Object, Effect<ArticleListState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.build: _didUpdateWidget,
    Lifecycle.didUpdateWidget: _onA,
  });
}

void _onA(Action action, Context<ArticleListState> ctx) async {}

void _didUpdateWidget(Action action, Context<ArticleListState> ctx) async {}

Future _onInit(Action action, Context<ArticleListState> ctx) async {
  fetchArticles(action, ctx);
}

Future fetchArticles(Action action, Context<ArticleListState> ctx) async {
  ArticleListState articleListState = ctx.state;
  List<int> ids = articleListState.articleIds!;
  if (ids.length == 0) {
    return;
  }
  List<Item> articles = List.empty(growable: true);
  for (int id in ids) {
    Item article = (await Repo.fetchArticleItem(id))!;
    articles.add(article);
  }

  if (articles.length > 0) {
    ctx.dispatch(ArticleListActionCreator.onSetArticles(articles));
  }
}
