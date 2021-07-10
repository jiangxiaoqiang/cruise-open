import 'package:cruise/src/models/pay/pay_model.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

//TODO replace with your own action
enum PayAction {
  update,
  set_consumable,
  change_pending,
  verify_purchase,
  deliver_product,
  load_purchased_product
}

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

  static Action onDeliverProduct(PurchaseDetails purchaseDetails) {
    return Action(PayAction.deliver_product,payload: purchaseDetails);
  }

  static Action onLoadPurchasedProduct(ProductDetails productDetails) {
    return Action(PayAction.load_purchased_product,payload: productDetails);
  }
}
