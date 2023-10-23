import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/api_provider/api_provider.dart';
import 'package:hollywood_hair/model/base_model.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:hollywood_hair/util/service/auth_service.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:shopify_flutter/shopify/shopify.dart';

import '../../../util/app_constants.dart';

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

    print("firstName>>>>>${nameController.text}");
    print("Email>>>>>${emailController.text}");
    print("Password>>>>>${passwordController.text}");
    print("deviceType>>>>>${deviceType.toString()}");
    try {
    //   dio.FormData params = dio.FormData.fromMap({
    //     'firstname': nameController.text.toString(),
    //     'email': emailController.text.toString(),
    //     'device_type': deviceType.toString(),
    //     'device_id': '2',
    //     'password': passwordController.text.toString(),
    //   });
      ShopifyUser value;
      ShopifyAuth shopifyAuth = ShopifyAuth.instance;
      value = await shopifyAuth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
          firstName: nameController.text,
          lastName: "");

      isPageLoad.value = false;
      await GetStorage().write(AppConstants.isLogged, 'true');
      await GetStorage().write(AppConstants.userId, value.id.toString() ?? "");
      await GetStorage().write(AppConstants.loginUser, value);
      await GetStorage().write(AppConstants.userName, value.displayName.toString());
      await GetStorage().write(AppConstants.email, value.email.toString());
      await GetStorage().write(AppConstants.phoneNumber, value.phone.toString());

      Get.offAllNamed(AppPages.baseScreen,
          arguments: {"screenType": "login screen"});

      // print(params.toString());
      // BaseModel baseModel = await ApiProvider.base().funRegister(params);
      // isPageLoad.value = false;
      // print('create Data');
      // print(baseModel.result);
      // if (baseModel.result == "1") {
      //   successToast(baseModel.message!);
      //   // otpApi();
      // } else {
      //   successToast(baseModel.message!);
      // }
    } on HttpException catch (exception) {
      print("sdjbhjc===>1  ${exception.message}");
      failedToast("There are some problems, please try after some time.");
      isPageLoad.value = false;
    } catch (exception) {
      print("sdjbhjc===>2 {exception.toString()}");
      isPageLoad.value = false;
      failedToast("User already register!");
    }
  }

 // ****** otp verification

  otpApi() async {
    print("Email>>>>>${emailController.text}");
    try {
      dio.FormData params = dio.FormData.fromMap({
        'customer_email': emailController.text.toString(),
      });

      print('create Data');
      print(params.toString());
      BaseModel baseModel = await ApiProvider.base().funLoginOtp(params);
      isPageLoad.value = false;
      // progressDialog.dismiss();
      print('create Data');
      print(baseModel.result);
      if (baseModel.result == "1") {
        // successToast(baseModel.message!);

        print("sjhdzjbjhbs===>  ");

        Get.toNamed(AppPages.otpScreen, arguments: {
          "email": emailController.text.toString(),
          "type": "signUp",
          "password": passwordController.text.toString(),
          "phoneNumber":
              countryCode.value.toString() + contact.value.toString(),
        });

        print("object");
        // Get.back();
      } else {
        successToast(baseModel.message!);
      }
    } on HttpException catch (exception) {
      print(exception.message);
      isPageLoad.value = false;
    } catch (exception) {
      print(exception.toString());
      isPageLoad.value = false;
    }
  }
}
