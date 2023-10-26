import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/model/press_model.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/models.dart';
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
        physics: const BouncingScrollPhysics(),
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
                  celebritiesList(),
                  const SizedBox(height: 20),
                  transformationList(),
                  const SizedBox(height: 20),
                  pressList(),
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
            SizedBox(
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

  /// Category
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
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.lightBackgroundColor,
                    borderRadius: BorderRadius.circular(50),
                    border:
                        Border.all(color: AppColors.primaryColor, width: 1.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: controller.networkImageCategory(
                      userProfile: categoryItem.imageUrl ?? ""),
                ).marginAll(3),
              ),
              Flexible(
                child: SizedBox(
                  width: 80,
                  child: Text(
                    categoryItem.title,
                    textAlign: TextAlign.center, // Center-align the text
                    style: AppStyles.textStyle(
                        weight: FontWeight.w500,
                        fontSize: 12.5,
                        color: controller.selectCategories.value == categoryItem
                            ? AppColors.lightBackgroundColor
                            : AppColors.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Popular products
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
          height: 10,
        ),
        Obx(() {
          if (controller.topProduct.isNotEmpty) {
            return SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: (controller.topProduct.value.length / 2).ceil(),
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: commonProductWidget(
                          productList: controller.topProduct.value[index * 2],
                        ),
                      ),
                      const SizedBox(width: 10), // Add spacing between items
                      if (index * 2 + 1 < controller.topProduct.value.length)
                        Expanded(
                          child: commonProductWidget(
                            productList:
                                controller.topProduct.value[index * 2 + 1],
                          ),
                        ),

                      if (index ==
                              (controller.topProduct.value.length / 2)
                                  .floor() &&
                          controller.topProduct.value.length % 2 == 1)
                        Expanded(
                          child: Container(), // Empty item
                        ),
                    ],
                  );
                },
              ),
            );
          } else {
            return shimmerDemo();
          }
        }),
      ],
    );
  }

  commonProductWidget({required Product productList}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppPages.allProductDetailsScreen,
          arguments: {"product_id": productList.id},
        );
        controller.getFindController();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: controller.networkImageWithLoader(
                userProfile: productList.image ?? ""),
          ),
          const SizedBox(height: 5),
          Text(
            productList.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
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
    ).marginOnly(top: 5);
  }

  /// Featured products
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
          height: 10,
        ),
        Obx(() => !controller.pageLoaderFeaturedStatus.value
            ? SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      (controller.allFeaturedProductsList.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: featuredProductsWidget(
                            featuredData:
                                controller.allFeaturedProductsList[index * 2],
                          ),
                        ),
                        const SizedBox(width: 10), // Add spacing between items
                        if (index * 2 + 1 <
                            controller.allFeaturedProductsList.length)
                          Expanded(
                            child: featuredProductsWidget(
                              featuredData: controller
                                  .allFeaturedProductsList[index * 2 + 1],
                            ),
                          ),
                        if (index ==
                                (controller.allFeaturedProductsList.length / 2)
                                    .floor() &&
                            controller.allFeaturedProductsList.length % 2 == 1)
                          Expanded(
                            child: Container(), // Empty item
                          ),
                      ],
                    );
                  },
                ),
              )
            : shimmerDemo()),
      ],
    );
  }

  featuredProductsWidget({required FeaturedData featuredData}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppPages.allProductDetailsScreen,
          // arguments: {"product_id": featuredData.productId.toString()},
          arguments: {
            "product_id": featuredData.adminGraphqlApiId.toString()
          }, // added static product id because upcoming produce id is not valid
        );
        controller.getFindController();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 5),
          Text(
            featuredData.title.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          Text(
            featuredData.price.toString(),
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ).marginOnly(top: 5),
        ],
      ),
    );
  }

  /// Our saloons
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
        Obx(() => !controller.pageLoaderSalon.value
            ? SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: (controller.allSaloonList.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: salonWidget(index * 2),
                        ),
                        const SizedBox(width: 10),
                        // Add spacing between items
                        if (index * 2 + 1 < controller.allSaloonList.length)
                          Expanded(
                            child: salonWidget(index * 2 + 1),
                          ),
                        // Check if this is the last row and there's only one item
                        if (index ==
                                (controller.allSaloonList.length / 2).floor() &&
                            controller.allSaloonList.length % 2 == 1)
                          Expanded(
                            child: Container(), // Empty item
                          ),
                      ],
                    );
                  },
                ),
              )
            : shimmerDemo()),
      ],
    );
  }

  salonWidget(index) {
    return GestureDetector(
      onTap: () {
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
            maxLines: 2,
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    ).marginOnly(bottom: 5);
  }

  /// Our Celebrities
  celebritiesList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'celebrities'.tr,
          style: AppStyles.textStyle(
            weight: FontWeight.w500,
            fontSize: 17.0,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          // color: Colors.red,
          height: 20.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider.builder(
                carouselController: controller.carouselController,
                itemCount: controller.celebritiesModel.length,
                itemBuilder:
                    (BuildContext context, int indexCarousel, int realIndex) {
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppPages.celebritiesScreen, arguments: [
                        "Celebrities Details",
                        controller.celebritiesModel[indexCarousel].socialLink
                      ]);
                    },
                    child: Image.asset(
                      controller.celebritiesModel[indexCarousel].image
                          .toString(),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ).marginOnly(left: 5, right: 5),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  enlargeFactor: 0.0,
                  aspectRatio: 4.9 / 2,
                  viewportFraction: 0.6,
                  initialPage: 1,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged:
                      (int indexCarousel, CarouselPageChangedReason reason) {},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.carouselController.previousPage();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.whiteTrans1,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ).marginOnly(left: 5),
                  ),
                  InkWell(
                    onTap: () {
                      controller.carouselController.nextPage();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.whiteTrans1,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                      ),
                    ).marginOnly(right: 5),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  /// Our Celebrities
  transformationList() {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'transformation'.tr,
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 17.0,
            ),
          ).marginOnly(top: 10),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20.h,
            child: Stack(
              children: [
                PageView.builder(
                  controller: controller.pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (int page) {
                    controller.activePage.value = page;
                  },
                  itemCount: controller.transformationsModel.length,
                  // Divide by 2 to show two images per item
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        // Get.toNamed(AppPages.celebritiesScreen,
                                        //     arguments: [
                                        //       "Celebrities Details",
                                        //       // controller
                                        //       //     .transformationData[index].socialLink
                                        //     ]);

                                        print("sdhbjnkm==> ${controller
                                            .transformationsModel[index]
                                            .image}");

                                      },
                                      child: SizedBox(
                                        height: 300,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          child: Image.asset(
                                            controller
                                                .transformationsModel[index]
                                                .image
                                                .toString(),
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                color: AppColors.lightGrey,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.image_not_supported,
                                                    size: 60.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IntrinsicWidth(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),

                        color: AppColors.transparentBlack,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List<Widget>.generate(
                          controller.transformationsModel.length,
                          // Divide by 2
                          (index) => InkWell(
                            onTap: () {
                              controller.pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor:
                                  controller.activePage.value == index
                                      ? Colors.white
                                      : Colors.grey,
                            ),
                          ).marginOnly(left: 3, right: 3),
                        ),
                      ).marginOnly(top: 5, bottom: 5,left: 10,right: 10),
                    ),
                  ),
                ).marginOnly(bottom: 5),
              ],
            ),
          )
        ],
      ),
    );
  }

  pressList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'press'.tr,
          // style: TextStyle(
          //   fontSize: 18.0,
          //   fontWeight: FontWeight.w600
          // ),
          style: AppStyles.textStyle(
            weight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ).marginOnly(top: 10),
        const SizedBox(
          height: 10,
        ),
        Obx(() => !controller.pageLoaderFeaturedStatus.value
            ? SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: (controller.pressModel.length / 3).ceil(),
                  itemBuilder: (context, index) {
                    int startIndex = index * 3;
                    int endIndex = startIndex + 3;
                    if (endIndex > controller.pressModel.length) {
                      endIndex = controller.pressModel.length;
                    }

                    List<Widget> rowItems = [];

                    for (int i = startIndex; i < endIndex; i++) {
                      rowItems.add(Expanded(
                        child: pressWidget(
                          featuredData: controller.pressModel[i],
                        ),
                      ));
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: rowItems,
                    );
                  },
                ),
              )
            : shimmerDemo()),
      ],
    );
  }

  pressWidget({required PressModel featuredData}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppPages.celebritiesScreen,
            arguments: ["Press", featuredData.socialLink]);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.grayEB,
                // Adjust the color to your preference
                width: 1.0, // Adjust the border width
              ),
              // borderRadius: BorderRadius.circular(6),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                featuredData.image,
                fit: BoxFit.fitWidth,
              ),
            ),
          ).marginOnly(bottom: 15, left: 3, right: 3),
        ],
      ),
    );
  }

  ///  Simmer view loader

  shimmerDemo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
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
                    const SizedBox(
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
