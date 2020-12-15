import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Cruise/src/component/comment_list.dart';
import 'package:Cruise/src/component/story_information.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/common/Repo.dart';

class StoryPage extends HookWidget {
  StoryPage({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;
  final bool toTop = false;
  final String percent = "0%";

  final ScrollController scrollController = new ScrollController();

  void initState() {
    scrollController.addListener(() {
      //打印监听位置
      print(scrollController.offset);
      if (scrollController.offset < 1000 && toTop) {
      } else if (scrollController.offset >= 1000 && toTop == false) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    var percent = useState<String>("0");
    useEffect(() => initState, const []);

    return Scaffold(
        appBar: AppBar(
          title: Text('Cruise'),
          actions: [
            if (item.parent != null)
              IconButton(
                icon: Icon(Feather.corner_left_up),
                onPressed: () async {
                  Item parent = await Repo.fetchArticleItem(item.parent);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StoryPage(item: parent)),
                  );
                },
              ),
          ],
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {
            double progress = sn.metrics.pixels / sn.metrics.maxScrollExtent;
            percent.value = "${(progress * 100).toInt()}%";
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: StoryInformation(item: item)),
              CommentList(item: item)
            ],
          ),
        ));
  }
}
