import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/common_function.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../util/theme_service.dart';
import '../util/route/app_pages.dart';
import 'our_celebrities_controller.dart';

class CelebritiesScreen extends GetView<CelebritiesController> {
  const CelebritiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CelebritiesController());
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ));
    return Obx(()=>Stack(
      children: [
        Scaffold(
              backgroundColor: AppColors.lightBackgroundColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(7.h),
                child: AppBar(
                  titleSpacing: 0,
                  elevation: 4,
                  backgroundColor: AppColors.colorFF,
                  leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.black,
                      )),
                  title: Text("celebrities".tr,
                      style: AppStyles.textStyle(
                          fontSize: 18.0, weight: FontWeight.w500)),
                ),
              ),
              body: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        bodyWidget(context),
                      ]),
                    ),

                  ],

              )),
        Visibility(
          visible: controller.isLoading.value,
          child: loaderTransparent(),
        )
      ],
    ),
    );
  }

  bodyWidget(context) {
    return SafeArea(
      child: Obx(
        () => Padding(
            padding: const EdgeInsets.all(10.0),
            child: !controller.isPageLoad.value
                ? controller.celebritiesModel.isNotEmpty
                    ? SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          width: double.infinity,
                          child: SizedBox(
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemCount:
                                  (controller.celebritiesModel.length / 2)
                                      .ceil(),
                              itemBuilder: (context, index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: transformationsWidget(index * 2),
                                    ),
                                    const SizedBox(width: 10),
                                    // Add spacing between items
                                    if (index * 2 + 1 <
                                        controller.celebritiesModel.length)
                                      Expanded(
                                        child: transformationsWidget(
                                            index * 2 + 1),
                                      ),
                                    // Check if this is the last row and there's only one item
                                    if (index ==
                                            (controller.celebritiesModel
                                                        .length /
                                                    2)
                                                .floor() &&
                                        controller.celebritiesModel.length %
                                                2 ==
                                            1)
                                      Expanded(
                                        child: Container(), // Empty item
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: noDataFound(),
                      )
                : shimmerDemo()),
      ),
    );
  }

  transformationsWidget(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            var result = await Get.toNamed(AppPages.celebritiesDetailsScreen,
                arguments: [
                  "Celebrities Details",
                  controller.celebritiesModel[index].socialLink
                ]);
            if (result=="backPress") {
              controller.isLoading.value = true;
              controller.delayedFunction();
            }
          },
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 150,
                width: 50.w,
                color: Colors.red,
                child: Image.asset(
                  controller.celebritiesModel[index].image.toString(),
                  fit: BoxFit.cover,
                ),
              )),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  shimmerDemo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        // width: 100.w,
        // height: 100.h,
        child: Shimmer.fromColors(
          baseColor: ThemeService().loadThemeFromBox()
              ? AppColors.color4A
              : Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 00),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 50.w,
                              height: 17.h,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                          Container(
                            width: 20.w,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    )
                  ],
                ).marginOnly(top: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
