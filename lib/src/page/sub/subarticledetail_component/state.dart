import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/page/sub/subarticlepg_component/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class SubArticleDetailState implements Cloneable<SubArticleDetailState> {
  Item article = Item();
  ScrollController scrollController = ScrollController();

  @override
  SubArticleDetailState clone() {
    return SubArticleDetailState()
      ..scrollController = this.scrollController
      ..article = this.article;
  }
}

class SubArticleDetailConnector
    extends ConnOp<SubArticlePgState, SubArticleDetailState> {
  @override
  SubArticleDetailState get(SubArticlePgState state) {
    SubArticleDetailState articleDetailState = state.subArticleDetailState.clone();
    articleDetailState.article = state.article;
    return articleDetailState;
  }

  @override
  void set(SubArticlePgState state, SubArticleDetailState subState) {
    state.subArticleDetailState = subState;
  }
}
