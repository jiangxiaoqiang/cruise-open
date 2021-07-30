import 'package:fish_redux/fish_redux.dart';

class VersionState implements Cloneable<VersionState> {

  @override
  VersionState clone() {
    return VersionState();
  }
}

VersionState initState(Map<String, dynamic>? args) {
  return VersionState();
}
