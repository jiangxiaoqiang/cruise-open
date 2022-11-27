import 'package:cruise/src/common/repo.dart';
import 'package:cruise/src/page/sub/subarticlelist_component/sub_article_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../models/Item.dart';
import '../../../../models/enumn/stories_type.dart';
import '../../../../models/request/article/article_request.dart';
import '../../../sub/subarticlelist_component/sub_article_list_controller.dart';
import 'home_list_default_controller.dart';

const APPBAR_SCROLL_OFFSET = 100;
double appBarAlpha = 0;
bool isDispatched = false;
ScrollController scrollController = ScrollController();

class HomeListDefault extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeListDefaultController>(
        init: HomeListDefaultController(),
        builder: (controller) {
          RefreshController _refreshController = RefreshController(initialRefresh: false);

          ArticleRequest articleRequest = controller.articleRequest;
          articleRequest.storiesType = controller.currentStoriesType;
          if (controller.isScrollTop.value) {
            controller.isScrollTop.value = false;
            if (scrollController.hasClients) {
              scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
            }
          }

          Future<void> _loadingMoreArticle() async {
            articleRequest.pageNum = articleRequest.pageNum + 1;
            List<ArticleItem> articles = await Repo.getArticles(articleRequest);
            if (articles.isNotEmpty) {
              controller.appendArticles(articles);
            }
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
            controller.loadNewestArticles(_refreshController);
          }

          Widget buildArticleList(List<ArticleItem> articles) {
            final SubArticleListController articleListController = Get.put(SubArticleListController());
            articleListController.subArticles = articles;
            return new SubArticleList();
          }

          return Scaffold(
            body: SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (context) {
                    if (controller.articles.length == 0) {
                      if (controller.articleLoadingStatus == LoadingStatus.complete) {
                        // when the article not fetched, show loading animation
                        return Center(child: Text("无内容"));
                      } else if (controller.articleLoadingStatus == LoadingStatus.loading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
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
                            // https://stackoverflow.com/questions/69853729/flutter-the-scrollbars-scrollcontroller-has-no-scrollposition-attached
                            controller: scrollController,
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
                                  key: PageStorageKey(StoriesType.topStories),
                                  controller: scrollController,
                                  slivers: <Widget>[
                                    SliverOverlapInjector(
                                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                                        context,
                                      ),
                                    ),
                                    if (controller.articles.length > 0)
                                      SliverPadding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        sliver: buildArticleList(controller.articles.values.toList()),
                                      )
                                  ],
                                ))));
                  },
                )),
          );
        });
  }
}
