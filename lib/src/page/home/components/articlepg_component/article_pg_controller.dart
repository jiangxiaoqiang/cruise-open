import 'package:get/get.dart';

import '../../../../common/repo.dart';
import '../../../../models/Item.dart';

class ArticlePgController extends GetxController {
  var article = Item();

  //ScrollController articlePgscrollController = new ScrollController();
  bool showToTopBtn = false;
  bool run = false;

  Future<String> initArticle(int id) async {
    /*return await this._memoization.runOnce(() async {
      Item? articleWithContent = await Repo.fetchArticleDetail(id);
      if (articleWithContent != null) {
        article = articleWithContent;
        return articleWithContent.id;
      }
      return "0";
    });*/
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
        return "-1";
      }
    }
    return Future.value(new Item().id);
  }
}
