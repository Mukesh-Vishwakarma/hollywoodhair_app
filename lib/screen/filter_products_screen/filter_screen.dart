import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/no_data.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/src/product/product.dart';

import '../../util/theme_service.dart';
import 'filter_controller.dart';

class FilterProductScreen extends GetView<FilterProductController> {
  const FilterProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ));
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: bodyWidget(),
    );
  }

  bodyWidget() {
    return Obx(() => !controller.isPageLoad.value
        ? controller.products.value.isEmpty
            ? Center(
                child: NoDataScreen(
                  title: "Empty",
                ),
              )
            : Column(
              children: [
                Container(
                  height: 120,
                  width: Get.size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  // padding: EdgeInsets.only(top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 22,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 80.w,
                              height: 50,
                              child: TextFormField(
                                focusNode: controller.focusNode,
                                onTap: () {},
                                controller: controller.searchController,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    print("skzmxzkm==> $value");
                                    controller.searchText.value = true;
                                    controller.onSearchTextChanged(value);
                                  } else {
                                    controller.searchText.value = false;
                                    controller.searchController.clear();
                                    controller.focusNode.unfocus();
                                    controller.searchedProduct.value = [];
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.all(15.0),
                                  suffixIcon: Obx(
                                        () => controller.searchText.isTrue
                                        ? GestureDetector(
                                        onTap: () {
                                          controller.searchController
                                              .clear();
                                          controller.isLoadPage.value =
                                          true;
                                          controller.searchedProduct
                                              .value = [];
                                          controller.focusNode
                                              .unfocus();
                                        },
                                        child: SvgPicture.asset(
                                          Assets.cross,
                                        )).marginOnly(right: 10)
                                        : const SizedBox(),
                                  ),
                                  suffixIconConstraints:
                                  const BoxConstraints(
                                      minHeight: 30, minWidth: 30),
                                  hintText: "Search here",
                                  hintStyle: AppStyles.textStyle(
                                      weight: FontWeight.w400,
                                      fontSize: 14.0,
                                      color: AppColors.searchHintColor),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          AppColors.searchBorderColor)),
                                  errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.red2C)),
                                  focusedErrorBorder:
                                  const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors
                                              .searchBorderColor)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          AppColors.searchBorderColor)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.primaryColor)),
                                ),
                                cursorColor: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          left: 10,
                          right: 10,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: (controller.searchedProduct.isNotEmpty)
                              ? (controller.searchedProduct.length / 2).ceil()
                              : (controller.products.length / 2).ceil(),
                          itemBuilder: (context, index) {
                            // Check if the product and index are within bounds
                            if (index * 2 <
                                (controller.searchedProduct.isNotEmpty
                                        ? controller.searchedProduct
                                        : controller.products)
                                    .length) {
                              // Calculate the actual index in the product list
                              final actualIndex = index * 2;

                              // Get the product at the calculated index
                              final product =
                                  (controller.searchedProduct.isNotEmpty
                                      ? controller.searchedProduct
                                      : controller.products)[actualIndex];

                              return Row(
                                children: [
                                  Expanded(
                                    child:
                                        commonProductWidget(product, actualIndex),
                                  ),
                                  const SizedBox(width: 10),
                                  // Add spacing between items
                                  if (actualIndex + 1 <
                                      (controller.searchedProduct.isNotEmpty
                                              ? controller.searchedProduct
                                              : controller.products)
                                          .length)
                                    Expanded(
                                      child: commonProductWidget(
                                        (controller.searchedProduct.isNotEmpty
                                            ? controller.searchedProduct
                                            : controller
                                                .products)[actualIndex + 1],
                                        actualIndex + 1,
                                      ),
                                    ),
                                ],
                              );
                            } else {
                              return Container(); // Empty item
                            }
                          },
                        ),
                      ),
                    ),
                ),
              ],
            )
        : shimmerDemo());
  }

  commonProductWidget(Product productsFilterList, index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppPages.allProductDetailsScreen,
            arguments: {"product_id": productsFilterList.id.toString()});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: controller.networkImageWithLoader(
                  userProfile: productsFilterList.image.isNotEmpty
                      ? productsFilterList.image.toString()
                      : Assets.upload ?? "")),
          const SizedBox(height: 10),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 200, // Set your desired maximum width
            ),
            child: Text(
              productsFilterList.title.toString(),
              overflow: TextOverflow.ellipsis,
              style: AppStyles.textStyle(
                weight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                productsFilterList.formattedPrice,
                // controller.productList[index].variants![0].price.toString(),
                style: AppStyles.textStyle(
                  weight: FontWeight.w500,
                  color: AppColors.black84,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                productsFilterList.compareAtPriceFormatted,
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
    ).marginOnly(top: 5);
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
