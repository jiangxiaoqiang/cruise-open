import 'package:get/get.dart';

import '../../../models/Item.dart';

class SubArticleListController extends GetxController {
  var articles = List.empty(growable: true);
  var article = (new Item()).obs;
  var channelId = 0.obs;
  var loadingStatus = LoadingStatus.loading.obs;
}
