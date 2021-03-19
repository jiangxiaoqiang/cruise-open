import 'package:cruise/src/models/Item.dart';
import 'package:cruise/src/models/request/article/article_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:cruise/src/component/loading_item.dart';
import 'package:cruise/src/component/story_list.dart';
import 'package:cruise/src/common/repo.dart';

/*final storiesTypeProvider = FutureProvider.family((ref, type) async {
  return await Repo.getArticles(type);
});

final storyProvider = FutureProvider.family((ref, id) async {
  return await Repo.fetchArticleItem(id);
});*/


class ArticlesPage extends HookWidget {
  ArticlesPage({
    Key? key,
     this.articleRequest,
     this.ids,
  }) : super(key: key);

  final ArticleRequest? articleRequest;
  List<int>? ids;

  @override
  Widget build(BuildContext context) {

    if(ids != null){

    }

    return StoryList(
      //articles: articles,
      storiesType: articleRequest!.storiesType, articles: [],
    );
  }
}
