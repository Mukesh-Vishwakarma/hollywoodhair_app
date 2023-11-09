import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:hollywood_hair/util/common_function.dart';
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

      await GetStorage().write(AppConstants.isLogged, 'true');
      await GetStorage().write(AppConstants.userId, value.id.toString() ?? "");
      await GetStorage().write(AppConstants.loginUser, value);
      await GetStorage()
          .write(AppConstants.userName, value.displayName.toString());
      await GetStorage().write(AppConstants.email, value.email.toString());
      await GetStorage()
          .write(AppConstants.phoneNumber, value.phone.toString());
      await GetStorage()
          .write(AppConstants.passwordController, passwordController.text);

      Get.offAllNamed(AppPages.baseScreen,
          arguments: {"screenType": "login screen"});

      print("sdjkdjk===> $value");
      print("sdjkdjk===> ${value.id.toString()}");
    } on HttpException catch (exception) {
      if (kDebugMode) {
        print(exception.message);
      }
      failedToast("There are some problems, please try after some time.");
      isPageLoad.value = false;
    } catch (exception) {
      if (kDebugMode) {
        print(exception.toString());
      }
      failedToast("Userid or password is not correct!");
      isPageLoad.value = false;
    }
  }

//   ****** api login with shopify
/* loginApiShopify() async {
    try {
      final Map<String, dynamic> requestBody = {
        'query':
            "mutation customerAccessTokenCreate(\$input: CustomerAccessTokenCreateInput!) { customerAccessTokenCreate(input: \$input) { customerAccessToken { accessToken } customerUserErrors { message } } }",
        "variables": {
          "input": {
            "email": emailController.text.toString(),
            "password": passwordController.text.toString(),
          }
        }
      };

      LoginModel loginModel =
          await ApiProvider.shopifyStorefront().funLoginShopify(requestBody);
      isPageLoad.value = false;
      print(
          "loginModelll>>>> ${loginModel.data!.customerAccessTokenCreate!.customerAccessToken}");

      // if (loginModel.data!.customerAccessTokenCreate!.customerAccessToken !=
      //     null) {
        // await GetStorage().write(
        //     AppConstants.tokenShopify,
        //     loginModel.data!.customerAccessTokenCreate!.customerAccessToken!
        //         .accessToken);

        successToast("Login SuccessFull");
        Get.offAllNamed(AppPages.baseScreen,
            arguments: {"screenType": "login screen"});
      // }
    } on HttpException catch (exception) {
      // progressDialog.dismiss();
      print(exception.message);
      isPageLoad.value = false;
      // failedToast(exception.message);
    } catch (exception) {
      // progressDialog.dismiss();
      print(exception.toString());
      isPageLoad.value = false;
      // failedToast(exception.toString());
    }
  }*/
}
