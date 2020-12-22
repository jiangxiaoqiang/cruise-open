import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../stories_page.dart';
import 'action.dart';
import 'state.dart';

const APPBAR_SCROLL_OFFSET = 100;
double appBarAlpha = 0;
RefreshController _refreshController = RefreshController(initialRefresh: false);

void _onScroll(offset) {
  double alpha = offset / APPBAR_SCROLL_OFFSET;
  if (alpha < 0) {
    alpha = 0;
  } else if (alpha > 1) {
    alpha = 1;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }
  appBarAlpha = alpha;
  print(alpha);
}


Widget buildView(
    HomeListDefaultState state, Dispatch dispatch, ViewService viewService) {

  ArticleRequest articleRequest = new ArticleRequest();
  articleRequest.storiesType = StoriesType.topStories;

  return Scaffold(
    body: SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) {
          return  NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return true;
              } ,
              child:SmartRefresher(
                  onRefresh: () {
                    Future.delayed(Duration(milliseconds: 1000));
                    articleRequest.latestTime = DateTime.now().millisecondsSinceEpoch;
                    _refreshController.refreshCompleted();
                  },
                  enablePullUp: true,
                  enablePullDown: true,
                  controller: _refreshController,
                  onLoading: () {
                    _refreshController.loadComplete();
                  },
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = Text("pull up load");
                      } else if (mode == LoadStatus.loading) {
                        //body =  CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = Text("Load Failed!Click retry!");
                      } else if (mode == LoadStatus.canLoading) {
                        body = Text("release to load more");
                      } else {
                        body = Text("No more Data");
                      }
                      return Container(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView
                            .sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                      ),
                      SliverPadding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8.0),
                        sliver: ArticlesPage(
                          articleRequest: articleRequest,
                        ),
                      )
                    ],
                  )));
        },
      ),
    ),
  );
}
