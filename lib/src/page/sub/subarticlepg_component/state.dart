import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/page/sub/subarticledetail_component/state.dart';
import 'package:cruise/src/page/sub/subarticlelist_component/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class SubArticlePgState implements Cloneable<SubArticlePgState> {
  Item article = Item();
  Map<String, ScrollController> scrollControllers = new Map();
  bool showToTopBtn = false;

  SubArticleDetailState subArticleDetailState = SubArticleDetailState();

  @override
  SubArticlePgState clone() {
    return SubArticlePgState()
      ..showToTopBtn = showToTopBtn
      ..scrollControllers = scrollControllers
      ..article = article
      ..subArticleDetailState = subArticleDetailState;
  }
}

class SubArticlePgConnector extends ConnOp<SubArticleListState, SubArticlePgState> {
  @override
  SubArticlePgState get(SubArticleListState state) {
    SubArticlePgState articlePageState = state.subArticlePgState.clone();
    if (state.article != null) {
      articlePageState.article = state.article!;
    }
    return articlePageState;
  }

  @override
  void set(SubArticleListState state, SubArticlePgState subState) {
    state.subArticlePgState = subState;
  }
}
