import 'package:cruise/src/models/pay/pay_model.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PayAction { action,update }

class PayActionCreator {
  static Action onAction() {
    return const Action(PayAction.action);
  }

  static Action onUpdate(PayModel payModel) {
    return Action(PayAction.update,payload: payModel);
  }
}
