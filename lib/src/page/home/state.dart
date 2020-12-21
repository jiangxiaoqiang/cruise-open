import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class HomeState implements Cloneable<HomeState> {

  int selectIndex = 0;

  StoriesType storiesType = StoriesType.topStories;

  HomeListState homeListState;

  @override
  HomeState clone() {
    return HomeState()
      ..selectIndex = this.selectIndex
      ..storiesType = this.storiesType;
  }
}

HomeState initState(Map<String, dynamic> args) {
  return HomeState()
    ..selectIndex = 0
    ..homeListState = HomeListState()
    ..storiesType = StoriesType.topStories;
}
