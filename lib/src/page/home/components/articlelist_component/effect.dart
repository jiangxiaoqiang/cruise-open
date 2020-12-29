import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ArticleListState> buildEffect() {
  return combineEffects(<Object, Effect<ArticleListState>>{
    ArticleListAction.action: _onAction,
    ArticleListAction.get_articles: _onGetArticleIds,
    Lifecycle.initState: _onInit,
  });
}

Future _onInit(Action action, Context<ArticleListState> ctx) async {
  ArticleListState articleListState = ctx.state;
  List<int> ids = articleListState.articleIds;
  List<Item> articles = new List();
  for(final i in ids){
    Item article = await Repo.fetchArticleItem(i);
    if (article != null) {
      articles.add(article);
    }
  }
  if (articles != null) {
    ctx.dispatch(ArticleListActionCreator.onSetArticles(articles));
  }
}

void _onAction(Action action, Context<ArticleListState> ctx) {}

Future _onGetArticleIds(Action action, Context<ArticleListState> ctx) async {
  List<int> ids = (action.payload as List<int>);
  List<Item> articles = new List();
  ids.forEach((element) async {
    Item article = await Repo.fetchArticleItem(element);
    if (article != null) {
      articles.add(article);
    }
  });
  if (articles != null) {
    ctx.dispatch(ArticleListActionCreator.onSetArticles(articles));
  }
}
