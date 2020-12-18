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
  final int percent = 0;

  final ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    //var percent = useState<String>("0");
    var showToTopBtn = useState(false);

    scrollController.addListener(() => {
          if (scrollController.offset < 1000 && toTop)
            {}
          else if (scrollController.offset >= 1000 && toTop == false)
            {showToTopBtn.value = true}
        });

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
          //double progress = sn.metrics.pixels / sn.metrics.maxScrollExtent;
          //percent.value = "${(progress * 100).toInt()}";
        },
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(child: StoryInformation(item: item)),
            CommentList(item: item),
          ],
        ),
      ),
      floatingActionButton: !showToTopBtn.value
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                if (scrollController.hasClients) {
                  scrollController.animateTo(.0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                }
              }),
    );
  }
}
