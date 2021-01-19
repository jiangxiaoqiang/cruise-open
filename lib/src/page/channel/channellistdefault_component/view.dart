import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

const APPBAR_SCROLL_OFFSET = 100;
double appBarAlpha = 0;
bool isDispatched = false;

void _onScroll(offset) {
  double alpha = offset / APPBAR_SCROLL_OFFSET;
  if (alpha < 0) {
    alpha = 0;
  } else if (alpha > 1) {
    alpha = 1;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }
  appBarAlpha = alpha;
}

RefreshController _refreshController = RefreshController(initialRefresh: false);

Widget buildView(ChannelListDefaultState state, Dispatch dispatch, ViewService viewService) {
  ArticleRequest articleRequest = state.articleRequest;
  articleRequest.storiesType = StoriesType.topStories;
  StoriesType storiesType = StoriesType.channels;

  Widget navChannelPage() {
    return viewService.buildComponent("channellist");
  }

  void _loadingMoreChannel() {
    dispatch(ChannelListDefaultActionCreator.onLoadingMoreChannels(articleRequest));
    _refreshController.loadComplete();
  }

  void _autoPreloadMoreChannels(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      ScrollMetrics metrics = notification.metrics;
      double buttonDistance = metrics.extentAfter;
      if (buttonDistance < 800 && !isDispatched) {
        isDispatched = true;
        _loadingMoreChannel();
      }
      if (buttonDistance > 800) {
        isDispatched = false;
      }
    }
  }

  return Scaffold(
    body: SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) {
          return NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
                _autoPreloadMoreChannels(scrollNotification);
                return true;
              },
              child: SmartRefresher(
                  onRefresh: () {
                    _refreshController.refreshCompleted();
                  },
                  enablePullUp: true,
                  enablePullDown: true,
                  controller: _refreshController,
                  onLoading: _loadingMoreChannel,
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
                    key: PageStorageKey(storiesType),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                      ),
                      if (state.channelListState.channelIds != null && state.channelListState.channelIds.length > 0)
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          sliver: navChannelPage(),
                        )
                    ],
                  )));
        },
      ),
    ),
  );
}
