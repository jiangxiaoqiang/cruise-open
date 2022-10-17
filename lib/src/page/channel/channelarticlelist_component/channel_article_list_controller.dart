import 'package:get/get.dart';

import '../../../models/Item.dart';

class ChannelArticleListController extends GetxController {
  List<Item> subArticles = List<Item>.empty(growable: true);
  var article = (new Item()).obs;
  var channelId = 0.obs;
  var loadingStatus = LoadingStatus.loading.obs;

  void removeArticlesById(String articleId) {
    subArticles.removeWhere((element) => element.id == articleId);
    update();
  }
}
