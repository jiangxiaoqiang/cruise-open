import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/home_model.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{HomeAction.switchNavSuccess: _onSwitchNavSuccess, HomeAction.scroll_top: _onScrollTop},
  );
}

HomeState _onScrollTop(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState.homeListState.homeListDefaultState.isScrollTop = true;
  return newState;
}

HomeState _onSwitchNavSuccess(HomeState state, Action action) {
  if (action.payload == null) {
    return state;
  }
  final HomeState newState = state.clone();
  newState.storiesType = (action.payload as HomeModel).storiesType!;
  newState.selectIndex = (action.payload as HomeModel).selectIndex!;
  newState.homeListState.currentStoriesType = (action.payload as HomeModel).storiesType!;

  // show loading animation
  // 以下2行代码实现在导航切换时立即改变界面显示加载动画
  // 避免点击导航后等到文章获取到才渲染页面
  // 立即加载动画符合使用预期
  // 每个操作步骤尽量有反馈且立即反馈
  newState.homeListState.homeListDefaultState.articleLoadingStatus = LoadingStatus.loading;
  newState.homeListState.homeListDefaultState.articleListState.articles = List.empty(growable: true);
  return newState;
}
