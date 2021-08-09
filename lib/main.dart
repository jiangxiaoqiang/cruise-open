import 'package:cruise/src/common/config/cruise_global_config.dart';
import 'package:wheel/wheel.dart' show CommonUtils,ConfigType;

void main() async {
  CommonUtils.initialApp(ConfigType.DEV).whenComplete(() => {
    CruiseGlobalConfig.loadApp()
  });
}
