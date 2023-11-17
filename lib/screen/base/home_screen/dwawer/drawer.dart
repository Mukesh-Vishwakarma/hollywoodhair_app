import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../util/app_colors.dart';
import '../../../../util/app_constants.dart';
import '../../../../util/app_style.dart';
import '../../../../util/assets.dart';
import '../../../../util/route/app_pages.dart';

class DrawerLayout extends StatefulWidget {
  const DrawerLayout({super.key});

  @override
  State<DrawerLayout> createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {
  var userName = GetStorage().read(AppConstants.userName);
  var shortName = '';

  @override
  void initState() {
    String fullName = userName;
    List<String> words = fullName.split(" ");
    List<String> initials = words.map((word) => word.substring(0, 1)).toList();
    shortName = initials.join();

    super.initState();
  }

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
                    // GestureDetector(
                    //   child: const Icon(
                    //     Icons.arrow_back,
                    //     size: 25,
                    //   ),
                    //   onTap: () {
                    //     Get.back();
                    //   },
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                height: 60,
                                width: 60,
                                child: Center(
                                  child: Text(
                                    shortName.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 30.0,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                // child: Obx(() => getProfileImage()),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(userName.toString(),
                                style: AppStyles.textStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    weight: FontWeight.w500)),
                          ).marginOnly(left: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
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
                                child: Text("my_orders".tr,
                                    style: AppStyles.textStyle(
                                      fontSize: 16.0,
                                      weight: FontWeight.w400,
                                    ))),
                            Image.asset(
                              Assets.arrowLeft,
                              height: 30,
                              width: 30,
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
                                child: Text("my_appointment".tr,
                                    style: AppStyles.textStyle(
                                      fontSize: 16.0,
                                      weight: FontWeight.w400,
                                    ))),
                            Image.asset(
                              Assets.arrowLeft,
                              height: 30,
                              width: 30,
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
                        Get.toNamed(AppPages.addAddressScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("address".tr,
                                    style: AppStyles.textStyle(
                                      fontSize: 16.0,
                                      weight: FontWeight.w400,
                                    ))),
                            Image.asset(
                              Assets.arrowLeft,
                              height: 30,
                              width: 30,
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
                        Get.toNamed(AppPages.settingScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("setting".tr,
                                    style: AppStyles.textStyle(
                                      fontSize: 16.0,
                                      weight: FontWeight.w400,
                                    ))),
                            Image.asset(
                              Assets.arrowLeft,
                              height: 30,
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text("rate_us".tr,
                                  style: AppStyles.textStyle(
                                    fontSize: 16.0,
                                    weight: FontWeight.w400,
                                  ))),
                          Image.asset(
                            Assets.arrowLeft,
                            height: 30,
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppPages.ourSalons);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("our_saloons".tr,
                                style: AppStyles.textStyle(
                                  fontSize: 16.0,
                                  weight: FontWeight.w400,
                                )),
                            Image.asset(
                              Assets.arrowLeft,
                              height: 30,
                              width: 30,
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
                      onTap: () {
                        Get.toNamed(AppPages.ourTransformations);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("transformation".tr,
                                style: AppStyles.textStyle(
                                  fontSize: 16.0,
                                  weight: FontWeight.w400,
                                )),
                            Image.asset(
                              Assets.arrowLeft,
                              height: 30,
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Divider(),
                    ),
                    /*InkWell(
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
                    ),*/
                    /*InkWell(
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
                          Image.asset(
                            Assets.arrowLeft,
                            height: 30,
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Divider(),
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
                          Image.asset(
                            Assets.arrowLeft,
                            height: 30,
                            width: 30,
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
