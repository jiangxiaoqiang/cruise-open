import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/page/home/components/articledetail_component/state.dart';
import 'package:Cruise/src/page/home/components/articlelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class ArticlePgState implements Cloneable<ArticlePgState> {
  Item article = new Item();
  PageStorageBucket pageStorageBucket = PageStorageBucket();
  Map<String, ScrollController> scrollControllers = new Map();
  bool showToTopBtn = false;

  ArticleDetailState articleDetailState = ArticleDetailState();

  @override
  ArticlePgState clone() {
    return ArticlePgState()
      ..showToTopBtn = showToTopBtn
      ..scrollControllers = scrollControllers
      ..pageStorageBucket = pageStorageBucket
      ..article = article
      ..articleDetailState = articleDetailState;
  }
}

class ArticlePgConnector extends ConnOp<ArticleListState, ArticlePgState> {
  @override
  ArticlePgState get(ArticleListState state) {
    ArticlePgState articlePageState = state.articlePgState.clone();
    articlePageState.article = new Item();
    return articlePageState;
  }

  @override
  void set(ArticleListState state, ArticlePgState subState) {
    state.articlePgState = subState;
  }
}
