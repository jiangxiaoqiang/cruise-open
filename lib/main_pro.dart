import 'package:cruise/src/common/config/cruise_global_config.dart';
import 'package:wheel/wheel.dart';

void main() async {
  CommonUtils.initialApp(ConfigType.PRO).whenComplete(() => {CruiseGlobalConfig.loadApp(ConfigType.PRO)});
}
