import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:fish_redux/fish_redux.dart';

class DiscoverState implements Cloneable<DiscoverState> {
  StoriesType currentStoriesType = StoriesType.originalStories;

  @override
  DiscoverState clone() {
    return DiscoverState()..currentStoriesType = this.currentStoriesType;
  }
}

DiscoverState initState(Map<String, dynamic>? args) {
  return DiscoverState();
}
