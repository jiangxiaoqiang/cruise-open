import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Cruise/src/component/comment_list.dart';
import 'package:Cruise/src/component/story_information.dart';
import 'package:Cruise/src/models/Item.dart';
import 'package:Cruise/src/common/Repo.dart';

class StoryPage extends HookWidget {
  const StoryPage({
    Key key,
    @required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: StoryInformation(item: item)),
          CommentList(item: item)
        ],
      ),
    );
  }
}
