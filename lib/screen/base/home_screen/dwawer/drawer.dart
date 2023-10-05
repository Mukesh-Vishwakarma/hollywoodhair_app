import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../util/app_colors.dart';
import '../../../../util/app_style.dart';
import '../../../../util/res_dimens.dart';
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
                        size: 20,
                      ),
                      onTap: () {
                        Get.back();
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 24),
                      child: Text("Menu",
                          style: AppStyles.textStyle(fontSize: dimen15)),
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
                  onTap: (){
                    Get.toNamed(AppPages.ourSalons);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("our_saloons".tr,
                          style: AppStyles.textStyle(
                            fontSize: dimen12, weight: FontWeight.w400,)
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Icon(Icons.arrow_forward_ios,
                          size: 15,),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
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
                            fontSize: dimen12,
                            weight: FontWeight.w400,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Icon(Icons.arrow_forward_ios,
                          size: 15,),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
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
                            fontSize: dimen12,
                            weight: FontWeight.w400,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Icon(Icons.arrow_forward_ios,
                          size: 15,),
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
