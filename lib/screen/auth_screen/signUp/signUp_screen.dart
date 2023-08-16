import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:hollywood_hair/util/res_dimens.dart';

import 'signUp_controller.dart';


class SignUpScreen extends GetView<SignUpController> {
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
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      "get_started".tr,
                      style: AppStyles.textStyle(
                          fontSize: dimen20, weight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: Center(
                    child: Text(
                      "get_started_dis".tr,
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyle(
                          fontSize: dimen12,
                          color: Colors.grey,
                          weight: FontWeight.w400),
                    ),
                  ),
                ),
                Form(
                    key: controller.formLoginKey,
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                        child: textField(
                            controller.nameController,
                            "plz_enter_name".tr,
                            controller.name,
                            'name'.tr,
                            "name"),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: textField(
                            controller.emailController,
                            "plz_enter_email".tr,
                            controller.email,
                            'email'.tr,
                            "email"),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: textField(
                            controller.passwordController,
                            "plz_enter_password".tr,
                            controller.password,
                            'password'.tr,
                            "password"),
                      ),

                      GestureDetector(
                          onTap: () {
                            if (!controller.formLoginKey.currentState!.validate()) {
                              print("not validate");
                            } else {
                              // controller.loginApi();
                            }
                          },
                          child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 80, bottom: 10),
                              child: buttom("sign_up".tr))),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 8, left: 8),
                              child: Text(
                                "signUp_with".tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  // color: AppColors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [

                          Expanded(
                            child: Container(

                                margin: EdgeInsets.only(left: 20,right: 20),
                                width: Get.size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.colorE9,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  // color: AppColors.colorFF,
                                ),
                                padding: EdgeInsets.only(top: 5,bottom: 5,left:0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [


                                    Image.asset(Assets.google,height: 20,width:20,), Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Google",

                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          // color: AppColors.colorFF,
                                        ),

                                      ),
                                    )


                                  ],
                                )),
                          ),

                          Expanded(
                            child: Container(

                                margin: EdgeInsets.only(left: 0,right: 20),
                                width: Get.size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.colorE9,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  // color: AppColors.colorFF,
                                ),
                                padding: EdgeInsets.only(top: 5,bottom: 5,left:0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [


                                    Image.asset(Assets.facebook,height: 20,width:20,), Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("FaceBook",

                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                          // color: AppColors.colorFF,
                                        ),

                                      ),
                                    )


                                  ],
                                )),
                          ),


                        ],),
                      SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          // Get.toNamed(AppRoutes.signUp);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: RichText(
                            text:  TextSpan(
                              text: "already_have_an_account".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: AppColors.color61,
                              ),
                              children: <TextSpan>[
                                TextSpan(text: " "),
                                TextSpan(
                                    text: "sign_in".tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color:Colors.black,
                                      decoration: TextDecoration.underline,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 50),


                    ]))
              ],
            ),
          ),
        ));
  }
}
