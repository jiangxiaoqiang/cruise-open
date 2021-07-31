import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/page/home/components/articledetail_component/state.dart';
import 'package:cruise/src/page/home/components/articlelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class ArticlePgState implements Cloneable<ArticlePgState> {
  Item article = Item();
  Map<String, ScrollController> scrollControllers = new Map();
  bool showToTopBtn = false;

  ArticleDetailState articleDetailState = ArticleDetailState();

  @override
  ArticlePgState clone() {
    return ArticlePgState()
      ..showToTopBtn = showToTopBtn
      ..scrollControllers = scrollControllers
      ..article = article
      ..articleDetailState = articleDetailState;
  }
}

class ArticlePgConnector extends ConnOp<ArticleListState, ArticlePgState> {
  @override
  ArticlePgState get(ArticleListState? state) {
    ArticlePgState articlePageState = state!.articlePgState.clone();
    if (state.article != null) {
      articlePageState.article = state.article!;
    }
    return articlePageState;
  }

  @override
  void set(ArticleListState state, ArticlePgState subState) {
    state.articlePgState = subState;
  }
}
