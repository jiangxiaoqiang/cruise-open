import 'package:cruise/src/common/feedback_rest_action.dart';
import 'package:cruise/src/common/net/rest/http_result.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<FeedbackState>? buildEffect() {
  return combineEffects(<Object, Effect<FeedbackState>>{
    FeedbackAction.action: _onAction,
    FeedbackAction.submit: _onSubmit,
  });
}

void _onAction(Action action, Context<FeedbackState> ctx) {}

void _onSubmit(Action action, Context<FeedbackState> ctx) async {
  String feedback = (action.payload as String);
  HttpResult result = await FeedbackRestAction.submitFeedback(feedback);
}
