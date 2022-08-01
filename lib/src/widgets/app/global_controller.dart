import 'package:get/get.dart';

class GlobalController extends GetxController {
  bool _showDebug = false;
  bool get showDebug => _showDebug;
  var appBarTitle = "首页".obs;

  void increment() {
    _showDebug = !_showDebug;
    update();
  }
}
