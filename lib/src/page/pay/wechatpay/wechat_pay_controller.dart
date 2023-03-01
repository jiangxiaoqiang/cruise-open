import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:get/get.dart';
import 'package:wheel/wheel.dart';

class WechatPayController extends GetxController {
  bool _showDebug = false;

  bool get showDebug => _showDebug;

  @override
  void onInit() {
    super.onInit();
    initWechatPay();
  }

  void increment() {
    _showDebug = !_showDebug;
    update();
  }

  void initWechatPay() async {
    String appId = GlobalConfig.getConfig("wechatAppId");
    await fluwx.registerWxApi(appId: appId, doOnAndroid: true, doOnIOS: true);
  }
}
