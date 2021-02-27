import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/common/article_action.dart';
import 'package:Cruise/src/models/Channel.dart';
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
  String channelId = channelDetailState.channel.id;
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 15, pageNum: 1, storiesType: StoriesType.originalStories, channelId: int.parse(channelId));
  List<int> ids = await Repo.getElementIds(articleRequest);
  if (ids != null) {
    List<Item> articles = await ArticleAction.fetchArticleByIds(ids);
    if (articles != null) {
      ctx.dispatch(ChannelDetailActionCreator.onFetchChannelArticleUpdate(articles));
    }
  }
}

Future _onLoadingMoreChannels(Action action, Context<ChannelDetailState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  articleRequest.pageNum = articleRequest.pageNum + 1;
  ChannelDetailState homeListDefaultState = ctx.state;
  if (homeListDefaultState.articleRequest.offset != null && homeListDefaultState.articleRequest.offset > 0) {
    articleRequest.offset = homeListDefaultState.articleRequest.offset;
  }
  List<int> ids = await Repo.getElementIds(articleRequest);
  List<Channel> channels = [];
  if (ids != null) {
    for (int id in ids) {
      Channel channel = await Repo.fetchChannelItem(id);
      if (channel != null) {
        channels.add(channel);
      }
    }
    //ctx.dispatch(ChannelListDefaultActionCreator.onLoadingMoreChannelsUpdate(channels));
  }
}
