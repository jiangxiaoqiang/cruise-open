import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class HistoryState implements Cloneable<HistoryState> {

  HomeListState homeListState = HomeListState();
  StoriesType currentStoriesType = StoriesType.historyStories;

  @override
  HistoryState clone() {
    return HistoryState()
    ..currentStoriesType = this.currentStoriesType
    ..homeListState = this.homeListState;
  }
}

HistoryState initState(Map<String, dynamic>? args) {
  return HistoryState();
}
