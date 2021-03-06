import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/page/channel/channellistdefault_component/state.dart';
import 'package:Cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class HomeState implements Cloneable<HomeState> {
  int selectIndex = 0;
  StoriesType storiesType = StoriesType.topStories;
  HomeListState homeListState = new HomeListState();
  ChannelListDefaultState channelListDefaultState = new ChannelListDefaultState();

  @override
  HomeState clone() {
    return HomeState()
      ..selectIndex = this.selectIndex
      ..channelListDefaultState = this.channelListDefaultState
      ..homeListState = this.homeListState
      ..storiesType = this.storiesType;
  }
}

HomeState initState(Map<String, dynamic> args) {
  return HomeState()
    ..selectIndex = 0
    ..homeListState = HomeListState()
    ..channelListDefaultState = new ChannelListDefaultState()
    ..storiesType = StoriesType.topStories;
}
