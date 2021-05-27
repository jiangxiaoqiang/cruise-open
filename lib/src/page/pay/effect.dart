import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'action.dart';
import 'state.dart';

Effect<PayState> buildEffect() {
  return combineEffects(<Object, Effect<PayState>>{
    PayAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

Future _onInit(Action action, Context<PayState> ctx) async {
  // https://pub.dev/packages/in_app_purchase
  // https://joebirch.co/flutter/adding-in-app-purchases-to-flutter-apps/
  loadingProducts();
}

void loadingProducts() async {
  // Set literals require Dart 2.2. Alternatively, use
  // `Set<String> _kIds = <String>['product1', 'product2'].toSet()`.
  const Set<String> _kIds = <String>{'product1', 'product2'};
  final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(_kIds);
  if (response.notFoundIDs.isNotEmpty) {
    // Handle the error.
  }
  List<ProductDetails> products = response.productDetails;
}

void _onAction(Action action, Context<PayState> ctx) {}
