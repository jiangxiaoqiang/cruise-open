import 'package:get/get.dart';

import '../../../models/Item.dart';

class ChannelArticleListController extends GetxController {
  List<ArticleItem> subArticles = List<ArticleItem>.empty(growable: true);
  var article = (new ArticleItem()).obs;
  var channelId = 0.obs;
  var loadingStatus = LoadingStatus.loading.obs;

  void removeArticlesById(String articleId) {
    subArticles.removeWhere((element) => element.id == articleId);
    update();
  }
}
