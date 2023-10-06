import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:hollywood_hair/util/assets.dart';
import 'package:hollywood_hair/util/res_dimens.dart';
import 'package:hollywood_hair/util/route/app_pages.dart';
import 'package:shopify_flutter/models/src/order/line_items_order/line_items_order.dart';
import 'package:shopify_flutter/models/src/order/order.dart';
import 'package:sizer/sizer.dart';

import 'my_order_controller.dart';

class MyOrderScreen extends GetView<MyOrderController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
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
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                )),
            title: Text("my_orders".tr,
                style: AppStyles.textStyle(
                    fontSize: dimen14, weight: FontWeight.w500)),
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppPages.favouriteScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SvgPicture.asset(Assets.favouriteIcon),
                ),
              ),
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
        body: SingleChildScrollView(
          child: Obx(() => controller.dataLoading.isFalse
              ? controller.nodatafound.isFalse
                  ? orderListView()
                  : const SizedBox()
              : const SizedBox()),
        ));
  }

  orderListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.myOrder!.length,
        itemBuilder: (context, index) {
          return commonListTile(
              orderItem: controller.myOrder![index], index: index);
        });
  }

  commonListTile({required Order orderItem, index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            padding: EdgeInsets.all(15),
            width: Get.size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.colorD9,
                width: 1.0,
              ),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order ID:",
                            style: AppStyles.textStyle(
                                color: AppColors.grey5c,
                                fontSize: 12.0,
                                weight: FontWeight.w400)),
                        Text(orderItem.name.toString(),
                            style: AppStyles.textStyle(
                                color: AppColors.black,
                                fontSize: 12.0,
                                weight: FontWeight.w500)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Delivered",
                            style: AppStyles.textStyle(
                                color: AppColors.color57C,
                                fontSize: 12.0,
                                weight: FontWeight.w400)),
                        Text(
                            controller
                                .dateConvert(orderItem.processedAt.toString()),
                            style: AppStyles.textStyle(
                                color: AppColors.grey5c,
                                fontSize: 12.0,
                                weight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DottedLine(
                  dashColor: AppColors.black04.withOpacity(0.10),
                ),
                const SizedBox(height: 10),
                Text(orderItem.billingAddress!.name.toString(),
                    style: AppStyles.textStyle(
                        color: AppColors.black33,
                        fontSize: 14.0,
                        weight: FontWeight.w500)),
                Text(orderItem.billingAddress!.phone ?? "",
                    style: AppStyles.textStyle(
                        color: AppColors.black33,
                        fontSize: 12.0,
                        weight: FontWeight.w400)),
                Text(orderItem.lineItems!.toString(),
                    // orderItem.email.toString(),
                    // overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyle(
                        color: AppColors.gray99,
                        fontSize: 12.0,
                        weight: FontWeight.normal)),
                const SizedBox(height: 10),
                DottedLine(
                  dashColor: AppColors.black04.withOpacity(0.10),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                    shrinkWrap: false,
                    itemCount: orderItem.lineItems!.lineItemOrderList.length,
                    itemBuilder: (context, index) {
                      return productTile(orderItem.lineItems);
                    })
              ],
            ))
      ],
    );
  }

  productTile(LineItemsOrder lineItemsOrder) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // children: [Image.network(lineItemsOrder.lineItemOrderList[0].i)],
        )
      ],
    );
  }
}
