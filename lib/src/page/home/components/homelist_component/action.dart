import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomeListAction { action, jumpAddChannel, change_stories_type }

class HomeListActionCreator {
  static Action onAction() {
    return const Action(HomeListAction.action);
  }

  static Action onJumpAddChannel() {
    return const Action(HomeListAction.action);
  }

  static Action onChangeStoriesType(StoriesType currentStoriesType) {
    return Action(HomeListAction.change_stories_type,
        payload: currentStoriesType);
  }
}
