import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/page/channel/channellistdefault_component/state.dart';
import 'package:cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class HomeState implements Cloneable<HomeState> {
  int selectIndex = 0;
  bool autoTriggerNav = false;
  StoriesType storiesType = StoriesType.topStories;
  HomeListState homeListState = new HomeListState();
  ChannelListDefaultState channelListDefaultState =
      new ChannelListDefaultState();

  @override
  HomeState clone() {
    return HomeState()
      ..selectIndex = this.selectIndex
      ..channelListDefaultState = this.channelListDefaultState
      ..homeListState = this.homeListState
      ..storiesType = this.storiesType
      ..autoTriggerNav = this.autoTriggerNav;
  }
}

HomeState initState(Map<String, dynamic> args) {
  int selectIndex = args["selectIndex"] == null ? 0 : args["selectIndex"];
  StoriesType storiesType = args["storiesType"] == null
      ? StoriesType.topStories
      : args["storiesType"];
  bool autoTriggerNav = args["autoTriggerNav"] == null
      ? false
      : args["autoTriggerNav"];
  return HomeState()
    ..selectIndex = selectIndex
    ..autoTriggerNav = autoTriggerNav
    ..homeListState = HomeListState()
    ..channelListDefaultState = new ChannelListDefaultState()
    ..storiesType = storiesType;
}
