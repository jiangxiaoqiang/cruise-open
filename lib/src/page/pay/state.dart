import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PayState implements Cloneable<PayState> {

  @override
  PayState clone() {
    return PayState();
  }
}

const bool _kAutoConsume = true;

const String _kConsumableId = 'consumable';
const String _kUpgradeId = 'upgrade';
const String _kSilverSubscriptionId = 'subscription_silver';
const String _kGoldSubscriptionId = 'subscription_gold';
const List<String> _kProductIds = <String>[
  _kConsumableId,
  _kUpgradeId,
  _kSilverSubscriptionId,
  _kGoldSubscriptionId,
];


final InAppPurchase _inAppPurchase = InAppPurchase.instance;
late StreamSubscription<List<PurchaseDetails>> _subscription;
List<String> _notFoundIds = [];
List<ProductDetails> _products = [];
List<PurchaseDetails> _purchases = [];
List<String> _consumables = [];
bool _isAvailable = false;
bool _purchasePending = false;
bool _loading = true;
String? _queryProductError;


PayState initState(Map<String, dynamic> args) {
  final Stream<List<PurchaseDetails>> purchaseUpdated =
      _inAppPurchase.purchaseStream;

  _subscription = purchaseUpdated.listen((purchaseDetailsList) {
    _listenToPurchaseUpdated(purchaseDetailsList);
  }, onDone: () {
    _subscription.cancel();
  }, onError: (error) {
    // handle error here.
  });

  // initStoreInfo();
  return PayState();
}

Future<void> initStoreInfo() async {
  final bool isAvailable = await _inAppPurchase.isAvailable();
  if (!isAvailable) {
    /* setState(() {
      _isAvailable = isAvailable;
      _products = [];
      _purchases = [];
      _notFoundIds = [];
      _consumables = [];
      _purchasePending = false;
      _loading = false;
    });*/
    return;
  }

  ProductDetailsResponse productDetailResponse =
  await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
  if (productDetailResponse.error != null) {
    /*setState(() {
      _queryProductError = productDetailResponse.error!.message;
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchases = [];
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = [];
      _purchasePending = false;
      _loading = false;
    });*/
    return;
  }

  if (productDetailResponse.productDetails.isEmpty) {
    /*setState(() {
      _queryProductError = null;
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchases = [];
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = [];
      _purchasePending = false;
      _loading = false;
    });*/
    return;
  }

  await _inAppPurchase.restorePurchases();

  /*List<String> consumables = await ConsumableStore.load();
  setState(() {
    _isAvailable = isAvailable;
    _products = productDetailResponse.productDetails;
    _notFoundIds = productDetailResponse.notFoundIDs;
    _consumables = consumables;
    _purchasePending = false;
    _loading = false;
  });*/
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