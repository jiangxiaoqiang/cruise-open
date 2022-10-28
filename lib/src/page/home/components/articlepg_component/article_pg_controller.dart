import 'package:get/get.dart';
import 'package:synchronized/synchronized.dart';

import '../../../../common/repo.dart';
import '../../../../models/Item.dart';

class ArticlePgController extends GetxController {
  var article = Item();
  bool showToTopBtn = false;
  var lock = new Lock();

  Future<String> initArticle(int id) async {
    return await lock.synchronized(() async {
      // Only this block can run (once) until done
      // https://stackoverflow.com/questions/74194103/how-to-avoid-the-flutter-request-server-flood
      Item articleWithContent = await Repo.fetchArticleDetail(id);
      article = articleWithContent;
      return articleWithContent.id;
    });
  }
}
