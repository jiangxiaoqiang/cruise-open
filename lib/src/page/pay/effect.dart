import 'dart:async';

import 'package:cruise/src/models/pay/pay_model.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'action.dart';
import 'state.dart';

Effect<PayState> buildEffect() {
  return combineEffects(<Object, Effect<PayState>>{
    Lifecycle.initState: _onInit,
  });
}

const bool _kAutoConsume = true;

const String _kConsumableId = 'consumable';
const String _kUpgradeId = 'upgrade';
const String _kSilverSubscriptionId = 'subscription_silver';
const String _kGoldSubscriptionId = 'subscription_gold';

final InAppPurchase _inAppPurchase = InAppPurchase.instance;
late StreamSubscription<List<PurchaseDetails>> _subscription;
String? _queryProductError;
const List<String> _kProductIds = <String>[
  _kConsumableId,
  _kUpgradeId,
  _kSilverSubscriptionId,
  _kGoldSubscriptionId,
];

Future _onInit(Action action, Context<PayState> ctx) async {
  // https://pub.dev/packages/in_app_purchase
  // https://joebirch.co/flutter/adding-in-app-purchases-to-flutter-apps/
  final Stream<List<PurchaseDetails>> purchaseUpdated =
      _inAppPurchase.purchaseStream;

  _subscription = purchaseUpdated.listen((purchaseDetailsList) {
    _listenToPurchaseUpdated(purchaseDetailsList);
  }, onDone: () {
    _subscription.cancel();
  }, onError: (error) {
    // handle error here.
  });

  initStoreInfo(ctx);
}

void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
  purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.pending) {
      //_showPendingUI();
    } else {
      if (purchaseDetails.status == PurchaseStatus.error) {
        //_handleError(purchaseDetails.error!);
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {}
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  });
}

Future<void> initStoreInfo(Context<PayState> ctx) async {
  final bool isAvailable = await _inAppPurchase.isAvailable();
  if (!isAvailable) {
    PayModel payModel = PayModel(
        isAvailable: isAvailable,
        products: [],
        purchases: [],
        notFoundIds: [],
        purchasePending: false,
        loading: false);
    ctx.dispatch(PayActionCreator.onUpdate(payModel));
    return;
  }

  ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
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


