import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/no_data.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/models.dart';

import 'search_product_controller.dart';

class SearchProductScreen extends GetView<SearchProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          controller.focusNode.unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: Get.size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 80.w,
                          height: 50,
                          child: TextFormField(
                            focusNode: controller.focusNode,
                            onTap: () {},
                            controller: controller.searchController,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                controller.searchText.value = true;
                                controller.searchProducts(value);
                              }
                              if (value.isEmpty) {
                                controller.searchText.value = false;
                                controller.searchController.clear();
                                controller.focusNode.unfocus();
                                controller.searchedProduct.value = [];
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15.0),
                              suffixIcon: Obx(
                                () => controller.searchText.isTrue
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.searchController.clear();
                                          controller.isLoadPage.value = true;
                                          controller.searchedProduct.value = [];
                                          controller.focusNode.unfocus();
                                        },
                                        child: SvgPicture.asset(
                                          Assets.cross,
                                        )).marginOnly(right: 10)
                                    : const SizedBox(),
                              ),
                              suffixIconConstraints:
                                  const BoxConstraints(minHeight: 30, minWidth: 30),
                              hintText: "search here",
                              hintStyle: AppStyles.textStyle(
                                  weight: FontWeight.w400,
                                  fontSize: 12.0,
                                  color: AppColors.searchHintColor),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.searchBorderColor)),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.red2C)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.searchBorderColor)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.searchBorderColor)),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => !controller.isLoadPage.value
                          ? controller.searchedProduct.isEmpty
                              ? SizedBox(
                                  height: 80.h,
                                  child: Center(
                                      child: NoDataScreen(
                                    image: Assets.noResult,
                                    height: 80,
                                    width: 80,
                                    title: "No Results Found",
                                    description:
                                        "\"We were unable to locate the product you are searching for.\"",
                                  )),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.searchedProduct.length,
                                  itemBuilder: (context, index) {
                                    return listTile(
                                        item: controller
                                            .searchedProduct.value[index]);
                                  })
                          : Container(
                              height: 80.h,
                              child: Center(
                                  child: NoDataScreen(
                                title: "Nothing Searched Yet",
                                image: Assets.nothingSearch,
                                height: 180,
                                width: 180,
                              )),
                            )),
                      Obx(() => Visibility(
                            visible: controller.isPageLoad.value ? true : false,
                            child: Container(
                              child: const Text("Loading..."),
                            ).marginOnly(top: 30, bottom: 30),
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  listTile({required Product item}) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppPages.allProductDetailsScreen, arguments: {"product_id": item.id});
      },
      child: Row(
        children: [
          Image.network(
            item.image,
            height: 100,
            width: 100,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: IntrinsicWidth(
                      child: Text(
                        item.title,
                        style: AppStyles.textStyle(
                          fontSize: 13.0,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.formattedPrice,
                    style: AppStyles.textStyle(
                      fontSize: 12.0,
                      weight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ).marginOnly(top: 10),
    );

  }

  Widget buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildEndMessage() {
    return Center(
      child: Text('No more items to load.'),
    );
  }

  shimmerDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.size.width,
          height: Get.size.height,
          margin:
              const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: ListView.builder(
              itemBuilder: (__, _) => Padding(
                padding:
                    const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.0),
                          ),
                          Container(
                            width: Get.size.width,
                            height: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              itemCount: 3,
            ),
          ),
        ),
        Divider()
      ],
    );
  }

  historyText(index) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppPages.allProductDetailsScreen, arguments: {
          "product_id": controller.searchedProduct[index].id.toString()
        });
      },
      child: Container(
          margin: EdgeInsets.only(left: 10, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                child: Text(
                  controller.searchedProduct[index].title.toString(),
                  style: AppStyles.textStyle(
                    weight: FontWeight.w400,
                    fontSize: 16.0,
                  ),
                ),
              )),
            ],
          )),
    );
  }
}
