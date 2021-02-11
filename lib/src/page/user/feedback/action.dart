import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FeedbackAction { action, submit }

class FeedbackActionCreator {
  static Action onAction() {
    return const Action(FeedbackAction.action);
  }

  static Action onSubmit(String feedback) {
    return Action(FeedbackAction.submit, payload: feedback);
  }
}
