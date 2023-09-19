import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/model/shopify_model/get_cart_model.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class CartController extends GetxController with GetTickerProviderStateMixin {
  var promoCodeController = TextEditingController();
  var cartList = <CartData>[].obs;
  ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;
  var checkoutId = "";
  var noCartCreated = true.obs;
  var dataLoading = true.obs;
  late Checkout checkout;

  @override
  void onInit() async {
    checkoutId = GetStorage().read(AppConstants.checkOutID) ?? "";
    if (checkoutId.isNotEmpty) {
      getCart();
    } else {
      noCartCreated.value = true;
    }
    super.onInit();
  }

  // getCartApi() async {
  //   try {
  //
  //     var acesstokken = await shopifyAuth.currentCustomerAccessToken;
  //     print("acesstokken${acesstokken}");
  //     List<Order>? order =
  //         await shopifyCheckout.getAllOrders(acesstokken.toString());
  //     List<Order>? order2 =
  //         await shopifyCheckout.getAllOrders(acesstokken.toString());
  //     print("kamal12");
  //     print(order);
  //     print("kamal ${order![0].id}");
  //     // GetCartModel getCartModel = await ApiProvider.shopifyWithToken()
  //     //     .funGetToCart();
  //
  //     // isPageLoad.value = false;
  //     // progressDialog.dismiss();
  //     // print('create Data ==> $getCartModel');
  //     // print(getCartModel.items!.length);
  //     // cartList.value = getCartModel.items!;
  //   } on HttpException catch (exception) {
  //     // progressDialog.dismiss();
  //     print(exception.message);
  //     // isPageLoad.value = false;
  //     // failedToast(exception.message);
  //   } catch (exception) {
  //     // progressDialog.dismiss();
  //     print(exception.toString());
  //     // isPageLoad.value = false;
  //     // failedToast(exception.toString());
  //   }
  // }

  Future<void> addItemToCart(
      String accessToken, int productId, int quantity) async {
    const url = 'https://a02f54.myshopify.com/cart/add.json';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'X-Shopify-Access-Token': accessToken,
      },
      body: jsonEncode({
        'id': productId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      // Item added successfully, parse the response and update the cart item count.
      final responseData = jsonDecode(response.body);
      final cartItemCount = responseData['item_count'];
      print('Cart item count: $cartItemCount');
    } else {
      // Handle the error here, e.g., display an error message to the user.
      print('Failed to add item to cart. Status code: ${response.statusCode}');
    }
  }

  Future<void> getCart() async {
    try {
      Checkout _checkout = await shopifyCheckout
          .getCheckoutInfoQuery(checkoutId, getShippingInfo: false);

      this.checkout = _checkout;
      dataLoading.value = false;
      noCartCreated.value = false;
      print("bhjk ${_checkout.lineItems[0].variant!.image!.originalSrc}");
    } catch (error) {
      print("message: $error");
    }
    // try {
    //   await ShopifyCheckout.instance.checkoutLineItemsReplace(
    //     checkoutId: checkoutId,
    //     checkoutLineItems: checkoutLineItems,
    //   );
    //   print('Product added to cart successfully');
    // } catch (error) {
    //   print('Error adding product to cart: $error');
    // }
  }
}

class CartModel {
  String image, price, title, qun;
  int number;

  CartModel(
      {required this.image,
      required this.price,
      required this.title,
      required this.qun,
      required this.number});
}
