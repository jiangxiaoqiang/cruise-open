import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../models/Item.dart';
import '../../../models/enumn/stories_type.dart';
import '../channellist_component/channel_list.dart';
import '../channellist_component/channel_list_controller.dart';
import 'channel_list_default_controller.dart';

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

ScrollController scrollController = ScrollController();

class ChannelListDefault extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChannelListDefaultController>(
        init: ChannelListDefaultController(),
        builder: (controller) {
          RefreshController _refreshController = RefreshController(initialRefresh: false);

          StoriesType storiesType = StoriesType.channels;
          if (controller.isScrollTop) {
            if (scrollController.hasClients) {
              scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
            }
          }

          Widget navChannelPage() {
            final ChannelListController channelListController = Get.put(ChannelListController());
            channelListController.channels.value = controller.channels;
            return new ChannelList();
          }

          void _autoPreloadMoreChannels(ScrollNotification notification) {
            if (notification is ScrollUpdateNotification) {
              ScrollMetrics metrics = notification.metrics;
              double buttonDistance = metrics.extentAfter;
              if (buttonDistance < 800 && !isDispatched) {
                isDispatched = true;
                controller.loadingMoreChannel(_refreshController);
              }
              if (buttonDistance > 800) {
                isDispatched = false;
              }
            }
          }

          Future<void> _loadingMoreChannel() async {
            controller.loadingMoreChannel(_refreshController);
          }

          return Scaffold(
            body: SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (context) {
                  if (controller.channels.length == 0) {
                    if (controller.channelLoadingStatus == LoadingStatus.complete) {
                      // when the channel not fetched, show loading animation
                      return Center(child: Text("无内容"));
                    } else if (controller.channelLoadingStatus == LoadingStatus.loading) {
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
                        if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                          _onScroll(scrollNotification.metrics.pixels);
                        }

                        _autoPreloadMoreChannels(scrollNotification);
                        return true;
                      },
                      child: CupertinoScrollbar(
                          controller: scrollController,
                          child: SmartRefresher(
                              onRefresh: () {
                                _refreshController.refreshCompleted();
                              },
                              enablePullUp: true,
                              enablePullDown: true,
                              header: WaterDropMaterialHeader(),
                              controller: _refreshController,
                              onLoading: _loadingMoreChannel,
                              footer: CustomFooter(
                                builder: (BuildContext context, LoadStatus? mode) {
                                  Widget? body;
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
                                controller: scrollController,
                                key: PageStorageKey(storiesType),
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                                      context,
                                    ),
                                  ),
                                  if (controller.channels.length > 0)
                                    SliverPadding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      sliver: navChannelPage(),
                                    )
                                ],
                              ))));
                },
              ),
            ),
          );
        });
  }
}
