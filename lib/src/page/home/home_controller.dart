import 'package:get/get.dart';

import '../../models/enumn/stories_type.dart';

class HomeController extends GetxController {
  var selectIndex = 0.obs;
  var autoTriggerNav = false.obs;
  var storiesType = StoriesType.topStories.obs;

  void updateNav(int index, StoriesType storiesType) {
    selectIndex.value = index;
    storiesType = storiesType;
    update();
  }
}
