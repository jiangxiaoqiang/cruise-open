import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class DiscoverState implements Cloneable<DiscoverState> {

  HomeListState homeListState = HomeListState();

  StoriesType currentStoriesType = StoriesType.originalStories;

  @override
  DiscoverState clone() {
    return DiscoverState()
    ..homeListState = this.homeListState
    ..currentStoriesType = this.currentStoriesType;
  }
}

DiscoverState initState(Map<String, dynamic>? args) {
  return DiscoverState();
}
