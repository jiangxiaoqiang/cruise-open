import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

class HomeListState implements Cloneable<HomeListState> {

  StoriesType currentStoriesType;

  @override
  HomeListState clone() {
    return HomeListState();
  }
}

HomeListState initState(Map<String, dynamic> args) {
  return HomeListState();
}
