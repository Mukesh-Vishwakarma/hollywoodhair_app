import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../util/app_colors.dart';
import '../../../../util/app_style.dart';
import '../../../../util/route/app_pages.dart';

class DrawerLayout extends StatefulWidget {
  const DrawerLayout({super.key});

  @override
  State<DrawerLayout> createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  border: Border(
                      bottom: BorderSide(width: 2, color: Colors.transparent))),
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.arrow_back,
                        size: 25,
                      ),
                      onTap: () {
                        Get.back();
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text("Menu",
                          style: AppStyles.textStyle(fontSize: 20.0)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPages.ourSalons);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("our_saloons".tr,
                          style: AppStyles.textStyle(
                            fontSize: 16.0,
                            weight: FontWeight.w400,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPages.ourTransformations);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("transformation".tr,
                          style: AppStyles.textStyle(
                            fontSize: 16.0,
                            weight: FontWeight.w400,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPages.celebritiesScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("celebrities".tr,
                          style: AppStyles.textStyle(
                            fontSize: 16.0,
                            weight: FontWeight.w400,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPages.contactScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("contact_us".tr,
                          style: AppStyles.textStyle(
                            fontSize: 16.0,
                            weight: FontWeight.w400,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppPages.languagesScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("languages".tr,
                          style: AppStyles.textStyle(
                            fontSize: 16.0,
                            weight: FontWeight.w400,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
