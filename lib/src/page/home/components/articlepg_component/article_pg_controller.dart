import 'package:get/get.dart';

import '../../../../common/repo.dart';
import '../../../../models/Item.dart';

class ArticlePgController extends GetxController {
  var article = Item();
  bool showToTopBtn = false;
  bool run = false;
  String loadResult = "加载中...";

  Future<String> initArticle(int id) async {
    if (!run) {
      // https://stackoverflow.com/questions/74194103/how-to-avoid-the-flutter-request-server-flood
      run = true;
      try {
        Item? articleWithContent = await Repo.fetchArticleDetail(id);
        run = false;
        if (articleWithContent != null) {
          article = articleWithContent;
          return articleWithContent.id;
        }
        update();
      } catch (e) {
        run = false;
        print("fetch article failed:" + id.toString());
        loadResult = e.toString();
        return "-1";
      }
    }
    return Future.value(new Item().id);
  }
}
