import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'signIn_controller.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Center(
              child: Text(
                "welcome_back".tr,
                style: AppStyles.textStyle(
                    fontSize: 24.0, weight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                "welcome_dis".tr,
                style: AppStyles.textStyle(
                    fontSize: 13.0,
                    color: Colors.grey,
                    weight: FontWeight.w400),
              ),
            ),
          ),
          Form(
              key: controller.formLoginKey,
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: textField(
                    controller: controller.emailController,
                    validationMsg: "plz_enter_email".tr,
                    text: controller.email,
                    hintText: 'email'.tr,
                    type: "email",
                    label: true,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Obx(() => TextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.passwordVisible.value,
                          style: AppStyles.textStyle(
                            fontSize: 14.0,
                            weight: FontWeight.normal,
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "plz_enter_password".tr;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            controller.password.value = value;
                          },
                          decoration: InputDecoration(
                            isDense: false,
                            contentPadding: const EdgeInsets.all(15),
                            hintText: 'password'.tr,
                            hintStyle: AppStyles.textStyle(
                              color: AppColors.black,
                              fontSize: 14.0,
                              weight: FontWeight.normal,
                            ),
                            suffixIcon: Obx(() => InkWell(
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              onTap: (){
                                controller.passwordVisible.value =
                                !controller.passwordVisible.value;
                              },
                              child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: !controller.passwordVisible.value
                                        ? Image.asset(
                                            Assets.seenPassword,
                                            height: 5,
                                          )
                                        : Image.asset(
                                            Assets.unseenPassword,
                                            height: 5,
                                          ),
                                  ),
                            )),

                            labelText: 'password'.tr,
                            labelStyle: AppStyles.textStyle(
                              color: AppColors.black,
                              fontSize: 14.0,
                              weight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.colorCD, width: 0.99),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: AppColors.colorCD, width: 0.99),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 0,
                              ),
                            ),
                          ),
                        ))),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppPages.forgotScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, top: 20),
                        child: Text(
                          "forgot_password".tr,
                          style: AppStyles.textStyle(
                            color: AppColors.black,
                            fontSize: 13.0,
                            weight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Obx(
                  () => !controller.isPageLoad.value
                      ? GestureDetector(
                          onTap: () {
                            if (!controller.formLoginKey.currentState!
                                .validate()) {
                              print("not validate");
                            } else {
                              print("validateeee");
                              controller.loginApi();
                              // Get.back();
                              // controller.loginApi();
                            }
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 80, bottom: 10),
                              child: buttom("sign_in".tr)))
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 80, bottom: 10),
                          child: Container(
                            width: Get.size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: AppColors.color7C,
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),

                /*GestureDetector(
                    onTap: () {
                      if (!controller.formLoginKey.currentState!.validate()) {
                        print("not validate");
                      } else {

                        controller.loginApi();
                      }
                    },
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 80, bottom: 10),
                        child: buttom("sign_in".tr,
                        ))),*/

                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8, left: 8),
                        child: Text("sign_with".tr,
                            style: AppStyles.textStyle(
                              color: AppColors.gray99,
                              fontSize: 14.0,
                              weight: FontWeight.normal,
                            )),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: Get.size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.grayE9,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      // color: AppColors.colorFF,
                    ),
                    padding:
                        const EdgeInsets.only(top: 15, bottom: 15, left: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Image.asset(
                            Assets.google,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: Text("Google",
                              style: AppStyles.textStyle(
                                color: AppColors.black,
                                fontSize: 14.0,
                                weight: FontWeight.normal,
                              )),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppPages.signUpScreen);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: RichText(
                      text: TextSpan(
                        text: "new_user".tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          fontFamily: 'JosefinSans',
                          color: AppColors.color61,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: " "),
                          TextSpan(
                              text: "sign_up".tr,
                              style: const TextStyle(
                                fontFamily: 'JosefinSans',
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ]))
        ],
      ),
    ));
  }
}
