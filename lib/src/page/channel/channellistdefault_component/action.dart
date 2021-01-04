import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelListDefaultAction { action, loading_channels }

class ChannelListDefaultActionCreator {
  static Action onAction() {
    return const Action(ChannelListDefaultAction.action);
  }

  static Action onLoadingChannels(ArticleRequest request) {
    return Action(ChannelListDefaultAction.loading_channels,payload: request);
  }
}
