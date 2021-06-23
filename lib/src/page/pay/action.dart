import 'package:cruise/src/models/pay/pay_model.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PayAction { update,set_consumable,change_pending,verify_purchase }

class PayActionCreator {

  static Action onUpdate(PayModel payModel) {
    return Action(PayAction.update,payload: payModel);
  }

  static Action onSetConsumable(List<String> consumables) {
    return Action(PayAction.set_consumable,payload: consumables);
  }

  static Action onChangePending(bool pendingStatus) {
    return Action(PayAction.change_pending,payload: pendingStatus);
  }

  static Action onVerifyPurchase(bool pendingStatus) {
    return Action(PayAction.verify_purchase,payload: pendingStatus);
  }
}
