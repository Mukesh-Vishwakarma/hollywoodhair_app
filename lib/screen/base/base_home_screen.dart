import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/screen/base/cart_screen/cart_controller.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/theme_service.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../util/assets.dart';
import '../../util/route/app_pages.dart';
import 'base_home_controller.dart';

class BaseHomeScreen extends GetView<BaseHomeController> {
  const BaseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Transform(
          transform: Matrix4.diagonal3Values(1, 1.028, 1),
          child: Obx(
            () => controller.baseChildren[controller.selectedIndex.value],
          ),
        ),
        bottomNavigationBar: Obx(
          () => Platform.isIOS
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: Adaptive.h(10.0),
                      width: 100.w,
                      child: Image.asset(
                        Assets.navBar,
                        // height: Adaptive.h(31.0),
                        height: 100,
                        width: 100.w,
                        fit: BoxFit
                            .fitWidth, // This property scales the image to cover the container
                      ),
                    ).marginOnly(bottom: 30),
                    BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      selectedItemColor: AppColors.primaryColorDark,
                      currentIndex: controller.selectedIndex.value,
                      selectedFontSize: 13,
                      // Set a custom font size for selected tabs
                      unselectedFontSize: 13,
                      // Set a custom font size for unselected tabs
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: ThemeService().loadThemeFromBox()
                                ? SvgPicture.asset(
                                    controller.selectedIndex.value == 0
                                        ? Assets.homeIconSl
                                        : Assets.homeIconUl,
                                  )
                                : SvgPicture.asset(
                                    controller.selectedIndex.value == 0
                                        ? Assets.homeIconSl
                                        : Assets.homeIconUl,
                                  ),
                          ),
                          label: "home".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: ThemeService().loadThemeFromBox()
                                    ? SvgPicture.asset(
                                        controller.selectedIndex.value == 1
                                            ? Assets.bookingIconSl
                                            : Assets.bookingIconUl,
                                      )
                                    : SvgPicture.asset(
                                        controller.selectedIndex.value == 1
                                            ? Assets.bookingIconSl
                                            : Assets.bookingIconUl,
                                      ),
                              ),
                              if (controller.totalMessageCount.value
                                      .toString() !=
                                  "0")
                                Transform(
                                  transform:
                                      Matrix4.translationValues(14, -3, 0),
                                  child: IntrinsicWidth(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.red,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0,
                                            right: 5.0,
                                            top: 2.0,
                                            bottom: 2.0),
                                        child: Center(
                                            child: Text(
                                          controller.totalMessageCount.value,
                                          style: const TextStyle(
                                              fontSize: 9, color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          label: "booking".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                height: 30,
                              )),
                          label: "try_on".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: ThemeService().loadThemeFromBox()
                                ? SvgPicture.asset(
                                    controller.selectedIndex.value == 3
                                        ? Assets.cartIconSl
                                        : Assets.cartIconUl,
                                  )
                                : SvgPicture.asset(
                                    controller.selectedIndex.value == 3
                                        ? Assets.cartIconSl
                                        : Assets.cartIconUl,
                                  ),
                          ),
                          label: "cart".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: ThemeService().loadThemeFromBox()
                                ? SvgPicture.asset(
                                    controller.selectedIndex.value == 4
                                        ? Assets.profileIconSl
                                        : Assets.profileIconUl,
                                  )
                                : SvgPicture.asset(
                                    controller.selectedIndex.value == 4
                                        ? Assets.profileIconSl
                                        : Assets.profileIconUl,
                                  ),
                          ),
                          label: "profile".tr,
                        ),
                      ],
                      onTap: (index) {
                        if (index != 2) {
                          controller.onItemSelect(index);
                          controller.baseChildren.refresh();
                          switch (index) {
                            case 3:
                              Get.find<CartController>().onInit();
                              break;
                          }
                        }
                      },
                    ),
                    Positioned(
                      // Positioned to adjust the position of the FAB on top of the BottomNavigationBar
                      bottom: Adaptive.h(6.4), // Adjust this value as needed
                      child: Transform.scale(
                        scale: 0.95,
                        child: FloatingActionButton(
                          elevation: 1,
                          onPressed: () {
                            Get.toNamed(AppPages.tryOn);
                          },
                          backgroundColor: Colors.black,
                          // Set the background color of the FAB
                          child: SvgPicture.asset(Assets.scanIcon),
                        ),
                      ),
                    ),
                  ],
                )
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 85,
                      width: 400,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey, // Shadow color
                            blurRadius: 100, // Spread of the shadow
                            offset:
                                Offset(0, 100), // Offset in x and y direction
                          ),
                        ],
                        borderRadius: BorderRadius.circular(
                            8), // Border radius for the container
                      ),
                      child: Image.asset(
                        Assets.navBar,
                        fit: BoxFit
                            .fitWidth, // This property scales the image to cover the container
                      ),
                    ),
                    BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      selectedItemColor: AppColors.primaryColorDark,
                      currentIndex: controller.selectedIndex.value,
                      selectedFontSize: 13,
                      // Set a custom font size for selected tabs
                      unselectedFontSize: 13,
                      // Set a custom font size for unselected tabs
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: ThemeService().loadThemeFromBox()
                                ? SvgPicture.asset(
                                    controller.selectedIndex.value == 0
                                        ? Assets.homeIconSl
                                        : Assets.homeIconUl,
                                  )
                                : SvgPicture.asset(
                                    controller.selectedIndex.value == 0
                                        ? Assets.homeIconSl
                                        : Assets.homeIconUl,
                                  ),
                          ),
                          label: "home".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: ThemeService().loadThemeFromBox()
                                    ? SvgPicture.asset(
                                        controller.selectedIndex.value == 1
                                            ? Assets.bookingIconSl
                                            : Assets.bookingIconUl,
                                      )
                                    : SvgPicture.asset(
                                        controller.selectedIndex.value == 1
                                            ? Assets.bookingIconSl
                                            : Assets.bookingIconUl,
                                      ),
                              ),
                              if (controller.totalMessageCount.value
                                      .toString() !=
                                  "0")
                                Transform(
                                  transform:
                                      Matrix4.translationValues(14, -3, 0),
                                  child: IntrinsicWidth(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.red,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0,
                                            right: 5.0,
                                            top: 2.0,
                                            bottom: 2.0),
                                        child: Center(
                                            child: Text(
                                          controller.totalMessageCount.value,
                                          style: const TextStyle(
                                              fontSize: 9, color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          label: "booking".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: ThemeService().loadThemeFromBox()
                                ? SvgPicture.asset(
                                    controller.selectedIndex.value == 2
                                        ? Assets.cartIconSl
                                        : Assets.cartIconUl,
                                  )
                                : SvgPicture.asset(
                                    controller.selectedIndex.value == 2
                                        ? Assets.cartIconSl
                                        : Assets.cartIconUl,
                                  ),
                          ),
                          label: "try_on".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: ThemeService().loadThemeFromBox()
                                ? SvgPicture.asset(
                                    controller.selectedIndex.value == 3
                                        ? Assets.cartIconSl
                                        : Assets.cartIconUl,
                                  )
                                : SvgPicture.asset(
                                    controller.selectedIndex.value == 3
                                        ? Assets.cartIconSl
                                        : Assets.cartIconUl,
                                  ),
                          ),
                          label: "cart".tr,
                        ),
                        BottomNavigationBarItem(
                          icon: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: ThemeService().loadThemeFromBox()
                                ? SvgPicture.asset(
                                    controller.selectedIndex.value == 4
                                        ? Assets.profileIconSl
                                        : Assets.profileIconUl,
                                  )
                                : SvgPicture.asset(
                                    controller.selectedIndex.value == 4
                                        ? Assets.profileIconSl
                                        : Assets.profileIconUl,
                                  ),
                          ),
                          label: "profile".tr,
                        ),
                      ],
                      onTap: (index) {
                        if (index != 2) {
                          controller.onItemSelect(index);
                          controller.baseChildren.refresh();
                          switch (index) {
                            case 3:
                              Get.find<CartController>().onInit();
                              break;
                          }
                        }
                      },
                    ),
                    Positioned(
                      // Positioned to adjust the position of the FAB on top of the BottomNavigationBar
                      bottom: 21.0, // Adjust this value as needed
                      child: Transform.scale(
                        scale: 0.95,
                        child: FloatingActionButton(
                          elevation: 1,
                          onPressed: () {
                            Get.toNamed(AppPages.tryOn);
                          },
                          backgroundColor: Colors.black,
                          // Set the background color of the FAB
                          child: SvgPicture.asset(Assets.scanIcon),
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
