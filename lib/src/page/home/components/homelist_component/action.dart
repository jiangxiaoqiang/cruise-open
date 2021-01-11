import 'package:Cruise/src/models/Item.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomeListAction {  jumpAddChannel, change_stories_type }

class HomeListActionCreator {

  static Action onJumpAddChannel() {
    return const Action(HomeListAction.jumpAddChannel);
  }

  static Action onChangeStoriesType(StoriesType currentStoriesType) {
    return Action(HomeListAction.change_stories_type,
        payload: currentStoriesType);
  }
}
