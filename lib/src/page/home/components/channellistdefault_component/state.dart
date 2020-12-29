import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:Cruise/src/page/home/components/homelist_component/state.dart';
import 'package:Cruise/src/page/home/components/homelistdefault_component/state.dart';
import 'package:Cruise/src/page/user/settings/cruisesetting/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ChannelListDefaultState implements Cloneable<ChannelListDefaultState> {
  ArticleRequest articleRequest = new ArticleRequest(
      pageNum: 1, pageSize: 15, storiesType: StoriesType.channels);

  @override
  ChannelListDefaultState clone() {
    return ChannelListDefaultState()..articleRequest = this.articleRequest;
  }
}

class ChannelListDefaultConnector
    extends ConnOp<HomeListState, ChannelListDefaultState> {
  @override
  ChannelListDefaultState get(HomeListState state) {
    ChannelListDefaultState substate = new ChannelListDefaultState();
    return substate;
  }


}
