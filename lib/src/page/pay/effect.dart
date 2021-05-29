import 'dart:async';

import 'package:cruise/src/common/log/cruise_log_handler.dart';
import 'package:cruise/src/models/pay/pay_model.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'action.dart';
import 'consumable_store.dart';
import 'state.dart';

Effect<PayState> buildEffect() {
  return combineEffects(<Object, Effect<PayState>>{
    Lifecycle.initState: _onInit,
  });
}

const bool _kAutoConsume = true;

const String _kConsumableId = 'cruise';

late StreamSubscription<List<PurchaseDetails>> _subscription;
String? _queryProductError;
const List<String> _kProductIds = <String>[
  _kConsumableId
];

Future _onInit(Action action, Context<PayState> ctx) async {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  // https://pub.dev/packages/in_app_purchase
  // https://joebirch.co/flutter/adding-in-app-purchases-to-flutter-apps/
  final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
  _subscription = purchaseUpdated.listen((purchaseDetailsList) {
    _listenToPurchaseUpdated(purchaseDetailsList, ctx);
  }, onDone: () {
    _subscription.cancel();
  }, onError: (error) {
    // handle error here.
    CruiseLogHandler.logErrorException("iap initial error", error);
  });

  initStoreInfo(ctx,_inAppPurchase);
}

void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList, Context<PayState> ctx) {
  purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.pending) {
      _showPendingUI(ctx);
    } else {
      if (purchaseDetails.status == PurchaseStatus.error) {
        _handleError(purchaseDetails.error!, ctx);
      } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {}
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  });
}

void _handleError(IAPError error, Context<PayState> ctx) {
  PayModel payModel = PayModel(isAvailable: false, products: [], purchases: [], notFoundIds: [], purchasePending: false, loading: false, queryProductError: error.message, consumables: []);
  CruiseLogHandler.logErrorException("IAPError", error);
  ctx.dispatch(PayActionCreator.onUpdate(payModel));
}

void _showPendingUI(Context<PayState> ctx) {
  ctx.dispatch(PayActionCreator.onChangePending(true));
}

Future<void> initStoreInfo(Context<PayState> ctx,InAppPurchase _inAppPurchase ) async {
  final bool isAvailable = await _inAppPurchase.isAvailable();
  if (!isAvailable) {
    PayModel payModel = PayModel(isAvailable: isAvailable, products: [], purchases: [], notFoundIds: [], purchasePending: false, loading: false, consumables: [], queryProductError: 'isAvailable false');
    ctx.dispatch(PayActionCreator.onUpdate(payModel));
    return;
  }

  ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
  if (productDetailResponse.error != null) {
    PayModel payModel = PayModel(isAvailable: isAvailable,
        products: productDetailResponse.productDetails,
        queryProductError :productDetailResponse.error!.message,
        purchases: [],
        consumables : [],
        notFoundIds: productDetailResponse.notFoundIDs,
        purchasePending: false, loading: false);
    ctx.dispatch(PayActionCreator.onUpdate(payModel));
    return;
  }

  if (productDetailResponse.productDetails.isEmpty) {
    PayModel payModel = PayModel(isAvailable: isAvailable,
        products: productDetailResponse.productDetails,
        queryProductError :'productDetails empty',
        purchases: [],
        consumables : [],
        notFoundIds: productDetailResponse.notFoundIDs,
        purchasePending: false, loading: false);
    ctx.dispatch(PayActionCreator.onUpdate(payModel));
    return;
  }

  await _inAppPurchase.restorePurchases();

  List<String> consumables = await ConsumableStore.load();
  PayModel payModel = PayModel(isAvailable: isAvailable,
      products: productDetailResponse.productDetails,
      queryProductError :'consumables:' + consumables.join(','),
      purchases: [],
      consumables : consumables,
      notFoundIds: productDetailResponse.notFoundIDs,
      purchasePending: false, loading: false);
  ctx.dispatch(PayActionCreator.onUpdate(payModel));
}

