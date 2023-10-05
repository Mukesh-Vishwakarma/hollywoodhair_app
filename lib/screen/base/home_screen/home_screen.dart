import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:sizer/sizer.dart';

import '../../../model/featured_products_model.dart';
import '../../../util/theme_service.dart';
import 'dwawer/drawer.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ));
    return Scaffold(
      key: controller.key,
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: AppColors.colorFF,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 15,
            ),
            Image.asset(Assets.appLogo),
            const SizedBox(
              width: 10,
            ),
            Image.asset(Assets.appNameVertical),
          ],
        ),
        leading: GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(left: 23, right: 10),
            child: const Image(
              image: AssetImage(Assets.menuBar),
            ),
          ),
          onTap: () {
            print("hello");
            controller.key.currentState!.openDrawer();
          },
        ),
        automaticallyImplyLeading: false,
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 20.0),
          //   child: InkWell(
          //       onTap: () {}, child: SvgPicture.asset(Assets.favouriteIcon)),
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
                onTap: () {
                  Get.toNamed(AppPages.notificationScreen);
                },
                child: SvgPicture.asset(Assets.notificationIcon)),
          ),
        ],
      ),
      drawer: const DrawerLayout(),
      backgroundColor: AppColors.lightBackgroundColor,
      body: bodyWidget(),
    );
  }

  bodyWidget() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              color: AppColors.backGroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchBar(),
                  const SizedBox(height: 20),
                  Image.asset(
                    Assets.dummyBanner,
                    fit: BoxFit.cover,
                    width: 100.w,
                    height: 180,
                  ),
                  const SizedBox(height: 20),
                  categoriesListWidget(),
                  const SizedBox(height: 0),
                  productsWidget(),
                  const SizedBox(height: 20),
                  featuredProductsList(),
                  const SizedBox(height: 20),
                  saloonList(),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  searchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
          color: AppColors.backGroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.searchBorderColor, width: 1.0)),
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 14),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(Assets.searchIcon),
            const SizedBox(width: 10),
            Container(
              height: 52,
              width: 80.w,
              child: Center(
                child: TextFormField(
                  onTap: () {
                    Get.toNamed(AppPages.searchProductScreen);
                  },
                  controller: controller.searchController,
                  onChanged: (value) {
                    // text = value;
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    isDense: true,
                    // contentPadding: const EdgeInsets.all(15),
                    hintText: "Search for “Shampoo”",
                    hintStyle: AppStyles.textStyle(
                        weight: FontWeight.w400,
                        fontSize: 12.0,
                        color: AppColors.searchHintColor),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  style: AppStyles.textStyle(
                    weight: FontWeight.w400,
                    fontSize: 16.0,
                  ),
                  cursorColor: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Popular products
  productsWidget() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'popular_product'.tr,
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 17.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() => controller.topProduct.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 2,
                    // Change the number of columns as needed
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children:
                        List.generate(controller.topProduct.length, (index) {
                      return commonProductWidget(
                          productList: controller.topProduct.value[index]);
                    }),
                  ),
                )
              : shimmerDemo()),
        ]);
  }

  commonProductWidget({required Product productList}) {
    return GestureDetector(
      onTap: () {
        print("jhdsvjxzhbjkj===> ${productList.id}");
        Get.toNamed(
          AppPages.allProductDetailsScreen,
          arguments: {"product_id": productList.id},
        );
        controller.getFindController();
      },
      child: Container(
        width: 20.w,
        height: 20.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: controller.networkImageWithLoader(
                      userProfile: productList.image ?? ""),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              productList.title,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.textStyle(
                weight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            Row(
              children: [
                Text(
                  productList.formattedPrice,
                  style: AppStyles.textStyle(
                    weight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  productList.compareAtPriceFormatted,
                  style: AppStyles.textStyle(
                    weight: FontWeight.w300,
                    fontSize: 11.0,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ).marginOnly(top: 5),
          ],
        ),
      ),
    );
  }

  // Category
  categoriesListWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'explore_by_categories'.tr,
          style: AppStyles.textStyle(
            weight: FontWeight.w500,
            fontSize: 17.0,
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => controller.collectionList.isNotEmpty
              ? SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.collectionList.length,
                    itemBuilder: (context, index) {
                      return Obx(() => categoriesWidget(
                          controller.collectionList.value[index]));
                    },
                  ),
                )
              : shimmerCategory(),
        ),
      ],
    );
  }

  categoriesWidget(Collection categoryItem) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppPages.allProductScreen, arguments: {
          "categoryName": categoryItem.title,
          "categoryId": categoryItem.id,
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: IntrinsicWidth(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: AppColors.primaryColor, width: 1.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: controller.networkImageCategory(
                        userProfile: categoryItem.imageUrl ?? ""),
                  ).marginAll(3),
                ),
                Flexible(
                  child: Container(
                    width: 80,
                    child: Text(
                      categoryItem.title,
                      textAlign: TextAlign.center, // Center-align the text
                      style: AppStyles.textStyle(
                          weight: FontWeight.w500,
                          fontSize: 12.5,
                          color:
                              controller.selectCategories.value == categoryItem
                                  ? AppColors.lightBackgroundColor
                                  : AppColors.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///  Saloons
  saloonList() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'our_salons'.tr,
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 17.0,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() => !controller.pageLoaderSalon.value
              ? SizedBox(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 2,
                    // Change the number of columns as needed
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children:
                        List.generate(controller.allSaloonList.length, (index) {
                      return salonWidget(index);
                    }),
                  ),
                )
              : shimmerDemo()),
        ]);
  }

  salonWidget(index) {
    return GestureDetector(
      onTap: () {
        print("sjkhzxnhcnjx");
        if (controller.allSaloonList[index].latitude != null) {
          controller.openMap(controller.allSaloonList[index].latitude,
              controller.allSaloonList[index].latitude);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: controller.networkImageSalons(
                  image:
                      controller.allSaloonList[index].salonPicture.toString())),
          Text(
            controller.allSaloonList[index].salonAddress.toString(),
            overflow: TextOverflow.ellipsis,
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    );
  }

  ///  Featured products
  featuredProductsList() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'featured_products'.tr,
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 17.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() => !controller.pageLoaderFeaturedStatus.value
              ? SizedBox(
                  width: double.infinity,
                  child: GridView.count(
                    crossAxisCount: 2,
                    // Change the number of columns as needed
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                        controller.allFeaturedProductsList.length, (index) {
                      return featuredProductsWidget(
                          featuredData:
                              controller.allFeaturedProductsList[index]);
                    }),
                  ),
                )
              : shimmerDemo()),
        ]);
  }

  featuredProductsWidget({required FeaturedData featuredData}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppPages.allProductDetailsScreen,
          // arguments: {"product_id": featuredData.productId.toString()},
          arguments: {"product_id": "gid://shopify/Product/8678460752207"},// added static product id because upcoming produce id is not valid
        );
        controller.getFindController();
      },
      child: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.grayEB,
                        // Adjust the color to your preference
                        width: 1.0, // Adjust the border width
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: controller.networkImageWithLoader(
                        userProfile: featuredData.productImage ?? ""),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              featuredData.productName.toString(),
              overflow: TextOverflow.ellipsis,
              style: AppStyles.textStyle(
                weight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            Row(
              children: [
                Text(
                  featuredData.productPrice.toString(),
                  style: AppStyles.textStyle(
                    weight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ).marginOnly(top: 5),
          ],
        ),
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
                    SizedBox(
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

  shimmerCategory() {
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
            // scrollDirection: Axis.horizontal,
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
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50,
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
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 10.0,
                            color: Colors.white,
                          ).marginOnly(top: 10),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ).marginOnly(top: 00),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
