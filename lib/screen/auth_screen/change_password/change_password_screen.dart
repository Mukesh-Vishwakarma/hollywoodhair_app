import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';

import 'change_password_controller.dart';



class ChangePasswordScreen extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,top: 30),
                    child: Image.asset(Assets.back,height:20,width: 20,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      "change_password".tr,
                      style: AppStyles.textStyle(
                          fontSize: dimen20, weight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: Center(
                    child: Text(
                      "change_password_des".tr,
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyle(
                          fontSize: dimen12,
                          color: Colors.grey,
                          weight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(height: 40,),


                Form(
                    key: controller.formLoginKey,
                    child: Column(children: [

                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: textField(
                            controller.newPasswordController,
                            "plz_enter_new_password".tr,
                            controller.newPassword,
                            'new_password'.tr,
                            "password"),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: textField(
                            controller.confirmPasswordController,
                            "plz_enter_confirm_password".tr,
                            controller.confirmPassword,
                            'confirm_password'.tr,
                            "password"),
                      ),

                      GestureDetector(
                          onTap: () {
                            if (!controller.formLoginKey.currentState!.validate()) {
                              print("not validate");
                            } else {
                              Get.toNamed(AppPages.profileScreen);
                              // controller.loginApi();
                            }
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 80, bottom: 10),
                              child: buttom("change_password".tr))),


                    ]))
              ],
            ),
          ),
        ));
  }
}
