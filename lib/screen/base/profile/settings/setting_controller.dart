import 'package:get/get.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class SettingsController extends GetxController {
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;

  signoutFun() async {
    await shopifyAuth.signOutCurrentUser();
    isLogoutResponse();
  }
}
