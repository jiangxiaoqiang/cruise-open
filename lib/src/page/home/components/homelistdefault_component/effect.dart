import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<HomeListDefaultState> buildEffect() {
  return combineEffects(<Object, Effect<HomeListDefaultState>>{
    HomeListDefaultAction.action: _onAction,
    HomeListDefaultAction.fetch_articleIds: _onFetchArticleIds,
    HomeListDefaultAction.onloading_more_homelist: _onLoadingHomeMoreList,
    Lifecycle.initState: _onInit,
  });
}

Future _onInit(Action action, Context<HomeListDefaultState> ctx) async {
  ArticleRequest articleRequest = new ArticleRequest(
      pageSize: 15, pageNum: 1, storiesType: StoriesType.topStories);
  List<int> ids = await Repo.getArticleIds(articleRequest);
  if (ids != null) {
    ctx.dispatch(
        HomeListDefaultActionCreator.onSetArticleIds(ids, articleRequest));
  }
}

void _onAction(Action action, Context<HomeListDefaultState> ctx) {}

Future _onLoadingHomeMoreList(
    Action action, Context<HomeListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  articleRequest.pageNum = articleRequest.pageNum + 1;
  List<int> ids = await Repo.getArticleIds(articleRequest);
  List<Item> articles = new List();
  if (ids != null) {
    for (int id in ids) {
      Item article = await Repo.fetchArticleItem(id);
      if (article != null) {
        articles.add(article);
      }
    }
    ctx.dispatch(
        HomeListDefaultActionCreator.onLoadingMoreHomeListUpdate(articles));
  }
}

Future _onFetchArticleIds(
    Action action, Context<HomeListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  articleRequest.pageNum = articleRequest.pageNum + 1;
  List<int> ids = await Repo.getArticleIds(articleRequest);
  if (ids != null) {
    ctx.dispatch(
        HomeListDefaultActionCreator.onSetArticleIds(ids, articleRequest));
  }
}
