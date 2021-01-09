import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ArticleListState> buildEffect() {
  return combineEffects(<Object, Effect<ArticleListState>>{
    ArticleListAction.get_articles: _onGetArticleIds,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _didUpdateWidget,
  });
}

void _didUpdateWidget(Action action, Context<ArticleListState> ctx) async {

}

Future _onInit(Action action, Context<ArticleListState> ctx) async {
  ArticleListState articleListState = ctx.state;
  List<int> ids = articleListState.articleIds;
  List<Item> articles = new List();
  for (int id in ids) {
    Item article = await Repo.fetchArticleItem(id);
    if (article != null) {
      articles.add(article);
    }
  }

  if (articles != null && articles.length > 0) {
    ctx.dispatch(ArticleListActionCreator.onSetArticles(articles));
  }
}

Future _onGetArticleIds(Action action, Context<ArticleListState> ctx) async {
  List<int> ids = (action.payload as List<int>);
  List<Item> articles = new List();
  ids.forEach((element) async {
    Item article = await Repo.fetchArticleItem(element);
    if (article != null) {
      //articles.add(article);
    }
  });
  if (articles != null && articles.length > 0) {
    ctx.dispatch(ArticleListActionCreator.onSetArticles(articles));
  }
}
