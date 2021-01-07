import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<HomeListDefaultState> buildEffect() {
  return combineEffects(<Object, Effect<HomeListDefaultState>>{
    HomeListDefaultAction.action: _onAction,
    HomeListDefaultAction.get_articleIds: _onGetArticleIds,
    Lifecycle.initState: _onInit,
  });
}

Future _onInit(Action action, Context<HomeListDefaultState> ctx) async {
  ArticleRequest articleRequest = new ArticleRequest(
      pageSize: 250,
      pageNum: 1,
      storiesType: StoriesType.topStories
  );
  List<int> ids = await Repo.getArticleIds(articleRequest);
  if (ids != null) {
    ctx.dispatch(HomeListDefaultActionCreator.onSetArticleIds(ids));
  }
}

void _onAction(Action action, Context<HomeListDefaultState> ctx) {}

Future _onGetArticleIds(
    Action action, Context<HomeListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  List<int> ids = await Repo.getArticleIds(articleRequest);
  if (ids != null) {
    ctx.dispatch(HomeListDefaultActionCreator.onSetArticleIds(ids));
  }
}
