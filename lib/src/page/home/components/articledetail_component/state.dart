import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/page/home/components/articlepg_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

class ArticleDetailState implements Cloneable<ArticleDetailState> {

  Item article;

  @override
  ArticleDetailState clone() {
    return ArticleDetailState()
    ..article = this.article;
  }
}

class ArticleDetailConnector extends ConnOp<ArticlePgState, ArticleDetailState> {
  @override
  ArticleDetailState get(ArticlePgState state) {
    ArticleDetailState articlePageState = state.articleDetailState.clone();
    articlePageState.article = state.article;
    return articlePageState;
  }

  @override
  void set(ArticlePgState state, ArticleDetailState subState) {
    state.articleDetailState = subState;
  }
}

