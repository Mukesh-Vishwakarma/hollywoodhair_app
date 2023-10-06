import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/api_provider/api_provider.dart';
import 'package:hollywood_hair/model/base_model.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:hollywood_hair/util/service/auth_service.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

class SignUpController extends GetxController {
  final formLoginKey = GlobalKey<FormState>();
  var authService = Get.find<AuthServices>();

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var contactController = TextEditingController();

  var name = "".obs;
  var email = "".obs;
  var password = "".obs;
  var contact = "".obs;
  var countryCode = "+91".obs;

  var isPageLoad = false.obs;

  //****** api registration
  registrationApi() async {
    var deviceType = await authService.getDeviceType();
    isPageLoad.value = true;
    try {
      ShopifyUser value;
      ShopifyAuth shopifyAuth = ShopifyAuth.instance;
      value = await shopifyAuth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
          firstName: nameController.text,
          lastName: "");
      isPageLoad.value = false;
    } catch (exception) {
      isPageLoad.value = false;
      failedToast("User already register!");
    }
  }


}