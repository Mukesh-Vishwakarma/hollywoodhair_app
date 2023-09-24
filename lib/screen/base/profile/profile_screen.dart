import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';

import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: AppColors.colorFF,
            title: Text("Profile".tr,
                style: AppStyles.textStyle(
                    fontSize: dimen15, weight: FontWeight.w500)),
            automaticallyImplyLeading: false,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: Get.size.width,
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      Assets.profileBackground,
                      fit: BoxFit.fitWidth,

                      width: Get.size.width,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Obx(() => getProfileImage()),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => Text(
                                controller.userName.toString(),
                                style: AppStyles.textStyle(
                                    fontSize: dimen14,
                                    color: Colors.white,
                                    weight: FontWeight.w500))),
                          ),
                          Obx(() => controller.phoneNumber.value != null
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Text(
                                      controller.phoneNumber.value.toString(),
                                      style: AppStyles.textStyle(
                                          color: Colors.white,
                                          fontSize: dimen12,
                                          weight: FontWeight.w400)),
                                )
                              : Container()),
                          // GestureDetector(
                          //   onTap: () {
                          //     controller.editScreenRoute();
                          //     // Get.toNamed(AppPages.editProfileScreen);
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Image.asset(
                          //       Assets.editText,
                          //       height: 20,
                          //       width: 100,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppPages.myOrderScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("my_orders".tr,
                            style: AppStyles.textStyle(
                              fontSize: dimen12,
                              weight: FontWeight.w400,
                            )),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 10),
                        child: Image.asset(
                          Assets.arrowLeft,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppPages.myAppointmentScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("my_appointment".tr,
                            style: AppStyles.textStyle(
                              fontSize: dimen12,
                              weight: FontWeight.w400,
                            )),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 10),
                        child: Image.asset(
                          Assets.arrowLeft,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppPages.addAddressScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("address".tr,
                            style: AppStyles.textStyle(
                              fontSize: dimen12,
                              weight: FontWeight.w400,
                            )),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 10),
                        child: Image.asset(
                          Assets.arrowLeft,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppPages.settingScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("setting".tr,
                            style: AppStyles.textStyle(
                              fontSize: dimen12,
                              weight: FontWeight.w400,
                            )),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 10),
                        child: Image.asset(
                          Assets.arrowLeft,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(),
              ),

/*
              Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 5),
                child: Row(
                  children: [

                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("chatbot".tr,
                          style: AppStyles.textStyle(
                            fontSize: dimen12, weight: FontWeight.w400,)

                      ),
                    )),


                    Padding(
                      padding: const EdgeInsets.only(right: 20,top: 10),
                      child: Image.asset(Assets.arrowLeft,height: 30,width: 30,),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Divider(),
              ),*/

              // Padding(
              //   padding: const EdgeInsets.only(top: 5, bottom: 5),
              //   child: Row(
              //     children: [
              //       Expanded(
              //           child: Padding(
              //         padding: const EdgeInsets.only(left: 20),
              //         child: Text("my_cart".tr,
              //             style: AppStyles.textStyle(
              //               fontSize: dimen12,
              //               weight: FontWeight.w400,
              //             )),
              //       )),
              //       Padding(
              //         padding: const EdgeInsets.only(right: 20, top: 10),
              //         child: Image.asset(
              //           Assets.arrowLeft,
              //           height: 30,
              //           width: 30,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20),
              //   child: Divider(),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5, bottom: 5),
              //   child: Row(
              //     children: [
              //       Expanded(
              //           child: Padding(
              //         padding: const EdgeInsets.only(left: 20),
              //         child: Text("my_wishlist".tr,
              //             style: AppStyles.textStyle(
              //               fontSize: dimen12,
              //               weight: FontWeight.w400,
              //             )),
              //       )),
              //       Padding(
              //         padding: const EdgeInsets.only(right: 20, top: 10),
              //         child: Image.asset(
              //           Assets.arrowLeft,
              //           height: 30,
              //           width: 30,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20),
              //   child: Divider(),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("rate_us".tr,
                          style: AppStyles.textStyle(
                            fontSize: dimen12,
                            weight: FontWeight.w400,
                          )),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 10),
                      child: Image.asset(
                        Assets.arrowLeft,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ));
  }

  Widget getProfileImage() {
    if (controller.urlImage.isNotEmpty) {
      return ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: Assets.imagesIcUser,
          fit: BoxFit.cover,
          image: controller.urlImage.value,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              Assets.imagesIcUser,
            );
          },
        ),
      );
    } else {
      return Image.asset(
        Assets.imagesIcUser,
      );
    }
  }
}
