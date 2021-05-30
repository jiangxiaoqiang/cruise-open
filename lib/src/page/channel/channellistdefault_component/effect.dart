import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
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
  ArticleRequest articleRequest = new ArticleRequest(
      pageSize: 15, pageNum: 1, storiesType: StoriesType.channels);
  List<Channel> channels = await Repo.getChannels(articleRequest);
  if(channels.length > 0) {
    ctx.dispatch(
        ChannelListDefaultActionCreator.onLoadingMoreChannelsUpdate(channels));
  }
}

Future _onLoadingMoreChannels(
    Action action, Context<ChannelListDefaultState> ctx) async {
  ArticleRequest articleRequest = (action.payload as ArticleRequest);
  articleRequest.pageNum = articleRequest.pageNum + 1;
  ChannelListDefaultState homeListDefaultState = ctx.state;
  if (homeListDefaultState.articleRequest.offset != null &&
      homeListDefaultState.articleRequest.offset! > 0) {
    articleRequest.offset = homeListDefaultState.articleRequest.offset;
  }
  List<Channel> channels = await Repo.getChannels(articleRequest);
  if (channels.length > 0) {
    ctx.dispatch(
        ChannelListDefaultActionCreator.onLoadingMoreChannelsUpdate(channels));
  }
}
