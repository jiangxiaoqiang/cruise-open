import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PayState implements Cloneable<PayState> {

  @override
  PayState clone() {
    return PayState();
  }
}

// StreamSubscription<List<PurchaseDetails>> _subscription;

PayState initState(Map<String, dynamic> args) {
  final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;

  return PayState();
}


void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
  purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.pending) {
      //_showPendingUI();
    } else {
      if (purchaseDetails.status == PurchaseStatus.error) {
        //_handleError(purchaseDetails.error!);
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {

      }
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance
            .completePurchase(purchaseDetails);
      }
    }
  });
}