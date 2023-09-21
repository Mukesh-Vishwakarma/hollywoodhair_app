import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/no_data.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../util/theme_service.dart';
import 'all_product_controller.dart';

class AllProductScreen extends GetView<AllProductController> {
  AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ));
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: AppBar(
          elevation: 0.4,
          backgroundColor: AppColors.colorFF,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.black,
              )),
          title: Obx(
            () => Text("${controller.cateName} ${"products".tr}",
                style: AppStyles.textStyle(
                    fontSize: 14.0, weight: FontWeight.w500)),
          ),
          automaticallyImplyLeading: false,
          actions: [
            // GestureDetector(
            //   onTap: () {
            //     Get.toNamed(AppPages.favouriteScreen);
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.only(right: 20.0),
            //     child: SvgPicture.asset(Assets.favouriteIcon),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset(Assets.searchIcon),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppPages.allProductScreen);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: SvgPicture.asset(Assets.notificationIcon),
              ),
            ),
          ],
        ),
      ),
      body: bodyWidget(),
    );
  }

  bodyWidget() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() => !controller.isPageLoad.value
            ? controller.products.value.isEmpty
                ? Center(
                    child: NoDataScreen(
                      title: "Empty",
                    ),
                  )
                : SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.products.length,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 270,
                              childAspectRatio: 3 / 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return commonProductWidget(index);
                          }),
                    ),
                  )
            : shimmerDemo()),
      ),
    );
  }




  // productsWidget() {
  //   return Container(
  //     // color: AppColors.dividerColor,
  //     child: GridView.builder(
  //         physics: const BouncingScrollPhysics(),
  //         shrinkWrap: true,
  //         itemCount: controller.products.length,
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //             childAspectRatio: 4 / 4.4,
  //             crossAxisCount: 2,
  //             crossAxisSpacing: 0,
  //             mainAxisSpacing: 0),
  //         itemBuilder: (context, index) {
  //           return commonProductWidget(index);
  //         }),
  //   );
  // }

  commonProductWidget(index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppPages.allProductDetailsScreen, arguments: {
          "product_id": controller.products[index].id.toString()
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: controller.networkImageWithLoader(
    userProfile:
    controller.products[index].image.isNotEmpty
        ? controller.products[index].image.toString()
        : Assets.upload ?? "")),
          const SizedBox(height: 10),
          Text(
            controller.products[index].title.toString(),
            overflow: TextOverflow.ellipsis,
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          Row(
            children: [
              Text(
                controller.products[index].formattedPrice,
                // controller.productList[index].variants![0].price.toString(),
                style: AppStyles.textStyle(
                  weight: FontWeight.w500,
                  color: AppColors.black84,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                controller.products[index].compareAtPriceFormatted,
                // controller.productList[index]..toString(),
                style: AppStyles.textStyle(
                  weight: FontWeight.w400,
                  fontSize: 11.0,
                  color: AppColors.grayC4,
                  decoration: TextDecoration.lineThrough,
                  // decorationColor: AppColors.gray95
                ),
              ),
            ],
          ),
          // const SizedBox(height: 6),
        ],
      ),
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
                    SizedBox(width: 10,),
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
                    SizedBox(width: 10,),
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
                    SizedBox(width: 10,),
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
