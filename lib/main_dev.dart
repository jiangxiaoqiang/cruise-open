// @dart=2.12
import 'package:cruise/src/common/config/cruise_global_config.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wheel/wheel.dart';

void main() async {
  CommonUtils.initialApp(ConfigType.DEV);
  GlobalConfiguration().loadFromAsset("dev_app_settings").whenComplete(() => {
    CruiseGlobalConfig.loadApp()
  });
}
