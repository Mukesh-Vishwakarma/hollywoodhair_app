import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:sizer/sizer.dart';

import 'all_product_controller.dart';

class AllProductScreen extends GetView<AllProductController> {
  AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ));
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: AppBar(
          elevation: 0.4,
          backgroundColor: AppColors.colorFF,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: AppColors.black,
              )),
          title: Text("all_products".tr,
              style:
                  AppStyles.textStyle(fontSize: 14.0, weight: FontWeight.w500)),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset(Assets.favouriteIcon),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset(Assets.searchIcon),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset(Assets.notificationIcon),
            ),
          ],
        ),
      ),
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
              color: AppColors.backGroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  productsWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  productsWidget() {
    return Container(
      color: AppColors.dividerColor,
      child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.productList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 3,
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1),
          itemBuilder: (context, index) {
            return commonProductWidget(product: controller.productList[index]);
          }),
    );
  }

  commonProductWidget({product}) {
    return Container(
      width: 47.w,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      color: AppColors.white,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                    width: 45.w,
                    height: 23.h,
                  )),
              Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: AppColors.white, shape: BoxShape.circle),
                    child: SvgPicture.asset(Assets.favouriteIcon),
                  )),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            product.title,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          Row(
            children: [
              Text(
                product.price,
                style: AppStyles.textStyle(
                  weight: FontWeight.w500,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                product.oldPrice,
                style: AppStyles.textStyle(
                    weight: FontWeight.w400,
                    fontSize: 11.0,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.gray95),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
