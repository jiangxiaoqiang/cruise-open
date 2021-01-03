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
  List<Item> articles = getStaticArticle();
  //Item article = await Repo.fetchArticleItem(2336);
  /*if (article != null) {
    articles.add(article);
  }*/

  if (articles != null) {
    ctx.dispatch(ArticleListActionCreator.onSetArticles(articles));
  }
}

List<Item> getStaticArticle() {
  List<Item> items = new List();
  Item item = new Item();
  item.id = 2236.toString();
  item.title = "aaaaa";
  item.favCount = 0;
  item.upvoteCount = 0;
  item.isUpvote = 1;
  item.isFav = 1;
  item.author = "dd";
  item.content = "dddd";
  item.type = StoryType.story;
  item.link = "www.baidu.com";
  item.pubTime = 2222;
  items.add(item);
  return items;
}

void _onAction(Action action, Context<ArticleListState> ctx) {}

Future _onGetArticleIds(Action action, Context<ArticleListState> ctx) async {
  List<int> ids = (action.payload as List<int>);
  List<Item> articles = new List();
  ids.forEach((element) async {
    Item article = await Repo.fetchArticleItem(element);
    if (article != null) {
      //articles.add(article);
    }
  });
  if (articles != null) {
    ctx.dispatch(ArticleListActionCreator.onSetArticles(articles));
  }
}
