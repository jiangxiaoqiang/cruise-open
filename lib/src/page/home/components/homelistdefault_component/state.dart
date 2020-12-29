import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:Cruise/src/page/home/components/articlelist_component/state.dart';
import 'package:Cruise/src/page/home/components/homelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class HomeListDefaultState implements Cloneable<HomeListDefaultState> {
  ArticleRequest articleRequest = new ArticleRequest(
    pageSize: 15,
    pageNum: 1,
    storiesType: StoriesType.topStories
  );

  StoriesType currentStoriesType = StoriesType.topStories;
  List<int> articleIds;
  List<Item> articles;

  ArticleListState articleListState = new ArticleListState();

  @override
  HomeListDefaultState clone() {
    return HomeListDefaultState()
      ..currentStoriesType = this.currentStoriesType
      ..articleIds = this.articleIds
      ..articles = this.articles
      ..articleListState = this.articleListState
    ..articleRequest=this.articleRequest;
  }
}

class HomeListDefaultConnector
    extends ConnOp<HomeListState, HomeListDefaultState> {
  @override
  HomeListDefaultState get(HomeListState state) {
    HomeListDefaultState substate = new HomeListDefaultState();
    substate.currentStoriesType = state.currentStoriesType;
    return substate;
  }
}
