import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synchronized/synchronized.dart';

import '../../../../common/repo.dart';
import '../../../../models/Item.dart';
import 'article_pg.dart';

class ArticlePgController extends GetxController {
  var article = ArticleItem();
  bool showToTopBtn = false;
  var lock = new Lock();

  Future<String> initArticle(int id) async {
    return await lock.synchronized(() async {
      // Only this block can run (once) until done
      // https://stackoverflow.com/questions/74194103/how-to-avoid-the-flutter-request-server-flood
      ArticleItem articleWithContent = await Repo.fetchArticleDetail(id);
      article = articleWithContent;
      return articleWithContent.id;
    });
  }

  Widget buildArticlePage(ArticleItem item) {
    return FutureBuilder<String>(
        future: initArticle(int.parse(item.id)),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && int.parse(snapshot.data) > 0) {
            // https://stackoverflow.com/questions/74198771/is-it-possible-to-keep-the-page-scroll-position-when-using-futurebuilder-and-get
            return new ArticlePg();
          } else {
            return Scaffold(
                appBar: AppBar(leading: const BackButton(key: ValueKey<String>('back'))),
                body: SafeArea(child: Center(child: CircularProgressIndicator())));
          }
        });
  }
}
