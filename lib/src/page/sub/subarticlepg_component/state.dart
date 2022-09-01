import 'package:cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class SubArticlePgState implements Cloneable<SubArticlePgState> {
  Item article = Item();
  Map<String, ScrollController> scrollControllers = new Map();
  bool showToTopBtn = false;

  @override
  SubArticlePgState clone() {
    return SubArticlePgState()
      ..showToTopBtn = showToTopBtn
      ..scrollControllers = scrollControllers
      ..article = article;
  }
}
