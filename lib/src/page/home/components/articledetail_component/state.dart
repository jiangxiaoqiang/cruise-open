import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/page/home/components/articlepg_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ArticleDetailState implements Cloneable<ArticleDetailState> {
  late Item article;

  @override
  ArticleDetailState clone() {
    return ArticleDetailState()..article = this.article;
  }
}

class ArticleDetailConnector
    extends ConnOp<ArticlePgState, ArticleDetailState> {
  @override
  ArticleDetailState get(ArticlePgState state) {
    ArticleDetailState articleDetailState = state.articleDetailState.clone();
    articleDetailState.article = state.article;
    return articleDetailState;
  }

  @override
  void set(ArticlePgState state, ArticleDetailState subState) {
    state.articleDetailState = subState;
  }
}
