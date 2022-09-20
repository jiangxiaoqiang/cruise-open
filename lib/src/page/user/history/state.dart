import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:fish_redux/fish_redux.dart';

class HistoryState implements Cloneable<HistoryState> {
  StoriesType currentStoriesType = StoriesType.historyStories;

  @override
  HistoryState clone() {
    return HistoryState()..currentStoriesType = this.currentStoriesType;
  }
}

HistoryState initState(Map<String, dynamic>? args) {
  return HistoryState();
}
