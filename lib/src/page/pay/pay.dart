import 'dart:async';
import 'dart:io';

import 'package:cruise/src/common/config/cruise_global_config.dart' as global;
import 'package:cruise/src/page/pay/pay_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import 'consumable_store.dart';

class Pay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayController>(
        init: PayController(),
        builder: (controller) {
          List<String> _notFoundIds = controller.payModel.notFoundIds;
          List<ProductDetails> _products = controller.payModel.products;
          List<PurchaseDetails> _purchases = controller.payModel.purchases;
          List<String> _consumables = controller.payModel.consumables;
          bool _isAvailable = controller.payModel.isAvailable;
          bool _purchasePending = controller.payModel.purchasePending;
          bool _loading = controller.payModel.loading;
          String? _queryProductError = controller.payModel.queryProductError;

          const bool _kAutoConsume = true;

          Card _buildConnectionCheckTile() {
            if (_loading) {
              return Card(child: ListTile(title: const Text('Trying to connect...')));
            }
            final Widget storeHeader = ListTile(
              leading: Icon(_isAvailable ? Icons.check : Icons.block, color: _isAvailable ? Colors.green : ThemeData.light().errorColor),
              title: Text('The store is ' + (_isAvailable ? 'available' : 'unavailable') + '.'),
            );
            final List<Widget> children = <Widget>[];

            if (!_isAvailable) {
              children.addAll([
                Divider(),
                ListTile(
                  title: Text('Not connected', style: TextStyle(color: ThemeData.light().errorColor)),
                  subtitle: const Text(
                      'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
                ),
              ]);
            }
            return Card(child: Column(children: children));
          }

          GooglePlayPurchaseDetails? _getOldSubscription(ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
            // This is just to demonstrate a subscription upgrade or downgrade.
            // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
            // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
            // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
            // Please remember to replace the logic of finding the old subscription Id as per your app.
            // The old subscription is only required on Android since Apple handles this internally
            // by using the subscription group feature in iTunesConnect.
            GooglePlayPurchaseDetails? oldSubscription;
            return oldSubscription;
          }

          Card _buildProductList() {
            if (_loading) {
              return Card(child: (ListTile(leading: CircularProgressIndicator(), title: Text('Fetching products...'))));
            }
            if (!_isAvailable) {
              return Card();
            }
            final ListTile productHeader = ListTile(title: Text('订阅列表'));
            List<ListTile> productList = <ListTile>[];
            if (_notFoundIds.isNotEmpty) {
              productList.add(ListTile(
                  title: Text('[${_notFoundIds.join(", ")}] not found', style: TextStyle(color: ThemeData.light().errorColor)),
                  subtitle: Text('This app needs special configuration to run. Please see example/README.md for instructions.')));
            }

            // This loading previous purchases code is just a demo. Please do not use this as it is.
            // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
            // We recommend that you use your own server to verify the purchase data.
            Map<String, PurchaseDetails> purchases = Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
              if (purchase.pendingCompletePurchase) {
                global.inAppPurchase.completePurchase(purchase);
              }
              return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
            }));

            productList.addAll(_products.map(
              (ProductDetails productDetails) {
                PurchaseDetails? previousPurchase = purchases[productDetails.id];
                return ListTile(
                    title: Text(
                      productDetails.title,
                    ),
                    subtitle: Text(
                      productDetails.description,
                    ),
                    trailing: previousPurchase != null
                        ? Icon(Icons.check)
                        : TextButton(
                            child: Text(productDetails.price),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green[800],
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              late PurchaseParam purchaseParam;

                              if (Platform.isAndroid) {
                                // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                                // verify the latest status of you your subscription by using server side receipt validation
                                // and update the UI accordingly. The subscription purchase status shown
                                // inside the app may not be accurate.
                                final oldSubscription = _getOldSubscription(productDetails, purchases);
                                purchaseParam = GooglePlayPurchaseParam(
                                    productDetails: productDetails,
                                    applicationUserName: null,
                                    changeSubscriptionParam: (oldSubscription != null)
                                        ? ChangeSubscriptionParam(
                                            oldPurchaseDetails: oldSubscription,
                                            prorationMode: ProrationMode.immediateWithTimeProration,
                                          )
                                        : null);
                              } else {
                                purchaseParam = PurchaseParam(
                                  productDetails: productDetails,
                                  applicationUserName: null,
                                );
                              }

                              global.inAppPurchase
                                  .buyConsumable(purchaseParam: purchaseParam, autoConsume: _kAutoConsume || Platform.isIOS);
                            },
                          ));
              },
            ));

            return Card(child: Column(children: <Widget>[productHeader, Divider()] + productList));
          }

          Future<void> consume(String id) async {
            await ConsumableStore.consume(id);
            final List<String> consumables = await ConsumableStore.load();
            //dispatch(PayActionCreator.onSetConsumable(consumables));
          }

          Widget _buildRestoreButton() {
            if (_loading) {
              return Container();
            }

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('Restore purchases'),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      primary: Colors.white,
                    ),
                    onPressed: () => global.inAppPurchase.restorePurchases(),
                  ),
                ],
              ),
            );
          }

          Card _buildConsumableBox() {
            if (_loading) {
              return Card(child: (ListTile(leading: CircularProgressIndicator(), title: Text('Fetching consumables...'))));
            }
            if (!_isAvailable) {
              return Card();
            }
            final ListTile consumableHeader = ListTile(title: Text('已购列表'));
            final List<Widget> tokens = _consumables.map((String id) {
              return GridTile(
                child: IconButton(
                  icon: Icon(
                    Icons.stars,
                    size: 42.0,
                    color: Colors.orange,
                  ),
                  splashColor: Colors.yellowAccent,
                  onPressed: () => consume(id),
                ),
              );
            }).toList();
            return Card(
                child: Column(children: <Widget>[
              consumableHeader,
              Divider(),
              GridView.count(
                crossAxisCount: 5,
                children: tokens,
                shrinkWrap: true,
                padding: EdgeInsets.all(16.0),
              )
            ]));
          }

          List<Widget> stack = [];
          // stack.add(Text("debug:" + debugMessage!));
          if (_queryProductError == null) {
            stack.add(
              ListView(
                children: [_buildConnectionCheckTile(), _buildProductList(), _buildConsumableBox(), _buildRestoreButton()],
              ),
            );
          } else {
            stack.add(Center(
              child: Text("error:" + _queryProductError),
            ));
          }
          if (_purchasePending) {
            stack.add(
              Stack(
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: const ModalBarrier(dismissible: false, color: Colors.grey),
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('会员中心'),
            ),
            body: Stack(
              children: stack,
            ),
          );
        });
  }
}
