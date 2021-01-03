import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:Cruise/src/page/home/components/homelistdefault_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ArticleListState implements Cloneable<ArticleListState> {
  List<int> articleIds = new List();

  List<Item> articles = new List();

  ArticleRequest articleRequest = new ArticleRequest(
      storiesType: StoriesType.topStories, pageNum: 1, pageSize: 10);

  @override
  ArticleListState clone() {
    return ArticleListState()
      ..articles = this.articles
      ..articleIds = this.articleIds
      ..articleRequest = this.articleRequest;
  }
}

class ArticleListConnector
    extends ConnOp<HomeListDefaultState, ArticleListState> {
  @override
  ArticleListState get(HomeListDefaultState state) {
    ArticleListState articleListState = state.articleListState.clone();
    return articleListState;
  }

  @override
  void set(HomeListDefaultState state, ArticleListState subState) {
    state.articleListState.articles = subState.articles;
  }
}
