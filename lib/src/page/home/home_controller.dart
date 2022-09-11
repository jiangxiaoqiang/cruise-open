import 'package:get/get.dart';

import '../../models/enumn/stories_type.dart';

class HomeController extends GetxController {
  int selectIndex = 0;
  bool autoTriggerNav = false;
  StoriesType storiesType = StoriesType.topStories;
}
