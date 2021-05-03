import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
import 'package:cruise/src/page/channel/add_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeList extends HookWidget {
  HomeList({
    Key? key,
    required this.currentStoriesType,
  }) : super(key: key);

  final StoriesType currentStoriesType;

  final List tabs = [
    //IconTab(name: "Top", icon: Feather.trending_up),
  ];

  @override
  Widget build(BuildContext context) {
    ArticleRequest articleRequest = new ArticleRequest(pageNum: 1,storiesType: StoriesType.topStories);
    articleRequest.storiesType = StoriesType.topStories;
    var counter = useState<ArticleRequest>(articleRequest);
    counter.value = articleRequest;

    return DefaultTabController(
      length: tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: SliverAppBar(
                  title: Text(
                    'Cruise',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 10.0,
                  floating: true,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                  actions: [
                    if(currentStoriesType == StoriesType.channels)
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddChannel()),
                        ),
                        icon: Icon(Feather.plus),
                      ),
                  ],
                )),
          ];
        },
        body: TabBarView(
          children: [
           ],
        ),
      ),
    );
  }
}
