import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

import 'booking/booking_screen.dart';
import 'cart_screen/cart_screen.dart';
import 'home_screen/home_screen.dart';
import 'profile/profile_screen.dart';

class BaseHomeController extends GetxController {
  var selectedIndex = 0.obs;
  var baseChildren = <Widget>[].obs;

  var totalMessageCount = "0".obs;

  @override
  void onInit() {
    var screenType = Get.arguments["screenType"] ?? "";
    if (screenType == "product details") {
      selectedIndex.value = 3;
    }

    baseChildren.value = [
      HomeScreen(),
      BookingScreen(),
      ProfileScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    super.onInit();
  }

  onItemSelect(index) {
    selectedIndex.value = index;
    refresh();
  }

  shopifyGetData() async {
    ShopifyAuth shopifyAuth = ShopifyAuth.instance;
    ShopifyUser? value = await shopifyAuth.currentUser();
    print("kamal $value");
    print(await shopifyAuth.currentCustomerAccessToken);
    ShopifyStore shopifyStore = ShopifyStore.instance;
    // List<Product> products = await shopifyStore.getAllProducts();
    // products.forEach((element) {
    //   print("${element.title}-- ${element.id}");
    // });
    // gid://shopify/Product/8673344979253
    // List<Product>? naan = await shopifyStore
    //     .getProductsByIds(["gid://shopify/Product/8678460686671"]);
    // print("rathore $naan");
    // print("rathore ${await shopifyStore.getShop()}");
    ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
    final checkout1 = await shopifyCheckout.createCheckout(
      lineItems: [
        LineItem(
            variantId: "gid://shopify/ProductVariant/47337289744719",
            title: "Example Pants",
            quantity: 1,
            id: "gid://shopify/Product/8678460686671")
      ],
    );
    // curl --location 'https://judge.me/reviews.json?shop_id=a02f54&product_handle=8673344979253&api_token=m1daT__S-mwOVP_yYKZ37e2nJFc' \
    // --header 'Cookie: current_country=IklOIg%3D%3D--edb54d5b02e4b711ec0044d8c883c4f2d9d271b7'
    print(checkout1.webUrl);
    // final checkout1 = await shopifyCheckout.getCheckoutInfoWithAvailableShippingRatesQuery("gid://shopify/Checkout/de2074ccb9401ec81700e8045ea40639?key=906aa3476fc11b4fb4c085aceda5bbc7");
    final checkout = await shopifyCheckout.getCheckoutInfoQuery(checkout1.id);
    print(checkout.webUrl);
    // shopifyAuth.currentCustomerAccessToken;
  }
}
