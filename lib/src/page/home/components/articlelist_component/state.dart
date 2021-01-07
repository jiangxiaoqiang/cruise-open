import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:Cruise/src/page/home/components/articlepg_component/state.dart';
import 'package:Cruise/src/page/home/components/homelistdefault_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ArticleListState implements Cloneable<ArticleListState> {
  List<int> articleIds = new List();
  List<Item> articles = new List();
  Item article;
  ArticleRequest articleRequest = new ArticleRequest(
      storiesType: StoriesType.topStories, pageNum: 1, pageSize: 10);
  ArticlePgState articlePgState = ArticlePgState();

  @override
  ArticleListState clone() {
    return ArticleListState()
      ..articles = this.articles
      ..articleIds = this.articleIds
      ..articleRequest = this.articleRequest
      ..articlePgState = this.articlePgState
      ..article = this.article;
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
    state.articleListState = subState;
  }
}
