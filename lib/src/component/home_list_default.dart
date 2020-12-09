import 'package:Cruise/src/home/home_new.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:Cruise/src/page/stories_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomeListDefault extends HookWidget{

   HomeListDefault({
    Key key,
    @required this.type,
  }) : super(key: key);

  final StoriesType type;

  final List tabs = [
    IconTab(name: "Top", icon: Feather.trending_up),
    IconTab(name: "Sub", icon: Feather.star),
    IconTab(name: "Channels", icon: Feather.award),
  ];

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

  @override
  Widget build(BuildContext context) {

    ArticleRequest articleRequest = new ArticleRequest();
    articleRequest.storiesType = type;
    var counter = useState<ArticleRequest>();
    counter.value = articleRequest;

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
                  counter.value = articleRequest;
                  _refreshController.refreshCompleted();
                },
                enablePullUp: true,
                enablePullDown: true,
                controller: _refreshController,
                onLoading: () {
                  print("loading");
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
                  key: PageStorageKey(type),
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
                        articleRequest: counter.value,
                      ),
                    )
                  ],
                )));
          },
        ),
      ),
    );
  }

}








