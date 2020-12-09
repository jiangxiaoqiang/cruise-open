import 'package:Cruise/src/home/home_new.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/models/request/article/article_request.dart';
import 'package:Cruise/src/page/channels_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ChannelListDefault extends HookWidget{

  ChannelListDefault({
    Key key,
    @required this.storiesType,
  }) : super(key: key);

  final StoriesType storiesType;

  final List tabs = [
    IconTab(name: "Channels", icon: Feather.award),
    //IconTab(name: "Show", icon: Feather.eye),
  ];

  @override
  Widget build(BuildContext context) {

    ArticleRequest articleRequest = new ArticleRequest();
    articleRequest.storiesType = storiesType;
    var counter = useState<ArticleRequest>(articleRequest);

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Builder(
          builder: (context) {
            return CustomScrollView(
                  key: PageStorageKey(storiesType),
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
                      sliver: ChannelsPage(
                        type: counter.value,
                      ),
                    )
                  ],
                );
          },
        ),
      ),
    );
  }

}








