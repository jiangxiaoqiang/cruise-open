import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<HomeListDefaultState> buildEffect() {
  return combineEffects(<Object, Effect<HomeListDefaultState>>{
    HomeListDefaultAction.fetch_articleIds: _onFetchArticleIds,
    HomeListDefaultAction.loading_more_articles: _onLoadingMoreArticles,
    HomeListDefaultAction.fetch_newest_articles: _onFetchNewestArticles,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
  });
}

void _onBuild(Action action, Context<HomeListDefaultState> ctx) {
  HomeListDefaultState homeListDefaultState = ctx.state;
  String name = action.payload as String;
  ArticleRequest articleRequest = homeListDefaultState.articleRequest;
  if (homeListDefaultState.lastStoriesType != articleRequest.storiesType) {
    // switch the article navigator tab
    // initial the new type of article
    ctx.dispatch(HomeListDefaultActionCreator.onUpdateLastStroiesType(articleRequest.storiesType));
    initArticles(action, ctx);
  }
}

Future _onInit(Action action, Context<HomeListDefaultState> ctx) async {
  //initArticles(action, ctx);
}

Future initArticles(Action action, Context<HomeListDefaultState> ctx) async {
  HomeListDefaultState homeListDefaultState = ctx.state;
  ArticleRequest articleRequest = homeListDefaultState.articleRequest;
  articleRequest.pageNum = 1;
  articleRequest.offset = null;
  List<int> ids = await Repo.getElementIds(articleRequest);
  if (ids != null) {
    ctx.dispatch(HomeListDefaultActionCreator.onSetArticleIds(ids, articleRequest));
  }
}

Future _onLoadingMoreArticles(Action action, Context<HomeListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  articleRequest.pageNum = articleRequest.pageNum + 1;
  HomeListDefaultState homeListDefaultState = ctx.state;
  if (homeListDefaultState.articleRequest.offset != null && homeListDefaultState.articleRequest.offset > 0) {
    articleRequest.offset = homeListDefaultState.articleRequest.offset;
  }
  List<int> ids = await Repo.getElementIds(articleRequest);
  List<Item> articles = [];
  if (ids != null) {
    for (int id in ids) {
      Item article = await Repo.fetchArticleItem(id);
      if (article != null) {
        articles.add(article);
      }
    }
    ctx.dispatch(HomeListDefaultActionCreator.onLoadingMoreArticlesUpdate(articles));
  }
}

Future _onFetchNewestArticles(Action action, Context<HomeListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  List<int> ids = await Repo.getElementIds(articleRequest);
  List<Item> articles = [];
  if (ids != null) {
    for (int id in ids) {
      Item article = await Repo.fetchArticleItem(id);
      if (article != null) {
        articles.add(article);
      }
    }
    ctx.dispatch(HomeListDefaultActionCreator.onFetchNewestArticlesUpdate(articles));
  }
}

Future _onFetchArticleIds(Action action, Context<HomeListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  articleRequest.pageNum = articleRequest.pageNum + 1;
  List<int> ids = await Repo.getElementIds(articleRequest);
  if (ids != null) {
    ctx.dispatch(HomeListDefaultActionCreator.onSetArticleIds(ids, articleRequest));
  }
}
