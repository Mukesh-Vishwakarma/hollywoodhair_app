import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:sizer/sizer.dart';

import 'cart_controller.dart';

class CartScreen extends GetView<CartController> {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: AppBar(
          elevation: 0.4,
          backgroundColor: AppColors.colorFF,
          title: Text(
            "${'cart'.tr}",
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                  onTap: () {
                    Get.toNamed(AppPages.favouriteScreen);
                  },
                  child: SvgPicture.asset(Assets.searchIcon)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(Assets.notificationIcon)),
            ),
          ],
        ),
      ),
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
              child: Obx(
                () => controller.noCartCreated.isFalse
                    ? controller.dataLoading.isFalse
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                cartWidget(),
                                const SizedBox(
                                  height: 20,
                                ),
                                promoCodeWidget(),
                                const SizedBox(
                                  height: 20,
                                ),
                                priceDetailWidget(),
                                const SizedBox(
                                  height: 20,
                                ),
                                orderButton(),
                              ])
                        : const SizedBox()
                    : const SizedBox(),
              ),
            )
          ],
        ),
      ),
    );
  }

  cartWidget() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.checkout.lineItems.length,
        itemBuilder: (context, index) {
          return cartitemWidget(controller.checkout.lineItems[index]);
        });
  }

  cartitemWidget(LineItem item) {
    print(item);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.variant!.image!.originalSrc,
                width: 22.w,
                height: 10.h,
                fit: BoxFit.cover,
              )),
          Expanded(
            child: Container(
              width: 55.w,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title.toString(),
                    style: AppStyles.textStyle(
                      weight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.grayDA)),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                  child: SvgPicture.asset(Assets.minusIcon),
                ),
                Text(item.quantity.toString(),
                    style: AppStyles.textStyle(
                      weight: FontWeight.w500,
                      fontSize: 12.0,
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                  child: SvgPicture.asset(Assets.plusIcon),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  promoCodeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('promo_code'.tr,
            style: AppStyles.textStyle(
              weight: FontWeight.w600,
              fontSize: 16.0,
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 70.w,
              height: 49,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.promoborder, width: 1.0),
                color: AppColors.promofilled,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: TextFormField(
                  controller: controller.promoCodeController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10),
                    hintText: "HHGLAMOUR15",
                    hintStyle: AppStyles.textStyle(
                        // fontStyle: FontStyle.italic,
                        color: AppColors.promoHint.withOpacity(0.34),
                        fontSize: 14.0,
                        weight: FontWeight.w400),
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  cursorColor: AppColors.primaryColor,
                  style: AppStyles.textStyle(
                      // fontStyle: FontStyle.italic,
                      color: AppColors.promoHint,
                      fontSize: 14.0,
                      weight: FontWeight.w400),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black84, width: 1.0),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text('apply'.tr,
                    style: AppStyles.textStyle(
                      weight: FontWeight.w500,
                      fontSize: 14.0,
                    )),
              ),
            )
          ],
        )
      ],
    );
  }

  priceDetailWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('price_details'.tr,
            style: AppStyles.textStyle(
              weight: FontWeight.w600,
              fontSize: 16.0,
            )),
        const SizedBox(height: 20),
        priceitemWidget(title: "subtotal".tr, value: "zł 457"),
        const SizedBox(height: 10),
        priceitemWidget(title: 'discount'.tr, value: "zł 00"),
        const SizedBox(height: 10),
        priceitemWidget(title: "shipping_cost".tr, value: "zł 15"),
        const SizedBox(height: 10),
        priceitemWidget(title: "tax".tr, value: "zł 3"),
        const SizedBox(height: 10),
        priceitemWidget(title: "promo_code".tr, value: "zł 3"),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'grand_total'.tr,
              style: AppStyles.textStyle(
                weight: FontWeight.w500,
                fontSize: 12.0,
              ),
            ),
            Text(
              "zł 400",
              style: AppStyles.textStyle(
                weight: FontWeight.w600,
                fontSize: 12.0,
              ),
            ),
          ],
        )
      ],
    );
  }

  priceitemWidget({title, value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyles.textStyle(
            weight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
        Text(
          value,
          style: AppStyles.textStyle(
            weight: FontWeight.w500,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }

  orderButton() {
    return InkWell(
      onTap: () {
        controller.addItemToCart(
            "f9605f50addfe070acbc1a29120df7c5", 47139383050575, 2);
      },
      child: Container(
        color: AppColors.lightBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1199.6',
                    style: AppStyles.textStyle(
                      weight: FontWeight.w700,
                      fontSize: 17.0,
                    )),
                Text('PLN',
                    style: AppStyles.textStyle(
                      weight: FontWeight.w500,
                      fontSize: 12.0,
                    )),
              ],
            ),
            Container(
              width: 70.w,
              height: 52,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: AppColors.primaryColor, width: 1.0)),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              child: Center(
                child: Text(
                  'order_now'.tr,
                  style: AppStyles.textStyle(
                      weight: FontWeight.w500,
                      fontSize: 16.0,
                      color: AppColors.lightBackgroundColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
