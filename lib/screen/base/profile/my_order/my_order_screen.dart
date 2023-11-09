import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hollywood_hair/util/app_colors.dart';
import 'package:hollywood_hair/util/app_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shopify_flutter/models/src/order/line_item_order/line_item_order.dart';
import 'package:shopify_flutter/models/src/order/order.dart';
import '../../../../util/common_function.dart';
import 'my_order_controller.dart';

class MyOrderScreen extends GetView<MyOrderController> {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
    ));
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: AppBar(
          elevation: 0.4,
          titleSpacing: 0,
          backgroundColor: AppColors.colorFF,
          leading: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50), // Set the same rounded border as Material
            ),
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.black,
            ),
          ),
          title: Text(
            "my_orders".tr,
            style: AppStyles.textStyle(
              fontSize: 16.0,
              weight: FontWeight.w500,
            ),
          ),
          automaticallyImplyLeading: false,
          // actions: [
          //   GestureDetector(
          //     onTap: () {
          //       Get.toNamed(AppPages.favouriteScreen);
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.only(right: 20.0),
          //       child: SvgPicture.asset(Assets.favouriteIcon),
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.only(right: 20.0),
          //     child: SvgPicture.asset(Assets.searchIcon),
          //   ),
          //   GestureDetector(
          //     onTap: () {
          //       Get.toNamed(AppPages.allProductScreen);
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.only(right: 20.0),
          //       child: SvgPicture.asset(Assets.notificationIcon),
          //     ),
          //   ),
          // ],
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: (!controller.orderStatus.value)
              ? ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: controller.orderlist.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return commonListTile(
                        orderItem:
                            controller.orderlist[index]);
                  })
              : shimmerDemo(),
        ),
      ),
    );
  }

  Widget commonListTile({required Order orderItem}) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      padding: const EdgeInsets.all(15),
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
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order ID:",
                    style: AppStyles.textStyle(
                      color: AppColors.grey5c,
                      fontSize: 12.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    orderItem.name.toString(),
                    style: AppStyles.textStyle(
                      color: AppColors.black,
                      fontSize: 12.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Delivered",
                    style: AppStyles.textStyle(
                      color: AppColors.color57C,
                      fontSize: 12.0,
                      weight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    controller.dateConvert(orderItem.processedAt.toString()),
                    style: AppStyles.textStyle(
                      color: AppColors.grey5c,
                      fontSize: 12.0,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          DottedLine(
            dashColor: AppColors.black04.withOpacity(0.10),
          ),
          const SizedBox(height: 10),
          Text(
            orderItem.billingAddress!.name.toString(),
            style: AppStyles.textStyle(
              color: AppColors.black33,
              fontSize: 14.0,
              weight: FontWeight.w500,
            ),
          ),
          Text(
            orderItem.email.toString(),
            style: AppStyles.textStyle(
              color: AppColors.black33,
              fontSize: 14.0,
              weight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          DottedLine(
            dashColor: AppColors.black04.withOpacity(0.10),
          ),
          const SizedBox(height: 10),
          ListView.builder(
              shrinkWrap: true,
              reverse: false,
              itemCount: orderItem.lineItems.lineItemOrderList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return productTile(orderItem.lineItems.lineItemOrderList[index]);
              }),
        ],
      ),
    );
  }

  Widget productTile(LineItemOrder lineItem) {
    return InkWell(
      onTap: (){

        // print("sajdhnjs==> ${lineItem.variant!.product.toString()}");
        // Get.toNamed(
        //   AppPages.allProductDetailsScreen,
        //   arguments: {"product_id": "gid://shopify/Product/47337290334543"},
        //   // arguments: {"product_id": "gid://shopify/product/47337290334543"},
        // );
        // // controller.getFindController();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                lineItem.variant!.image!.originalSrc.toString(),
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              )),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                lineItem.title.toString(),
                style: AppStyles.textStyle(
                  weight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          // const Icon(Icons.navigate_next),
        ],
      ).marginOnly(bottom: 10),
    );
  }
}
