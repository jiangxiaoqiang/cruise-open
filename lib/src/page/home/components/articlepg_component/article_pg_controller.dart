import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../models/Item.dart';

class ArticlePgController extends GetxController {
  var article = Item();
  Map<String, ScrollController> scrollControllers = new Map();
  bool showToTopBtn = false;
}
