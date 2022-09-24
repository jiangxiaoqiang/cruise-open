import 'package:get/get.dart';

import '../../models/pay/pay_model.dart';

class PayController extends GetxController {
  PayModel payModel = PayModel(
      isAvailable: false,
      products: [],
      purchases: [],
      notFoundIds: [],
      purchasePending: false,
      loading: true,
      queryProductError: null,
      consumables: []);
}
