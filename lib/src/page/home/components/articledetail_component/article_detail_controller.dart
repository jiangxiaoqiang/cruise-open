import 'package:get/get.dart';

import '../../../../common/repo.dart';
import '../../../../models/Item.dart';

class ArticleDetailController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> initArticle(int id) async {
    Item? articleWithContent = await Repo.fetchArticleDetail(id);
    if (articleWithContent != null) {
      article.value = articleWithContent;
      update();
    }
  }

  var article = Item().obs;
}
