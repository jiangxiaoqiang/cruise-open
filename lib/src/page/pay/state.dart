import 'package:cruise/src/models/pay/pay_model.dart';
import 'package:fish_redux/fish_redux.dart';

class PayState implements Cloneable<PayState> {

  PayModel payModel = PayModel(isAvailable: false, products: [], purchases: [], notFoundIds: [], purchasePending: false, loading: true, queryProductError: 'initial', consumables: []);

  @override
  PayState clone() {

    return PayState()
      ..payModel = this.payModel;
  }
}

PayState initState(Map<String, dynamic> args) {

  return PayState();
}
