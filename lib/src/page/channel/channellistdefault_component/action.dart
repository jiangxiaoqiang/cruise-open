import 'package:cruise/src/models/Channel.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
import 'package:cruise/src/page/home/components/homelistdefault_component/action.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ChannelListDefaultAction { action, loading_channels, loading_more_channels, loading_more_channels_update, set_channel_ids, resume_scroll_top }

class ChannelListDefaultActionCreator {
  static Action onAction() {
    return const Action(ChannelListDefaultAction.action);
  }

  static Action onResumeScrollTop() {
    return Action(ChannelListDefaultAction.resume_scroll_top);
  }

  static Action onSetChannelIds(List<int> channelIds, ArticleRequest articleRequest) {
    ArticlePayload articlePayload = new ArticlePayload();
    articlePayload.articleRequest = articleRequest;
    articlePayload.articleIds = channelIds;
    return Action(ChannelListDefaultAction.set_channel_ids, payload: articlePayload);
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
