import 'package:get/get.dart';

import '../../../models/Item.dart';

class SubArticleListController extends GetxController {
  List<ArticleItem> subArticles = List<ArticleItem>.empty(growable: true);
  var article = (new ArticleItem()).obs;
  var channelId = 0.obs;
  var loadingStatus = LoadingStatus.loading.obs;

  void removeArticles(String channelId) {
    subArticles.removeWhere((element) => element.subSourceId == channelId);
    update();
  }

  void removeArticlesById(String articleId) {
    subArticles.removeWhere((element) => element.id == articleId);
    update();
  }
}
