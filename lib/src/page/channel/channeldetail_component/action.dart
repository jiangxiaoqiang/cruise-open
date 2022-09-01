import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart' as FGet;
import 'package:get/get.dart';

import '../../../models/api/sub_status.dart';
import '../../sub/subarticlelist_component/sub_article_list_controller.dart';

//TODO replace with your own action
enum ChannelDetailAction {
  action,
  set_channel_id,
  fetch_channel_article_update,
  subscribe,
}

class ChannelDetailActionCreator {
  static FGet.Action onAction() {
    return const FGet.Action(ChannelDetailAction.action);
  }

  static FGet.Action onSetChannelId(String channelId) {
    return FGet.Action(ChannelDetailAction.set_channel_id, payload: channelId);
  }

  static FGet.Action onFetchChannelArticleUpdate(List<Item>? articles) {
    return FGet.Action(ChannelDetailAction.fetch_channel_article_update, payload: articles);
  }

  static FGet.Action onSubscribe(Channel channel, SubStatus subStatus) {
    if (subStatus.statusCode != "unsub") {
      final SubArticleListController articleListController = Get.put(SubArticleListController());
      articleListController.articles.removeWhere((element) => element.id == channel.id);
    }
    return FGet.Action(ChannelDetailAction.subscribe, payload: channel);
  }
}
