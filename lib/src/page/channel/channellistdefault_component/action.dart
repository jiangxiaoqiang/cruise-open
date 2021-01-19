import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelListDefaultAction { action, loading_channels, loading_more_channels, loading_more_channels_update }

class ChannelListDefaultActionCreator {
  static Action onAction() {
    return const Action(ChannelListDefaultAction.action);
  }

  static Action onLoadingChannels(List<int> ids) {
    return Action(ChannelListDefaultAction.loading_channels, payload: ids);
  }

  static Action onLoadingMoreChannels(ArticleRequest articleRequest) {
    return Action(ChannelListDefaultAction.loading_more_channels, payload: articleRequest);
  }

  static Action onLoadingMoreChannelsUpdate(List<Channel> channels) {
    return Action(ChannelListDefaultAction.loading_more_channels_update, payload: channels);
  }
}
