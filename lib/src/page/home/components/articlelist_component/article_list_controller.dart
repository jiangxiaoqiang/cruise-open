import 'package:get/get.dart';

import '../../../../models/Item.dart';

class ArticleListController extends GetxController {
  var articles = List.empty().obs;
  Item? article;
  int? channelId;
  LoadingStatus loadingStatus = LoadingStatus.loading;
}
