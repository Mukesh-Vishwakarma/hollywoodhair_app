import 'dart:io';

import 'package:camera/camera.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/screen/tryOn_screen/tryOn_controller.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/no_data.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:sizer/sizer.dart';

class TryOnScreen extends GetView<TryOnController> {
  const TryOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.black,
        child: Obx(
              () =>
              Container(
                child: Stack(
                  children: [
                    SizedBox(
                      child: controller.noDataFound.isFalse
                          ? CameraPreview(controller.cameraController)
                          : NoDataScreen(),
                    ),
                    Positioned(
                      top: 50,
                      left: 15,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppPages.baseScreen);
                        },
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.black.withOpacity(0.35)),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.lightBackgroundColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),


                    Positioned(
                      bottom: 0,
                      child: Container(
                        color: AppColors.transparentBlack ,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 100.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.toggleDirection();
                                      controller.startCamera(controller.direction.value);
                                    },
                                    child: Container(
                                      // margin: EdgeInsets.only(left: 87, top: 22),
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.white, width: 1),
                                      ),
                                      child: const Icon(
                                        Icons.cached,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ).marginOnly(right: 30),
                                  InkWell(
                                    onTap: () {
                                      controller.cameraController
                                          .takePicture()
                                          .then((XFile? file) {
                                        if (file != null) {
                                          controller.captureImage.value = File("");
                                          controller.captureImage.value = File(file.path);
                                          print("Picture saved to ${file.path}");
                                          Get.toNamed(AppPages.imagePreview);
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black, width: 3),
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white, width: 1),
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: const Icon(
                                      Icons.videocam_outlined,
                                      color: Colors.white,
                                    ),
                                  ).marginOnly(left: 30),
                                ],
                              ).marginOnly(top: 17),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                color: AppColors.gray4D,
                              ),
                              child: Container(
                                width: 100.w,
                                margin: const EdgeInsets.only(top: 1.5),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                  ),
                                  color: Colors.black,
                                ),
                                child: Column(
                                  children: [
                                    Obx(
                                          () =>
                                      ChipsChoice<int>.single(
                                        value: controller.tag.value,
                                        onChanged: (val) {
                                          print(val);
                                          controller.tag.value = val;
                                        },
                                        choiceItems: C2Choice.listFrom<int, String>(
                                          source: controller.styleList,
                                          value: (index, item) => index,
                                          label: (index, item) => item,
                                        ),
                                        choiceStyle: C2ChipStyle.filled(
                                          height: 28,
                                          foregroundSpacing: 10,
                                          margin: EdgeInsets.only(left: 28, right: 18),
                                          foregroundStyle: AppStyles.textStyle(
                                              fontSize: 14.0,
                                              weight: FontWeight.w500,
                                              color: Colors.white),
                                          borderRadius:
                                          const BorderRadius.all(Radius.circular(30)),
                                          selectedStyle: C2ChipStyle.filled(
                                            color: AppColors.gray4D,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      height: 1.0,
                                      color: AppColors.gray4D,
                                      thickness: 1,
                                    ),
                                    const SizedBox(
                                      height: 17,
                                    ),
                                    Container(
                                      color: Colors.black,
                                      height: 60,
                                      width: 100.w,
                                      child: Center(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controller.imageList.length,
                                            itemBuilder: (context, position) {
                                              return Stack(
                                                children: [
                                                  Container(
                                                    margin:
                                                    EdgeInsets.only(right: 10, left: 10),
                                                    child: DottedBorder(
                                                      color: position == 1
                                                          ? AppColors.red84
                                                          : Colors.transparent,
                                                      radius: Radius.circular(50),
                                                      strokeWidth: 2,
                                                      dashPattern: [6, 6],
                                                      borderType: BorderType.Circle,
                                                      borderPadding: EdgeInsets.all(-3),
                                                      child: Center(
                                                        child: Image.asset(
                                                          controller.imageList[position],
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 35,
                                                    bottom: 0,
                                                    left: 22,
                                                    right: 0,
                                                    child: position == 0
                                                        ? Text("Brown",
                                                        style: AppStyles.textStyle(
                                                            fontSize: 10.0,
                                                            weight: FontWeight.w500,
                                                            color: Colors.white))
                                                        : const Text(""),
                                                  )
                                                ],
                                              );
                                            }),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 17,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
        ),

      ),
    );
  }
}
