import 'package:get/get.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class SettingsController extends GetxController {
  ShopifyAuth shopifyAuth = ShopifyAuth.instance;

  signOutFun() async {
    try {
      await shopifyAuth.signOutCurrentUser();
      isLogoutResponse();
      print("dhgxzbhjnz==> ");
    } catch (e){
      print("dhgxzbhjnz==> $e");
      isLogoutResponse();
    }
  }
}
