import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<ChannelListDefaultState> buildEffect() {
  return combineEffects(<Object, Effect<ChannelListDefaultState>>{
    Lifecycle.initState: _onInit,
    ChannelListDefaultAction.loading_more_channels: _onLoadingMoreChannels,
  });
}

Future _onInit(Action action, Context<ChannelListDefaultState> ctx) async {
  ArticleRequest articleRequest = new ArticleRequest(pageSize: 15, pageNum: 1, storiesType: StoriesType.channels);
  List<int> ids = (await Repo.getElementIds(articleRequest))!;
  if (ids != null) {
    ctx.dispatch(ChannelListDefaultActionCreator.onSetChannelIds(ids, articleRequest));
  }
}

Future _onLoadingMoreChannels(Action action, Context<ChannelListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  articleRequest.pageNum = articleRequest.pageNum + 1;
  ChannelListDefaultState homeListDefaultState = ctx.state;
  if (homeListDefaultState.articleRequest.offset != null && homeListDefaultState.articleRequest.offset! > 0) {
    articleRequest.offset = homeListDefaultState.articleRequest.offset;
  }
  List<int> ids = (await Repo.getElementIds(articleRequest))!;
  List<Channel> channels = [];
  if (ids != null) {
    for (int id in ids) {
      Channel channel = (await Repo.fetchChannelItem(id))!;
      if (channel != null) {
        channels.add(channel);
      }
    }
    ctx.dispatch(ChannelListDefaultActionCreator.onLoadingMoreChannelsUpdate(channels));
  }
}
