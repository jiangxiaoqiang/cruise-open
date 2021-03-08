import 'package:Cruise/src/common/Repo.dart';
import 'package:Cruise/src/component/comment_list.dart';
import 'package:Cruise/src/component/story_information.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';

class StoryPage extends HookWidget {
  StoryPage({Key? key, required this.item, required this.pageStorageBucket, required this.scrollControllers, required this.scrollController}) : super(key: key);

  final Item item;
  final PageStorageBucket pageStorageBucket;
  ScrollController scrollController;

  final Map<String, ScrollController> scrollControllers;

  @override
  Widget build(BuildContext context) {
    var article = useState<Item>(item);
    var showToTopBtn = useState(false);
    scrollController = scrollControllers[item.id]!;

    scrollController.addListener(() => {
          if (scrollController.offset < 1000) {showToTopBtn.value = false} else if (scrollController.offset >= 1000) {showToTopBtn.value = true}
        });

    return PageStorage(
        bucket: pageStorageBucket,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Cruise'),
            actions: [
              if (item.parent != null)
                IconButton(
                  icon: Icon(Feather.corner_left_up),
                  onPressed: () async {
                    Item parent = (await Repo.fetchArticleItem(item.parent))!;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StoryPage(item: parent, pageStorageBucket: pageStorageBucket, scrollController: scrollController, scrollControllers: scrollControllers,)),
                    );
                  },
                ),
            ],
          ),
          body: NotificationListener<ScrollNotification>(
            child: CustomScrollView(
              key: PageStorageKey(item.id),
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                    child: StoryInformation(
                  item: article.value,
                )),
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
                      scrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
                    }
                  }),
        ));
  }
}
