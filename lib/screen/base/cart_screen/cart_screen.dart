import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopify_flutter/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../util/theme_service.dart';
import 'cart_controller.dart';

class CartScreen extends GetView<CartController> {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
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
                () => controller.dataLoading.isFalse
                    ? controller.noCartCreated.isFalse
                        ? (controller.checkout.lineItems.isNotEmpty)?Column(
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
                              ]):  Container(
                  child: emptyCartWidget(),

                )
                        :  const SizedBox()
                    : shimmerDemo()
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
    RxInt quantity = (item.quantity).obs;
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
                width: 70,
                height: 70,
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
                  Text(
                    item.variant!.product!.compareAtPriceFormatted.toString(),
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
            child: Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (quantity == 1) {
                        quantity.value = 0;
                        controller.removeCartItems(item, quantity.value);
                      } else if (quantity > 1) {
                        quantity.value = quantity.value - 1;
                        controller.updateCartItemQuantity(
                            item, (quantity.value));
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                      child: SvgPicture.asset(Assets.minusIcon, width: 10),
                    ),
                  ),
                  Text(quantity.value.toString(),
                      style: AppStyles.textStyle(
                        weight: FontWeight.w500,
                        fontSize: 14.0,
                      )),
                  InkWell(
                    onTap: () {
                      quantity.value = quantity.value + 1;
                      controller.updateCartItemQuantity(item, (quantity.value));
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                      child: SvgPicture.asset(Assets.plusIcon, width: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.removeCartItems(item, quantity.value);
            },
            child: Container(
              margin: EdgeInsets.only(top: 30, left: 20),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.grayDA)),
              child: SvgPicture.asset(
                Assets.trashIcon,
                width: 17,
                height: 17.5,
              ),
            ),
          ),
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
              weight: FontWeight.w500,
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
                  textCapitalization: TextCapitalization.characters,
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
            InkWell(
              onTap: () {
                // controller.applyPromoCode();
              },
              child: Container(
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
              weight: FontWeight.w500,
              fontSize: 16.0,
            )),
        const SizedBox(height: 20),
        priceitemWidget(
            title: "subtotal".tr,
            value: controller.checkout.subtotalPriceV2.formattedPrice),
        const SizedBox(height: 10),
        priceitemWidget(
            title: 'discount'.tr,
            value: controller.checkout.totalTaxV2.formattedPrice),
        const SizedBox(height: 10),
        priceitemWidget(
            title: "shipping_cost".tr,
            value: controller.checkout.shippingLine?.priceV2.formattedPrice ??
                "zt0.00"),
        const SizedBox(height: 10),
        priceitemWidget(
            title: "tax".tr,
            value: controller.checkout.totalTaxV2.formattedPrice ?? "zt0.00"),
        const SizedBox(height: 10),
        priceitemWidget(
            title: "promo_code".tr,
            value: controller.checkout.appliedGiftCards.isNotEmpty
                ? controller.checkout.appliedGiftCards[0].amountUsedV2.formattedPrice
                : "zt0.00"),
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
              controller.checkout.totalPriceV2.formattedPrice,
              style: AppStyles.textStyle(
                weight: FontWeight.w500,
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
      onTap: () {},
      child: Container(
        color: AppColors.lightBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.checkout.totalPriceV2.amount.toString(),
                    style: AppStyles.textStyle(
                      weight: FontWeight.w700,
                      fontSize: 17.0,
                    )),
                Text(controller.checkout.currencyCode.toString(),
                    style: AppStyles.textStyle(
                      weight: FontWeight.w500,
                      fontSize: 12.0,
                    )),
              ],
            ),
            InkWell(
              onTap: () {
                try {
                  launchUrl(Uri.parse(controller.checkout.webUrl.toString()));
                } catch (e, s) {
                  print(s);
                }
              },
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }

  emptyCartWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 11.h,),
          SvgPicture.asset(Assets.emptyCart),
          SizedBox(height: 2.h,),
          Text("empty_cart".tr,
            style: AppStyles.textStyle(
                family: "DINNeuzeitGrotes",
                fontSize: 26.0,
                weight: FontWeight.w500
            ),),
          SizedBox(height: 0.5.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0),
            child: Text("empty_cart_message".tr,
              textAlign: TextAlign.center,
              style: AppStyles.textStyle(
                family: "DINNeuzeitGrotes",
                fontSize: 15.0,
                weight: FontWeight.w400,
                color: AppColors.grayE9,
              ),),
          ),
          SizedBox(height: 15.h,),
          InkWell(
            onTap: (){
              Get.toNamed(AppPages.allProductScreen, arguments: {
                "categoryName": "All ",
                "categoryId": "ALL",
              });            },
            child: Container(
              width: 100.w,
              height: 48,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border:
                  Border.all(color: AppColors.primaryColor, width: 1.0)),
              child: Center(
                child: Text(
                  'start_shopping'.tr,
                  style: AppStyles.textStyle(
                      family: "DINNeuzeitGrotes",
                      weight: FontWeight.w500,
                      fontSize: 16.0,
                      color: AppColors.lightBackgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  shimmerDemo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 100.w,
        height: 100.h,
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
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
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
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
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
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
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
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
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
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
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
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
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
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
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
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 10.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 8,
                                color: Colors.white,
                              ),
                              const Spacer(),
                              Container(
                                width: 70.0,
                                height: 8,
                                color: Colors.white,
                              ),
                            ],
                          ),
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
