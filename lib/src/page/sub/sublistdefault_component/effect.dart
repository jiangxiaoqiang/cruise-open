import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<SubListDefaultState> buildEffect() {
  return combineEffects(<Object, Effect<SubListDefaultState>>{
    HomeListDefaultAction.fetch_articleIds: _onFetchArticleIds,
    HomeListDefaultAction.loading_more_articles: _onLoadingMoreArticles,
    HomeListDefaultAction.fetch_newest_articles: _onFetchNewestArticles,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
  });
}

void _onBuild(Action action, Context<SubListDefaultState> ctx) {
  /*SubListDefaultState homeListDefaultState = ctx.state;
  ArticleRequest articleRequest = homeListDefaultState.articleRequest;
  if (homeListDefaultState.lastStoriesType != articleRequest.storiesType) {
    // switch the article navigator tab
    // initial the new type of article
    //ctx.dispatch(HomeListDefaultActionCreator.onUpdateLastStoriesType(articleRequest.storiesType));
    //initArticles(action, ctx);
  }*/
}

Future _onInit(Action action, Context<SubListDefaultState> ctx) async {
  if (ctx.state.subArticleListState.articles.length > 0) {
    return;
  }
  initArticles(action, ctx);
}

Future initArticles(Action action, Context<SubListDefaultState> ctx) async {
  SubListDefaultState homeListDefaultState = ctx.state;
  ArticleRequest articleRequest = homeListDefaultState.articleRequest;
  articleRequest.pageNum = 1;
  articleRequest.offset = null;
  List<Item> articles = await Repo.getArticles(articleRequest);
  // 这里注意即使文章为空也要设置状态
  List<int> ids = articles.map((e) => int.parse(e.id)).toList();
  ctx.dispatch(SubHomeListDefaultActionCreator.onSetArticleIds(ids, articles, articleRequest));
}

Future _onLoadingMoreArticles(Action action, Context<SubListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  articleRequest.pageNum = articleRequest.pageNum + 1;
  SubListDefaultState homeListDefaultState = ctx.state;
  if (homeListDefaultState.articleRequest.offset != null && homeListDefaultState.articleRequest.offset! > 0) {
    articleRequest.offset = homeListDefaultState.articleRequest.offset;
  }
  List<Item> articles = await Repo.getArticles(articleRequest);
  ctx.dispatch(SubHomeListDefaultActionCreator.onLoadingMoreArticlesUpdate(articles));
}

Future _onFetchNewestArticles(Action action, Context<SubListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  List<Item> articles = await Repo.getArticles(articleRequest);
  ctx.dispatch(SubHomeListDefaultActionCreator.onFetchNewestArticlesUpdate(articles));
}

Future _onFetchArticleIds(Action action, Context<SubListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  articleRequest.pageNum = articleRequest.pageNum + 1;
  List<Item> articles = await Repo.getArticles(articleRequest);
  List<int> ids = articles.map((e) => int.parse(e.id)).toList();
  ctx.dispatch(SubHomeListDefaultActionCreator.onSetArticleIds(ids, articles, articleRequest));
}
