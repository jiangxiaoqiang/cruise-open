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
    //Lifecycle.build: _didUpdateWidget,

  });
}

void _didUpdateWidget(Action action, Context<ArticleListState> ctx) async {
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
  if (articles != null && articles.length > 0) {
    ctx.dispatch(ArticleListActionCreator.onSetArticles(articles));
  }
}
