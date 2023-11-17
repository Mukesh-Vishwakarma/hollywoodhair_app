import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/screen/base/profile/settings/my_appointment/my_appointment_controller.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: AppBar(
            backgroundColor: AppColors.colorFF,
            title: Text("Profile".tr,
                style: AppStyles.textStyle(
                    fontSize: 20.0, weight: FontWeight.w500)),
            automaticallyImplyLeading: false,
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 205,
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
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                height: 100,
                                width: 100,
                                child: Center(
                                  child: Obx(()=> Text(
                                        controller.shortName.value.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 30.0,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                // child: Obx(() => getProfileImage()),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Obx(() => Text(
                                controller.userName.toString(),
                                style: AppStyles.textStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    weight: FontWeight.w500))),
                          ),
                          Obx(() => controller.phoneNumber.value != null
                              ? Flexible(
                                child: Text(
                                    controller.phoneNumber.value.toString(),
                                    style: AppStyles.textStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        weight: FontWeight.w400)),
                              )
                              : Container()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                splashColor: Colors.transparent,
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
                              fontSize: 16.0,
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
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider(),
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  // Get.put(MyAppointmentController());
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
                              fontSize: 16.0,
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
                splashColor: Colors.transparent,
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
                              fontSize: 16.0,
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
                splashColor: Colors.transparent,
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
                              fontSize: 16.0,
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
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("rate_us".tr,
                          style: AppStyles.textStyle(
                            fontSize: 16.0,
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
