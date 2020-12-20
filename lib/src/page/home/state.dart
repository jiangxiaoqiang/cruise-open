import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

class HomeState implements Cloneable<HomeState> {

  int selectIndex = 0;

  StoriesType storiesType = StoriesType.topStories;

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
    ..storiesType = StoriesType.topStories;
}
