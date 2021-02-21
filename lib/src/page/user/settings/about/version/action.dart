import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum VersionAction { action }

class VersionActionCreator {
  static Action onAction() {
    return const Action(VersionAction.action);
  }
}
