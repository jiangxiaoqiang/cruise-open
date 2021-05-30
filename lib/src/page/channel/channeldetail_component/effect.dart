import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
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
  String channelId = channelDetailState.channel.id;
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 15, pageNum: 1, storiesType: StoriesType.channelStories, channelId: int.parse(channelId));
  List<Item> articles = await Repo.getArticles(articleRequest);
  ctx.dispatch(ChannelDetailActionCreator.onFetchChannelArticleUpdate(articles));
}
