import 'dart:async';
import 'dart:convert';

import 'package:cruise/src/common/config/global_config.dart' as global;
import 'package:cruise/src/common/log/cruise_log_handler.dart';
import 'package:cruise/src/common/pay/pay.dart';
import 'package:cruise/src/common/product/product.dart';
import 'package:cruise/src/common/rest_log.dart';
import 'package:cruise/src/models/pay/pay_model.dart';
import 'package:cruise/src/models/pay/pay_verify_model.dart';
import 'package:cruise/src/models/pay/purchased_model.dart';
import 'package:cruise/src/models/product/iap_product.dart';
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

const List<String> _productIds = <String>['cruise', 'cruise_three_month','cruise_six_month','cruise_twelve_month'];

late StreamSubscription<List<PurchaseDetails>> _subscription;

Future _onInit(Action action, Context<PayState> ctx) async {
  RestLog.logger("Initial Pay...");
  // https://pub.dev/packages/in_app_purchase
  // https://joebirch.co/flutter/adding-in-app-purchases-to-flutter-apps/
  final Stream<List<PurchaseDetails>> purchaseUpdated = global.inAppPurchase.purchaseStream;
  _subscription = purchaseUpdated.listen((purchaseDetailsList) {
    _listenToPurchaseUpdated(purchaseDetailsList, ctx);
  }, onDone: () {
    _subscription.cancel();
  }, onError: (error) {
    RestLog.logger("purchaseUpdated error:" + error.toString());
    // handle error here.
    CruiseLogHandler.logErrorException("iap initial error", error);
  });

  try {
    RestLog.logger("initial store...");
    fetchPurchasedProduct(ctx)
    .then((value) => {
      initStoreInfo(ctx, global.inAppPurchase,value)
    });
  } on Exception catch (e) {
    RestLog.logger("initial store error" + e.toString());
  }
}

// attention the sequence of data load
// to avoid the initial store data override the purchased data
// render the purchased data after store initial complete
Future<PurchaseDetails?> fetchPurchasedProduct(Context<PayState> ctx) async {
  try {
    RestLog.logger("load products...");
    // get product subscribe status
    IapProduct? product = await Product.getPurchasedStatus();
    if(product != null) {
      PurchaseVerificationData data = PurchaseVerificationData(localVerificationData: '',serverVerificationData: '',source: '');
      PurchaseDetails purchaseDetails = PurchaseDetails(productID: product.productId,
      purchaseID:'',verificationData: data,transactionDate: '',status: PurchaseStatus.purchased);
      return purchaseDetails;
    }else{
      RestLog.logger("product is null...");
    }
  } on Exception catch (e) {
    RestLog.logger("fetchPurchasedProduct error:" + e.toString());
  }
  return null;
}

void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList, Context<PayState> ctx) {
  RestLog.logger("Purchase details:");
  purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.pending) {
      RestLog.logger("PurchaseStatus pending..." + ctx.state.payModel.isAvailable.toString());
      _showPendingUI(ctx);
    } else {
      if (purchaseDetails.status == PurchaseStatus.error) {
        RestLog.logger("PurchaseStatus error");
        _handleError(purchaseDetails.error!, ctx);
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        verifyReceipt(purchaseDetails, ctx);
      }
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  });
}

void verifyReceipt(PurchaseDetails purchaseDetails, Context<PayState> ctx) async {
  try {
    RestLog.logger("purchase successful trigger verify");
    PayVerifyModel payVerifyModel = PayVerifyModel(
        productId: purchaseDetails.productID,
        receipt: purchaseDetails.verificationData.serverVerificationData,
        transactionId: purchaseDetails.purchaseID);
    int receiptVerifyResult = await Pay.verifyReceipt(payVerifyModel);
    if (receiptVerifyResult == 0) {
      RestLog.logger("verify success:" + receiptVerifyResult.toString());
      await InAppPurchase.instance.completePurchase(purchaseDetails);
      deliverProduct(purchaseDetails, ctx);
    } else {
      RestLog.logger("verify failed:" + receiptVerifyResult.toString());
      _handleInvalidPurchase(purchaseDetails);
    }
  } on Exception catch (e) {
    RestLog.logger("verify receipt encount an eror:" + e.toString());
  }
}

void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
  // handle invalid purchase here if  _verifyPurchase` failed.
}

void deliverProduct(PurchaseDetails purchaseDetails, Context<PayState> ctx) async {
  // IMPORTANT!! Always verify purchase details before delivering the product.
  ctx.dispatch(PayActionCreator.onDeliverProduct(purchaseDetails));
}

void _handleError(IAPError error, Context<PayState> ctx) {
  PayModel payModel = PayModel(
      isAvailable: false,
      products: [],
      purchases: [],
      notFoundIds: [],
      purchasePending: false,
      loading: false,
      queryProductError: error.message,
      consumables: []);
  RestLog.logger("_handleError IAPError:" + error.toString());
  CruiseLogHandler.logErrorException("IAPError", error);
  ctx.dispatch(PayActionCreator.onUpdate(payModel));
}

void _showPendingUI(Context<PayState> ctx) {
  ctx.dispatch(PayActionCreator.onChangePending(true));
}

Future<void> initStoreInfo(Context<PayState> ctx, InAppPurchase _inAppPurchase,PurchaseDetails? purchaseDetail) async {
  final bool isAvailable = await _inAppPurchase.isAvailable();
  RestLog.logger("available status:" + isAvailable.toString());
  if (!isAvailable) {
    PayModel payModel = PayModel(
        isAvailable: isAvailable,
        products: [],
        purchases: [],
        notFoundIds: [],
        purchasePending: false,
        loading: false,
        consumables: [],
        queryProductError: 'isAvailable false');
    ctx.dispatch(PayActionCreator.onUpdate(payModel));
    return;
  }

  ProductDetailsResponse productDetailResponse = await _inAppPurchase.queryProductDetails(_productIds.toSet());
  RestLog.logger("Initial store product detail:");
  if (productDetailResponse.productDetails.length > 0) {
    productDetailResponse.productDetails.forEach((element) {
      RestLog.logger("productDetails status:" + element.currencyCode);
    });
  }
  if (productDetailResponse.error != null) {
    PayModel payModel = PayModel(
        isAvailable: isAvailable,
        products: productDetailResponse.productDetails,
        queryProductError: productDetailResponse.error!.message,
        purchases: [],
        consumables: [],
        notFoundIds: productDetailResponse.notFoundIDs,
        purchasePending: false,
        loading: false);
    ctx.dispatch(PayActionCreator.onUpdate(payModel));
    return;
  }

  if (productDetailResponse.productDetails.isEmpty) {
    PayModel payModel = PayModel(
        isAvailable: isAvailable,
        products: productDetailResponse.productDetails,
        queryProductError: 'productDetails empty',
        purchases: [],
        consumables: [],
        notFoundIds: productDetailResponse.notFoundIDs,
        purchasePending: false,
        loading: false);
    ctx.dispatch(PayActionCreator.onUpdate(payModel));
    return;
  }

  List<String> consumables = await ConsumableStore.load();

  PayModel payModel = PayModel(
      isAvailable: isAvailable,
      products: productDetailResponse.productDetails,
      queryProductError: null,
      debugMessage: 'consumables:' + consumables.join(','),
      purchases: purchaseDetail == null?[]:new List<PurchaseDetails>.from([purchaseDetail]),
      consumables: consumables,
      notFoundIds: productDetailResponse.notFoundIDs,
      purchasePending: false,
      loading: false);
  ctx.dispatch(PayActionCreator.onUpdate(payModel));

  fetchPurchasedProduct(ctx);
}
