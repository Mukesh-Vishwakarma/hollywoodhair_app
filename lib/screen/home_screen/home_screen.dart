import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:sizer/sizer.dart';

import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ));
    return Scaffold(
      backgroundColor: AppColors.white,
      body: bodyWidget(),
    );
  }

  bodyWidget() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          appBar(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                ),
                const SizedBox(height: 20),
                categoriesListWidget(),
                const SizedBox(height: 20),
                productsWidget(),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  appBar() {
    return Container(
      height: 8.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 7,
            offset: Offset(-0.10, 0.5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(Assets.favouriteIcon),
                const SizedBox(
                  width: 18,
                ),
                SvgPicture.asset(Assets.notificationIcon),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          ]),
    );
  }

  searchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
          color: AppColors.backGroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.searchBorderColor, width: 1.0)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
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
                  controller: controller.searchController,
                  onChanged: (value) {
                    // text = value;
                  },
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

  productsWidget() {
    return Column(children: [
      Text(
        'popular_product'.tr,
        style: AppStyles.textStyle(
          weight: FontWeight.w600,
          fontSize: 16.0,
        ),
      ),
    ]);
  }

  commonProductWidget() {
    return Container();
  }

  categoriesListWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'explore_by_categories'.tr,
          style: AppStyles.textStyle(
            weight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 50,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.categoriesList.length,
            itemBuilder: (context, index) {
              return Obx(() => categoriesWidget(
                  categoryItem: controller.categoriesList.value[index]));
            },
          ),
        ),
      ],
    );
  }

  categoriesWidget({categoryItem}) {
    return InkWell(
      onTap: () {
        print(categoryItem.selected);
        categoryItem.selected = !categoryItem.selected;
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: categoryItem.selected == true
                ? AppColors.primaryColor
                : AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primaryColor, width: 1.0)),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        child: Center(
          child: Text(
            categoryItem.value,
            style: AppStyles.textStyle(
                weight: FontWeight.w500,
                fontSize: 14.0,
                color: categoryItem.selected == true
                    ? AppColors.white
                    : AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

}
