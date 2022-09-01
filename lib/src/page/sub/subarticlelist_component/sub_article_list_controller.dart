import 'package:get/get.dart';

import '../../../models/Item.dart';

class SubArticleListController extends GetxController {
  List<Item> articles = List.empty(growable: true);
  var article = (new Item()).obs;
  var channelId = 0.obs;
  var loadingStatus = LoadingStatus.loading.obs;

  void removeArticles(String channelId) {
    articles.removeWhere((element) => element.subSourceId == channelId);
    update();
  }
}
