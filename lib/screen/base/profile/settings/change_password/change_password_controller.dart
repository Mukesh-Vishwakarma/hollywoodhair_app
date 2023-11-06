import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/api_provider/api_provider.dart';
import 'package:hollywood_hair/model/base_model.dart';
import 'package:hollywood_hair/util/app_constants.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../../model/change_password_model.dart';
import '../../../../../util/progress_dialog.dart';

class ChangePasswordController extends GetxController {
  final formLoginKey = GlobalKey<FormState>();
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var oldPasswordVisible = true.obs;
  var newPasswordVisible = true.obs;
  var confirmPasswordVisible = true.obs;

  var oldPassword = "".obs;
  var newPassword = "".obs;
  var confirmPassword = "".obs;

  var userId = "".obs;
  var isPageLoad = false.obs;

  //  ****** change password

/*
  changePasswordApi() async {
    isPageLoad.value = true;
    userId.value = GetStorage().read(AppConstants.userId) ?? "";

    print("customer_id>>>>>${userId.value}");
    print("New password>>>>>${newPassword.value}");
    print("old password>>>>>${oldPassword.value}");
    print("confirm password>>>>>${confirmPassword.value}");
    try {
      dio.FormData params = dio.FormData.fromMap({
        'customer_id': "7301030707535",
        'old_password': oldPassword.value,
        'new_password': newPassword.value.toString(),
        'confirm_password': confirmPassword.value.toString()
      });
      print('create Data');
      print(params.toString());
      BaseModel baseModel = await ApiProvider.base().funChangePassword(params);
      isPageLoad.value = false;
      // progressDialog.dismiss();
      print('create Data');
      print(baseModel.result);
      if (baseModel.result == 1) {
        successToast(baseModel.message!);

        Get.back();
      } else {
        successToast(baseModel.message!);
        // isPageLoad.value = false;
        // failedToast(userBean.msg!);
      }
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
  }
*/

  deleteCustomerAddress() async {
    ProgressDialog progressIndicator = ProgressDialog();
    try {
      final input = await GetStorage().read(
        AppConstants.userId,
      );
      final passwordController = await GetStorage().read(
        AppConstants.passwordController,
      );

      final customerId = input.split('/').last;

      print("customer_id>>>>>${userId.value}");
      print("New password>>>>>${newPassword.value}");
      print("old password>>>>>${oldPassword.value}");
      print("confirm password>>>>>${confirmPassword.value}");

      if (oldPassword.trim().toString() ==
          passwordController.trim().toString()) {
        progressIndicator.show();
        var data = json.encode({
          "customer": {
            "id": customerId,
            "password": newPassword.value,
            "password_confirmation": confirmPassword.value,
            "send_email_welcome": false
          }
        });

        print("shjbhhdxc==> $data");
        ChangePasswordModel changePasswordModel = await ApiProvider.shopify()
            .changePasswordShopify(customerId: customerId, data: data);

        print("djskkz==>$changePasswordModel");

        successToast("Password change successfully!");
        isPageLoad.value = false;
        progressIndicator.dismiss();

        await GetStorage()
            .write(AppConstants.passwordController, passwordController.text);
        Get.back();
      } else {
        successToast("Old password dose not match!");
      }
    } on HttpException catch (exception) {
      print("kjsdbxcbh1==> ${exception.message}");
      isPageLoad.value = false;
      progressIndicator.dismiss();
    } catch (exception) {
      print("kjsdbxcbh2==> ${exception.toString()}");
      failedToast("Cannot delete the customer’s default address");
      isPageLoad.value = false;
      progressIndicator.dismiss();
    }
  }
}
