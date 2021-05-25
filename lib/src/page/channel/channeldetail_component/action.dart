import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelDetailAction {
  action,
  set_channel_id,
  fetch_channel_article_update,
  subscribe,
}

class ChannelDetailActionCreator {
  static Action onAction() {
    return const Action(ChannelDetailAction.action);
  }

  static Action onSetChannelId(String channelId) {
    return Action(ChannelDetailAction.set_channel_id, payload: channelId);
  }

  static Action onFetchChannelArticleUpdate(List<Item>? articles) {
    return Action(ChannelDetailAction.fetch_channel_article_update, payload: articles);
  }

  static Action onSubscribe(Channel channel) {
    return Action(ChannelDetailAction.subscribe, payload: channel);
  }
}
