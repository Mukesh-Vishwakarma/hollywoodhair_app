import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/model/shopify_model/get_cart_model.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class CartController extends GetxController with GetTickerProviderStateMixin {
  var promoCodeController = TextEditingController(text: 'EG746C2HANN5');
  var cartList = <CartData>[].obs;
  ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;
  var checkoutId = "";
  var noCartCreated = true.obs;
  var dataLoading = true.obs;
  late Checkout checkout;

  final shopifyStore = ShopifyStore.instance;

  @override
  void onInit() async {
    try {
      checkoutId = GetStorage().read(AppConstants.checkOutID) ?? "";
      if (checkoutId.isNotEmpty) {
        getCart();
      } else {
        noCartCreated.value = true;
      }
    } catch (e){
      noCartCreated.value = true;
    }

    print("sadzxcksdzx===> $checkoutId");

    super.onInit();
  }

  Future<void> getCart() async {
    noCartCreated.value = true;
    try {
      Checkout checkoutModel = await shopifyCheckout.getCheckoutInfoQuery(checkoutId, getShippingInfo: false);
      dataLoading.value = false;
      noCartCreated.value = false;
      checkout = checkoutModel;
    } catch (error) {
      dataLoading.value = false;
      noCartCreated.value = true;
      print("message===> $error");
    }
  }

  void updateCartItemQuantity(lineItemID, int newQuantity) async {
    try {
      final cart = await shopifyCheckout
          .updateLineItemsInCheckout(checkoutId: checkoutId, lineItems: [
        LineItem(
            id: lineItemID.id,
            variantId: lineItemID.variantId,
            quantity: newQuantity,
            title: lineItemID.title),
      ]);
      getCart();
      print('Updated Cart: $cart');
    } catch (error) {
      // Handle errors if the update fails
      print('Error updating cart: $error');
    }
  }


  void removeCartItems(lineItemID, int newQuantity) async {
    try {
      dataLoading.value = true;
      final cart = await shopifyCheckout
          .removeLineItemsFromCheckout(checkoutId: checkoutId, lineItems: [
        LineItem(
            id: lineItemID.id,
            variantId: lineItemID.variantId,
            quantity: newQuantity,
            title: lineItemID.title),
      ]);
      getCart();
      update();
      print('Updated Cart: $cart');
    } catch (error) {
      // Handle errors if the update fails
      print('Error updating cart: $error');
    }
  }

  applyPromoCode() async {
    try {
      dataLoading.value = true;
      await shopifyCheckout.checkoutDiscountCodeApply(
          checkoutId, promoCodeController.text.trim());
      getCart();
      update();
    } catch (error) {
      // Handle errors if the update fails
      print('Error updating cart: $error');
    }
  }

}
