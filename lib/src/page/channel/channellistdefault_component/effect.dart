import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ChannelListDefaultState> buildEffect() {
  return combineEffects(<Object, Effect<ChannelListDefaultState>>{
    Lifecycle.initState: _onInit,
  });
}

Future _onInit(Action action, Context<ChannelListDefaultState> ctx) async {
  ArticleRequest articleRequest = new ArticleRequest(
      pageSize: 15,
      pageNum: 1,
      storiesType: StoriesType.channels
  );
  List<int> ids = await Repo.getArticleIds(articleRequest);
  if (ids != null) {
    ctx.dispatch(ChannelListDefaultActionCreator.onLoadingChannels(ids));
  }
}

