import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/page/home/components/articlepg_component/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class ArticleDetailState implements Cloneable<ArticleDetailState> {
  Item article = Item();
  ScrollController scrollController = ScrollController();

  @override
  ArticleDetailState clone() {
    return ArticleDetailState()
      ..scrollController = this.scrollController
      ..article = this.article;
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
