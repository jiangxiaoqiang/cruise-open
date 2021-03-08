import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/common/article_action.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<ChannelDetailState> buildEffect() {
  return combineEffects(<Object, Effect<ChannelDetailState>>{
    Lifecycle.initState: _onInit,
  });
}

Future _onInit(Action action, Context<ChannelDetailState> ctx) async {
  ChannelDetailState channelDetailState = ctx.state;
  String channelId = channelDetailState.channel!.id;
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 15, pageNum: 1, storiesType: StoriesType.originalStories, channelId: int.parse(channelId));
  List<int> ids = (await Repo.getElementIds(articleRequest))!;
  if (ids == null) {
    ctx.dispatch(ChannelDetailActionCreator.onFetchChannelArticleUpdate(null));
    return;
  }
  List<Item> articles = await ArticleAction.fetchArticleByIds(ids);
  if (articles == null) {
    ctx.dispatch(ChannelDetailActionCreator.onFetchChannelArticleUpdate(null));
    return;
  }
  ctx.dispatch(ChannelDetailActionCreator.onFetchChannelArticleUpdate(articles));
}
