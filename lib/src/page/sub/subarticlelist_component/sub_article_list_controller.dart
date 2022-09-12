import 'package:get/get.dart';

import '../../../models/Item.dart';

class SubArticleListController extends GetxController {
  RxList<Item> articles = List<Item>.empty(growable: true).obs;
  var article = (new Item()).obs;
  var channelId = 0.obs;
  var loadingStatus = LoadingStatus.loading.obs;

  void removeArticles(String channelId) {
    articles.value.removeWhere((element) => element.subSourceId == channelId);
    update();
  }
}
