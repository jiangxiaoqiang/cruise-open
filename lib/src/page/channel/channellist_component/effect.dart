import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/models/Channel.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ChannelListState> buildEffect() {
  return combineEffects(<Object, Effect<ChannelListState>>{
    Lifecycle.initState: _onInit,
  });
}

Future _onInit(Action action, Context<ChannelListState> ctx) async {
  ChannelListState articleListState = ctx.state;
  List<int> ids = articleListState.channelIds;
  List<Channel> channels = new List();
  for (int id in ids) {
    Channel article = await Repo.fetchChannelItem(id);
    if (article != null) {
      channels.add(article);
    }
  }

  if (channels != null && channels.length > 0) {
    ctx.dispatch(ChannelListActionCreator.onSetChannels(channels));
  }
}

