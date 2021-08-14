import 'package:get/get.dart';

class GlobalController extends GetxController {
  bool _showDebug = false;
  bool get showDebug => _showDebug;

  void increment() {
    _showDebug = !_showDebug;
    update();
  }
}