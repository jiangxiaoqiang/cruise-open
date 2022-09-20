import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:fish_redux/fish_redux.dart';

class FavArticleState implements Cloneable<FavArticleState> {
  StoriesType currentStoriesType = StoriesType.favStories;

  @override
  FavArticleState clone() {
    return FavArticleState()..currentStoriesType = this.currentStoriesType;
  }
}

FavArticleState initState(Map<String, dynamic>? args) {
  return FavArticleState();
}
