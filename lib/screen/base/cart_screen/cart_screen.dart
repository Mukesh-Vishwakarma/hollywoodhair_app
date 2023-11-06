import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/screen/base/home_screen/home_controller.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shopify_flutter/models/models.dart';
import '../../../util/common_function.dart';
import '../base_home_controller.dart';
import 'cart_controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

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
            'cart'.tr,
            style: AppStyles.textStyle(
              weight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      backgroundColor: AppColors.lightBackgroundColor,
      body: bodyWidget(),
    );
  }

  bodyWidget() {
    return Obx(() => Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      color: AppColors.backGroundColor,
                      child: Obx(() => controller.dataLoading.isFalse
                          ? controller.noCartCreated.isFalse
                              ? (controller.checkout.lineItems.isNotEmpty)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          if (controller.sippingAddress.value)
                                            Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                addressWidget(),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Divider(),
                                              ],
                                            ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 10,
                                                left: 15,
                                                right: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
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
                                              ],
                                            ),
                                          )
                                        ])
                                  : Container(
                                      child: emptyCartWidget(),
                                    )
                              : Container(
                                  child: emptyCartWidget(),
                                )
                          : shimmerDemo()),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: controller.addressLoaderStatus.value,
              child: loader(AppColors.transparentBlack),
            ),
          ],
        ));
  }

  cartWidget() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.checkout.lineItems.length,
        itemBuilder: (context, index) {
          return cartItemWidget(controller.checkout.lineItems[index]);
        });
  }

  cartItemWidget(LineItem item) {
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
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title.toString(),
                    style: AppStyles.textStyle(
                      weight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    maxLines: 4,
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
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.grayDA)),
            child: Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (quantity.value == 1) {
                        quantity.value = 0;
                        controller.removeCartItems(item, quantity.value);
                      } else if (quantity > 1) {
                        quantity.value = quantity.value - 1;
                        controller.updateCartItemQuantity(
                            item, (quantity.value), '');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 10),
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
                      controller.updateCartItemQuantity(
                          item, (quantity.value), '');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 10),
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
              margin: const EdgeInsets.only(top: 20, left: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
            Expanded(
              child: Container(
                // width: 70.w,
                height: 45,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      contentPadding: const EdgeInsets.only(bottom: 10),
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
            ),
            InkWell(
              onTap: () {
                if (controller.promoCodeApplyStatus.value) {
                  successToast("Promo code already applied.");
                } else {
                  controller.applyPromoCode();
                }
              },
              child: Container(
                height: 44,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black84, width: 1.0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                      controller.promoCodeApplyStatus.value
                          ? 'applied'.tr
                          : 'apply'.tr,
                      style: AppStyles.textStyle(
                        weight: FontWeight.w500,
                        fontSize: 14.0,
                      )),
                ),
              ),
            ).marginOnly(left: 15),
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
        priceItemWidget(
            title: "subtotal".tr,
            value: controller.checkout.subtotalPriceV2.formattedPrice),
        const SizedBox(height: 10),
        priceItemWidget(
            title: 'discount'.tr,
            value: controller.checkout.totalTaxV2.formattedPrice),
        const SizedBox(height: 10),
        priceItemWidget(
            title: "shipping_cost".tr,
            value: controller.checkout.shippingLine?.priceV2.formattedPrice ??
                "zt0.00"),
        const SizedBox(height: 10),
        priceItemWidget(
            title: "tax".tr,
            value: controller.checkout.totalTaxV2.formattedPrice ?? "zt0.00"),
        const SizedBox(height: 10),
        priceItemWidget(
            title: "promo_code".tr,
            value: controller
                    .checkout.lineItems[0].discountAllocations.isNotEmpty
                ? "zt${controller.checkout.lineItems[0].discountAllocations[0].allocatedAmount!.amount.toString()}"
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

  priceItemWidget({title, value}) {
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    )),
                Text(controller.checkout.currencyCode.toString(),
                    style: AppStyles.textStyle(
                      weight: FontWeight.w400,
                      fontSize: 12.0,
                    )),
              ],
            ),
            InkWell(
              onTap: () async {
                try {
                  // await Get.put(CheckoutController());
                  // Get.toNamed(AppPages.checkout,
                  //     arguments: [controller.checkout.webUrl.toString()]);
                  controller.goToCheckout();
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
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

  emptyCartWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 11.h,
          ),
          SvgPicture.asset(Assets.emptyCart),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "empty_cart".tr,
            style: AppStyles.textStyle(
                family: "DINNeuzeitGrotes",
                fontSize: 26.0,
                weight: FontWeight.w500),
          ),
          SizedBox(
            height: 0.5.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0),
            child: Text(
              "empty_cart_message".tr,
              textAlign: TextAlign.center,
              style: AppStyles.textStyle(
                family: "DINNeuzeitGrotes",
                fontSize: 15.0,
                weight: FontWeight.w400,
                color: AppColors.colorE9,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          InkWell(
            onTap: () {
              // Get.toNamed(AppPages.allProductScreen, arguments: {
              //   "categoryName": "All ",
              //   "categoryId": "ALL",
              // });
              Get.find<BaseHomeController>().selectedIndex.value = 0;
              Get.find<HomeController>().onInit();
              Get.toNamed(AppPages.baseScreen);
            },
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

  addressWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Deliver to :",
                      style: TextStyle(fontSize: 13),
                    ),
                    Expanded(
                      child: Text(
                        controller.customerAddressName.value,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      controller.postelCode.value,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        controller.address1.value,
                        style: const TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      ("${controller.city.value},"),
                      style: const TextStyle(fontSize: 13),
                    ).marginOnly(left: 5, right: 5),
                    Text(
                      controller.country.value,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ).marginOnly(top: 5)
              ],
            ),
          ),
          InkWell(
            onTap: () {
              controller.getUserAddress("");
            },
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.searchBorderColor, width: 1.0),
                borderRadius: BorderRadius.circular(4),
              ),
              child: controller.shippingAddressStatus.value
                  ? const Text("Change")
                      .marginOnly(left: 10, right: 10, top: 5, bottom: 5)
                  : const Text("Add")
                      .marginOnly(left: 10, right: 10, top: 5, bottom: 5),
            ).marginOnly(left: 10),
          )
        ],
      ),
    );
  }
}
