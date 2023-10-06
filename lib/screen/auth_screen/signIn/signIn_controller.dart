import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class SignInController extends GetxController {
  final formLoginKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var passwordVisible = true.obs;
  var isPageLoad = false.obs;

  var email = "".obs;
  var password = "".obs;

  //****** api login
  loginApi() async {
    isPageLoad.value = true;
    try {
      ShopifyUser value;
      ShopifyAuth shopifyAuth = ShopifyAuth.instance;
      value = await shopifyAuth.signInWithEmailAndPassword(
          password: passwordController.text, email: emailController.text);
      isPageLoad.value = false;
      // progressDialog.dismiss();
      print('create Data');
      await GetStorage().write(AppConstants.isLogged, 'true');
      Get.offAllNamed(AppPages.baseScreen,
          arguments: {"screenType": "login screen"});
      // Get.back();
    } on HttpException catch (exception) {
    } catch (exception) {
      isPageLoad.value = false;
    }
  }
}
