import 'package:get/get.dart';

import '../../../../models/enumn/stories_type.dart';

class HomeListController extends GetxController {
  var currentStoriesType = StoriesType.topStories.obs;

  void updateStories(StoriesType storiesType) {
    currentStoriesType.value = storiesType;
    update();
  }
}
