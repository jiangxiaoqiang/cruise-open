import 'package:fish_redux/fish_redux.dart';

class FeedbackState implements Cloneable<FeedbackState> {

  @override
  FeedbackState clone() {
    return FeedbackState();
  }
}

FeedbackState initState(Map<String, dynamic> args) {
  return FeedbackState();
}
