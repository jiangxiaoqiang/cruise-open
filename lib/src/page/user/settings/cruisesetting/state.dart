import 'package:fish_redux/fish_redux.dart';

class CruiseSettingState implements Cloneable<CruiseSettingState> {

  @override
  CruiseSettingState clone() {
    return CruiseSettingState();
  }
}

CruiseSettingState initState(Map<String, dynamic> args) {
  return CruiseSettingState();
}
