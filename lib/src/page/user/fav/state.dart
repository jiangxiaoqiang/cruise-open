import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class FavArticleState implements Cloneable<FavArticleState> {

  HomeListState homeListState = HomeListState();
  StoriesType currentStoriesType = StoriesType.favStories;

  @override
  FavArticleState clone() {
    return FavArticleState()
    ..homeListState = this.homeListState
    ..currentStoriesType = this.currentStoriesType;
  }
}

FavArticleState initState(Map<String, dynamic> args) {
  return FavArticleState();
}
