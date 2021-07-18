import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/enumn/stories_type.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

const APPBAR_SCROLL_OFFSET = 100;
double appBarAlpha = 0;
bool isDispatched = false;
RefreshController _refreshController = RefreshController(initialRefresh: false);
ScrollController scrollController = ScrollController();

Widget buildView(SubListDefaultState state, Dispatch dispatch, ViewService viewService) {
  ArticleRequest articleRequest = state.articleRequest;
  articleRequest.storiesType = state.currentStoriesType;
  if (state.isScrollTop) {
    dispatch(SubHomeListDefaultActionCreator.onResumeScrollTop());
    if(scrollController.hasClients) {
      scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
    }
  }

  void _loadingMoreArticle() {
    dispatch(SubHomeListDefaultActionCreator.onLoadingMoreArticles(articleRequest));
    _refreshController.loadComplete();
  }

  void autoPreloadMoreArticles(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      ScrollMetrics metrics = notification.metrics;
      double buttonDistance = metrics.extentAfter;
      if (buttonDistance < 800 && !isDispatched) {
        isDispatched = true;
        _loadingMoreArticle();
      }
      if (buttonDistance > 800) {
        isDispatched = false;
      }
    }
  }

  void _onRefreshLoadingNewestArticle() async {
    var fetchNewestReq = new ArticleRequest(offset: null, pageSize: 10, pageNum: 1, storiesType: state.currentStoriesType);
    dispatch(SubHomeListDefaultActionCreator.onFetchNewestArticles(fetchNewestReq));
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  return Scaffold(
    body: SafeArea(
        top: false,
        bottom: false,
        child: Builder(
          builder: (context) {
            if (state.subArticleListState.articles.length == 0) {
              if(state.articleLoadingStatus == LoadingStatus.complete) {
                // when the article not fetched, show loading animation
                return Center(child: Text("无内容"));
              }else if(state.articleLoadingStatus == LoadingStatus.loading){
                return Center(child: CircularProgressIndicator());
              }else{
                return Center(child: Text("无内容"));
              }
            }

            return NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is! ScrollNotification) {
                    return false;
                  }
                  autoPreloadMoreArticles(scrollNotification);
                  return true;
                },
                child: CupertinoScrollbar(
                    child: SmartRefresher(
                        onRefresh: _onRefreshLoadingNewestArticle,
                        enablePullUp: true,
                        enablePullDown: true,
                        header: WaterDropMaterialHeader(),
                        controller: _refreshController,
                        onLoading: _loadingMoreArticle,
                        footer: CustomFooter(
                          builder: (BuildContext context, LoadStatus? mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = Text("上拉加载更多");
                            } else if (mode == LoadStatus.loading) {
                              body = CupertinoActivityIndicator();
                            } else if (mode == LoadStatus.failed) {
                              body = Text("加载失败!点击重试!");
                            } else if (mode == LoadStatus.canLoading) {
                              body = Text("放开加载更多");
                            } else {
                              body = Text("无更多数据");
                            }
                            return Container(
                              height: 55.0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        child: CustomScrollView(
                          key: PageStorageKey(StoriesType.subStories),
                          controller: scrollController,
                          slivers: <Widget>[
                            SliverOverlapInjector(
                              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                                context,
                              ),
                            ),
                            if (state.subArticleListState.articles.length > 0)
                              SliverPadding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                sliver: viewService.buildComponent("articlelist"),
                              )
                          ],
                        ))));
          },
        )),
  );
}
