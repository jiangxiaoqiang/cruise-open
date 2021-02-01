import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DiscoverAction { action }

class DiscoverActionCreator {
  static Action onAction() {
    return const Action(DiscoverAction.action);
  }
}
