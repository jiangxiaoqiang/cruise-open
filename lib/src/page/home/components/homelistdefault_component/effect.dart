import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/common/article_action.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
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
  ArticleRequest articleRequest = homeListDefaultState.articleRequest;
  if (homeListDefaultState.lastStoriesType != articleRequest.storiesType) {
    // switch the article navigator tab
    // initial the new type of article
    ctx.dispatch(HomeListDefaultActionCreator.onUpdateLastStoriesType(articleRequest.storiesType));
    initArticles(action, ctx);
  }
}

Future _onInit(Action action, Context<HomeListDefaultState> ctx) async {
  initArticles(action, ctx);
}

Future initArticles(Action action, Context<HomeListDefaultState> ctx) async {
  HomeListDefaultState homeListDefaultState = ctx.state;
  ArticleRequest articleRequest = homeListDefaultState.articleRequest;
  articleRequest.pageNum = 1;
  articleRequest.offset = null;
  List<Item> articles = await Repo.getArticles(articleRequest);
  // 这里注意即使文章为空也要设置状态
  List<int> ids = articles.map((e) => int.parse(e.id)).toList();
  ctx.dispatch(HomeListDefaultActionCreator.onSetArticleIds(
      ids, articles, articleRequest));
}

Future _onLoadingMoreArticles(Action action, Context<HomeListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  articleRequest.pageNum = articleRequest.pageNum + 1;
  HomeListDefaultState homeListDefaultState = ctx.state;
  if (homeListDefaultState.articleRequest.offset != null && homeListDefaultState.articleRequest.offset! > 0) {
    articleRequest.offset = homeListDefaultState.articleRequest.offset;
  }
  List<Item> articles = await Repo.getArticles(articleRequest);
  ctx.dispatch(HomeListDefaultActionCreator.onLoadingMoreArticlesUpdate(articles));
}

Future _onFetchNewestArticles(Action action, Context<HomeListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  List<Item> articles = await Repo.getArticles(articleRequest);
  ctx.dispatch(HomeListDefaultActionCreator.onFetchNewestArticlesUpdate(articles));
}

Future _onFetchArticleIds(Action action, Context<HomeListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  articleRequest.pageNum = articleRequest.pageNum + 1;
  List<Item> articles = await Repo.getArticles(articleRequest);
  List<int> ids = articles.map((e) => int.parse(e.id)).toList();
  ctx.dispatch(HomeListDefaultActionCreator.onSetArticleIds(ids, articles, articleRequest));
}
