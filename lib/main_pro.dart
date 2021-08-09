import 'package:cruise/src/common/config/cruise_global_config.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:wheel/wheel.dart';

void main() async {
  CommonUtils.initialApp(ConfigType.DEV);
  GlobalConfiguration().loadFromAsset("dev_app_settings").whenComplete(() => {
    CruiseGlobalConfig.loadApp()
  });
}
